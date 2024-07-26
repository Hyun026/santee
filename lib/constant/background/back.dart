import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/notifications/noti.dart';
import 'package:sante_en_poche/constant/notifications/notification.dart';

class Back extends StatelessWidget {
  final Widget child;
  final bool useAppBar;
  const Back( {Key? key,
      required this.child,
      this.useAppBar = true,
     })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarWidget;
    if (useAppBar == true) {
      appBarWidget = AppBar(
        elevation: 0,
        leading: IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Retour',
          style: TextStyle(color: Colors.white, fontSize: 25.sp),
        ),
        backgroundColor: Colors.transparent,
        actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.notifications),
          onPressed: ()async {
              final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
             User? user = _auth.currentUser;
          
              if (user != null) {
               
                DocumentSnapshot userDoc =
                    await _firestore.collection('users').doc(user.uid).get();
                 DocumentSnapshot userDocT =
                    await _firestore.collection('doctors').doc(user.uid).get();
          
                if (userDoc.exists) {
                
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60.0, right: 10.0),
                          child: NotificationDialog(),
                        ),
                      );
                    },
                  );
                } else if(userDocT.exists) {
                   showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: 60.0, right: 10.0),
                          child: const MyNoti(),
                        ),
                      );
                    },
                  );
                
                 
                }
              }
            
          
           
          },
        ),
      ),
    ],
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff3C7CDC),
                  Color(0Xff8BC2F8),
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
          child,
        ]
      ),
     

    );
    
  }
}