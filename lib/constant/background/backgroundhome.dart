import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sante_en_poche/constant/background/background.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/screens/login/login.dart';
//background for home
class MyBackgroundHome extends StatelessWidget {
  final Widget child;

  MyBackgroundHome({Key? key, required this.child}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
  
   return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  MyColors.backgroundColor1,
                  MyColors.backgroundColor2,
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(
              'assets/images/background/Intersection 1.svg',
             
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Votre Santé',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                  ),
                ),
                Text(
                  'au bout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                  ),
                ),
                Text(
                  "d'1 Clic",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                  ),
                ),
              ],
            ),
          ),
   
   

          Padding(
            padding: EdgeInsets.symmetric(vertical: 110.h),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  onPressed: () async {
                  User? user = _auth.currentUser;
                  if (user != null) {
                    try {
                  
                      DocumentReference userDocRef = firestore.collection('users').doc(user.uid);
                      DocumentReference doctorDocRef = firestore.collection('doctors').doc(user.uid);
                      
                  
                      var userDoc = await userDocRef.get();
                      if (userDoc.exists) {
                        await userDocRef.update({'online': false});
                        print("Updated online status in users collection");
                      } else {
                        print("User document not found in 'users' collection");
                      }
                      
                      
                      var doctorDoc = await doctorDocRef.get();
                      if (doctorDoc.exists) {
                        await doctorDocRef.update({'online': false});
                        print("Updated online status in doctors collection");
                      } else {
                        print("Doctor document not found in 'doctors' collection");
                      }

                      await _auth.signOut();
                      print("Signed out successfully");

                
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBackground(
                            child: MyLogin(),
                          ),
                        ),
                      );
                    } catch (e) {
                      print("Error during sign out: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error signing out. Please try again.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300.w, 50.h),
                foregroundColor: Colors.white,
                backgroundColor: MyColors.logoutButton,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
            'Se déconnecter',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
                    ),
                    SizedBox(width: 20.w),
                    SvgPicture.asset('assets/images/home/icons8_logout_rounded_up.svg')
                  ],
                ),
              ),
            )
            
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      
                
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: SvgPicture.asset(
                          "assets/images/confirmer/icons8_headset.svg",
                          height: 50.h, 
                          width: 30.w,  
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Assistance",
                            style: TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          Text(
                            '0522 30 60 60',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 50.h,
                    width: 50.w,
                    decoration: const BoxDecoration(
                      color: MyColors.navy,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/home/icons8_medical_doctor.svg',
                        height: 30.h, 
                        width: 30.w,  
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
       
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox.expand(
                child: child, 
              ),
            ),
          ),
        ],
      ),
    );
  }
}