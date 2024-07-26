import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

   final FirebaseFirestore firestore = FirebaseFirestore.instance;


 
  Future<User?> register(String email,String password, BuildContext context) async {
    try{
   UserCredential userCredential =  
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password, );
    return userCredential.user;
    }on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
   return null;

    }catch (e){
      print(e);
      return null;
    }
  }
   
  Future<User?> login(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      if (user != null) {
       
        DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();

        String collection = userDoc.exists ? 'users' : 'doctors'; 

        // Update online status
        await firestore.collection(collection).doc(user.uid).update({'online': true});
      }
      return user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
  //check if email exists in the firebase
 