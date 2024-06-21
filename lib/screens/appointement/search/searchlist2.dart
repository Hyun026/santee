import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Mydocs extends StatefulWidget {
  const Mydocs({super.key});

  @override
  State<Mydocs> createState() => _MydocsState();
}

class _MydocsState extends State<Mydocs> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;

  Future<void> uploadImage(String inputSource)async{
    final picker =ImagePicker();
    final XFile? pickedImage = await  picker.pickImage(source: inputSource == 'camera'? ImageSource.camera : ImageSource.gallery);
    if(pickedImage == null){
      return null;
    }
    String fileName = pickedImage.name;
    File imageFile = File(pickedImage.path);

    try{
      setState(() {
        loading = true;
      });
      TaskSnapshot snapshot = await firebaseStorage.ref(fileName).putFile(imageFile);
      String downloadURL = await snapshot.ref.getDownloadURL();

      // Save the download URL to Firestore
       User? user = auth.currentUser;
       
      if (user == null) {
        throw FirebaseAuthException(
          code: 'USER_NOT_LOGGED_IN',
          message: 'User is not logged in.',
        );
      }
      String userId = user.uid;
      await firestore.collection('users').doc(userId).update({
        'profileImageURL': downloadURL,
      });
    // await  firebaseStorage.ref(fileName).putFile(imageFile);
     setState(() {
       loading = false;
     });
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success')));
    }on FirebaseException catch (e){
      print(e);

    }catch (error){
      print(error);
    }
  }

 
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         loading? Center(child: CircularProgressIndicator(),):Row(
            children: [
              ElevatedButton.icon(onPressed: (){
                uploadImage("camera");
              }, icon: Icon(Icons.camera), label: Text('camera')),
              ElevatedButton.icon(onPressed: () {
                uploadImage("gallery");
              }, icon: Icon(Icons.library_add), label: Text("gallery")),
                ElevatedButton(
                onPressed: () => uploadImage('gallery'),
                child: Text('Upload Image'),
              ),
            ],
          )

        ],
      ) ,);
  }
}