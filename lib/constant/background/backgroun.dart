import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/constant/notifications/noti.dart';
import 'package:sante_en_poche/constant/notifications/notification.dart';
import 'package:sante_en_poche/screens/appointement/search/searchlist.dart';


class Backmain extends StatefulWidget {
  final Widget child;
  final bool useAppBar;
  const Backmain( {Key? key,
      required this.child,
      this.useAppBar = true,
     })
      : super(key: key);

  @override
  State<Backmain> createState() => _BackmainState();
}

class _BackmainState extends State<Backmain> {
     final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeUnreadCount();
     _initializeUnreadCountD();
  }
// for patient
  Future<void> _initializeUnreadCount() async {
    user = _auth.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('notiPat')
          .where('user', isEqualTo: user!.uid)
          .where('isRead', isEqualTo: false)
          .get();
      setState(() {
        unreadCount = querySnapshot.docs.length;
      });
    }
  }

  //for doctor
  Future<void> _initializeUnreadCountD() async {
    user = _auth.currentUser;
    if (user != null) {
      final querySnapshot = await _firestore
          .collection('notiDoc')
          .where('user', isEqualTo: user!.uid)
          .where('isRead', isEqualTo: false)
          .get();
      setState(() {
        unreadCount = querySnapshot.docs.length;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarWidget;
    if (widget.useAppBar == true) {
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
              icon: Stack(
                children: [
                  Icon(Icons.notifications),
                  if (unreadCount > 0)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '$unreadCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
              onPressed: () async {
                user = _auth.currentUser;
                if (user != null) {
                  DocumentSnapshot userDoc =
                      await _firestore.collection('users').doc(user!.uid).get();
                  DocumentSnapshot userDocT =
                      await _firestore.collection('doctors').doc(user!.uid).get();

                  if (userDoc.exists) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0, right: 10.0),
                            child: NotificationDialog(
                              onNotificationsRead: _initializeUnreadCount,
                            ),
                          ),
                        );
                      },
                    );
                  } else if (userDocT.exists) {
                       showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(top: 60.0, right: 10.0),
                            child: MyNoti(
                              onNotificationsRead: () {
                                _initializeUnreadCountD(); 
                                
                              },
                            ),
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
          widget.child,
        ]
      ),
     floatingActionButton: FloatingActionButton(
          onPressed: () {
             Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Back(useAppBar: true,
                            child: MyMainPage()) ),
                        );
          },
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0)),
          backgroundColor: Colors.white,
          child: const Icon(Icons.add,color: Colors.blue,),
        ),

    );
    
  }
}