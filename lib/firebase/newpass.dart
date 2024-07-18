 import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class PassReset {
  Future<void> passwordReset(String email) async {
    try{
       await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    }on FirebaseAuthException catch (e){
      print(e);
    }
   
  }
final FirebaseAuth _auth = FirebaseAuth.instance;


   Future<void> sendVerificationCode(String email) async {
    try {
      
      // ignore: deprecated_member_use
      List<String> methods = await _auth.fetchSignInMethodsForEmail(email);
      if (methods.isNotEmpty) {
        print('Email $email is already registered');
       
        return;
      }

      int code = Random().nextInt(9000) + 1000;
    
      print('Generated code for $email: $code');
     
      print('Email sent to $email with verification code: $code');
    } catch (e) {
      print('Error occurred: $e');
   
    }
  }

  Future<bool> verifyCode(String email, int code) async {
    
    int generatedCode = Random().nextInt(9000) + 1000; 
    bool isValid = code == generatedCode;
    if (isValid) {
      await _auth.currentUser!.updateEmail(email);
      print('Email address $email verified successfully');
    } else {
      print('Invalid verification code');
    }
    return isValid;
  }
/*
  Future<bool> isEmailRegistered(String email) async {
  try {
    // Get a reference to the users node in the database

    final DatabaseReference usersRef = FirebaseDatabase.instance.reference().child('users');

    // Retrieve the list of users
    final DataSnapshot snapshot = (await usersRef.once()) as DataSnapshot;

    // Check if the email matches any of the user emails 
    if (snapshot.value != null) {
      final Map<dynamic, dynamic>? users = snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        for (final userKey in users.keys) {
          final user = users[userKey] as Map<dynamic, dynamic>;
          if (user['email'] == email) {
            return true;
          }
        }
      }
    }
    return false;
  } catch (e) {
    print('Error occurred while checking email existence: $e');
    return false;
  }
  }*/
}