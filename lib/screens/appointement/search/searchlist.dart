import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sante_en_poche/firebase/imageadd.dart';



class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
 
  Uint8List? image;

  Future <void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
      
    }
  }

  Future<void>saveProfile() async {
    if (image == null) {
      print('No image selected');
      return;
    }
   String resp = await StoreData().saveData(file: image! ,);
    if (resp == 'success') {
      print('Profile updated successfully');
    } else {
      print('Failed to update profile: $resp');
    }
  }

  //for the profile
  /*
  String image="";

   @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      image = prefs.getString("imageLink")!;
    });
  }
*/


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
      radius: 50,
      backgroundImage: image != null ? MemoryImage(image!) : null,
      child: image == null
          ? GestureDetector(
              onTap: () async {
        await selectImage();
        await saveProfile();
      },     
              child: CircleAvatar(
                radius: 50,
                child: SvgPicture.asset('assets/images/search/avatar-people-profile-svgrepo-com.svg'),
              /*  backgroundImage:image.isNotEmpty ? NetworkImage(image) : null,
          child: image.isEmpty ?  Icon(Icons.person, size: 50)  : null*/
          //,
              ),
            )
          : null,
    ),
                    Column(
                      children: [
                        Text('Bienvenue'),

                      ],
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
/*

class UserD {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference?> getUserDocumentReference() async {
    // Ensure user is authenticated
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No authenticated user.');
      return null;
    }

    print('Authenticated User UID: ${user.uid}');  // Debug print

    // Query to find the document with this user ID
    QuerySnapshot querySnapshot = await _firestore
        .collection("users")
        .where('userId', isEqualTo: user.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentReference docRef = querySnapshot.docs.first.reference;
      print('Document found with ID: ${docRef.id}');
      return docRef;
    } else {
      print('No document found for user ID: ${user.uid}');
      return null;
    }
  }
}
*/