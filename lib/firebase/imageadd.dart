import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:sante_en_poche/screens/appointement/search/searchlist.dart';

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('no images selected');
}

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    try {
      Reference ref =
          _storage.ref().child(childName).child(DateTime.now().toString());
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

      Future<DocumentReference?> getUserDocumentReference() async {
        // Ensure user is authenticated
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          print('No authenticated user.');
          return null;
        }

        print('Authenticated User UID: ${user.uid}'); // Debug print

        // Query to find the document with this user ID
        QuerySnapshot querySnapshot = await _firestore
            .collection("users")
            .where('userId', isEqualTo: user.uid)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          print('Document found with ID: ${docRef.id}');
          if (docRef != null) {
            print('Document exists, updating...'); // Debug print
            await docRef.update({
              'imageLink': imageUrl,
            });
          } else {
            // If document reference is null, handle as needed
            print('No document found for current user.');
          }
          response = 'success';
          return docRef;
        } else {
          print('No document found for user ID: ${user.uid}');
          return null;
        }
      }
    } catch (err) {
      print('Error: $err'); // Debug print
      response = err.toString();
    }
    return response;
  }
}
