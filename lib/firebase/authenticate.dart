import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
   String _verificationId = '';

 
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
   
  Future<User?> login(String email,String password, BuildContext context) async{
    try{
    UserCredential userCredential =
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
    } on FirebaseAuthException catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()),backgroundColor: Colors.red,));
    return null;
    }catch(e){
    print(e);
    return null;
    }


  }

  //check if email exists in the firebase
  Future<bool> doesEmailExist(String email) async {
  try {
   
    var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    return methods.isNotEmpty; 
  } catch (e) {
 
    print('Error: $e');
    return false;
  }
}

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print('Error sending password reset email: $e');
      throw e; 
    }
  }
/*
Future<bool> verifyOTP(String otp) async {
    try {
     
      final credential = EmailAuthCredential.credential(
        verificationId: _verificationId,
        smsCode: otp,
      );
      await firebaseAuth.signInWithCredential(credential);
      return true;
    } catch (e) {
      print('Failed to verify OTP: $e');
      return false;
    }
  }*/




  Future<void> verifyEmail(String email,BuildContext context) async {
    try {
      User? user = firebaseAuth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Verification email sent to ${user.email}'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print('Error sending email verification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send verification email'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  /*
  Future<User?> code(String code, BuildContext context) async {
  try {
    UserCredential userCredential = await firebaseAuth.verifyPasswordResetCode(code);
    User? user = userCredential.user;
    
    return user;
  } catch (e) {
   
    print('Error verifying password reset code: $e');
   
    return null;
  }
}*/

}


/*lalalalal


ghjdfkdkkled














*/