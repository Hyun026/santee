import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sante_en_poche/screens/appointement/search/searchlist.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Function to pick an image
Future<Uint8List?> pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('No images selected');
  return null;
}

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref = _storage.ref().child(childName).child(DateTime.now().toString());
      UploadTask uploadTask = ref.putData(file);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<String> saveData({required Uint8List file}) async {
    String response = "Some Error Occurred";

    try {
      // Upload the image and get its URL
      String imageUrl = await uploadImageToStorage('ProfileImage', file);

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      final FirebaseAuth _auth = FirebaseAuth.instance;

      User? user = _auth.currentUser;

      if (user != null) {
        DocumentReference docRef = _firestore.collection('users').doc(user.uid);

        DocumentSnapshot docSnapshot = await docRef.get();

        if (docSnapshot.exists) {
          print('Document exists, updating...'); // Debug print
          await docRef.update({
            'imageLink': imageUrl,
          });
          // Save the new image link to SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("imageLink", imageUrl);

          response = 'success';
        } else {
          print('No document found for current user.');
          response = 'No document found for current user.';
        }
      } else {
        print('No user is currently signed in.');
        response = 'No user is currently signed in.';
      }
    } catch (err) {
      print('Error: $err'); // Debug print
      response = err.toString();
    }

    return response;
  }
}