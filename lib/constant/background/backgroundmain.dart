
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:sante_en_poche/constant/background/background.dart';
import 'package:sante_en_poche/constant/background/backgroundmulti.dart';

import 'package:sante_en_poche/home.dart';
import 'package:sante_en_poche/screens/login/login.dart';
import 'package:sante_en_poche/screens/signup/signup.dart';
import 'package:sante_en_poche/screens/signup/signup2.dart';
import 'package:sante_en_poche/screens/signup/signup3.dart';


//background for registers
//signup2
class MyBackgroundMain extends StatelessWidget {
  final Widget child;
  final bool useAppBar;
  final bool useMenuBar;

  MyBackgroundMain(
      {Key? key,
      required this.child,
      this.useAppBar = true,
      this.useMenuBar = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarWidget;
    PreferredSizeWidget? bottomBarWidget;
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
      );
    }
    if (useMenuBar == true) {
      bottomBarWidget = PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBackground1(
                            useAppBar: true,
                            useMenuBar: true,
                            child: MySignup()),
                      ),
                    );
                  },
                  child: Text(
                    'Retour',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(155.w, 45.h),
                    backgroundColor: const Color(0xff35cbcc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBackground2(
                          useMenuBar: false,
                          useAppBar: true,
                          child: MySignup3(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Suivant',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 120.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Composant 52.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 100.0.w, vertical: 140.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          child,
        ],
      ),
      bottomNavigationBar: bottomBarWidget,
    );
  }
}

//sign up 1
class MyBackground1 extends StatefulWidget {
  final Widget child;
  final bool useAppBar;
  final bool useMenuBar;

  MyBackground1(
      {Key? key,
      required this.child,
      this.useAppBar = true,
      this.useMenuBar = true})
      : super(key: key);

  @override
  State<MyBackground1> createState() => _MyBackground1State();
}

class _MyBackground1State extends State<MyBackground1> {
 
 Widget build(BuildContext context) {
 
    PreferredSizeWidget? appBarWidget;
    PreferredSizeWidget? bottomBarWidget;
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
      );
    }
    if (widget.useMenuBar == true) {
      bottomBarWidget = PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBackground(child: MyLogin()),
                      ),
                    );
                  },
                  child: Text(
                    'Retour',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(155.w, 45.h),
                    backgroundColor: const Color(0xff35cbcc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                  
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyBackgroundMain(
                              useMenuBar: false,
                              useAppBar: true,
                              child: const MySignup2(),
                            ),
                          ),
                        );
                  
                  },
                  
                  child: Text(
                    'Suivant',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 120.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 100.0.w, vertical: 140.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          widget.child,
        ],
      ),
      bottomNavigationBar: bottomBarWidget,
    );
  }
}

class MyBackground2 extends StatelessWidget {
  final Widget child;
  final bool useAppBar;
  final bool useMenuBar;

  MyBackground2(
      {Key? key,
      required this.child,
      this.useAppBar = true,
      this.useMenuBar = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget? appBarWidget;
    PreferredSizeWidget? bottomBarWidget;
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
      );
    }
    if (useMenuBar == true) {
      bottomBarWidget = PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BottomAppBar(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBackgroundMain(
                            useMenuBar: true,
                            useAppBar: true,
                            child: MySignup2()),
                      ),
                    );
                  },
                  child: Text(
                    'Retour',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(155.w, 45.h),
                    backgroundColor: const Color(0xff35cbcc),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyBackgroundMulti(
                          child: MyHome(),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Suivant',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBarWidget,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 120.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Composant 52.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Composant 52.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(
                      'assets/images/signup/Component 526.svg',
                      width: 50.w,
                      height: 50.h,
                    ),
                    const Text(
                      'Étape 3',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 100.0.w, vertical: 140.0.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
                Container(
                  //line
                  height: 2.0.h,
                  width: 90.0.w,
                  color: Colors.white,
                ),
              ],
            ),
          ),
          child,
        ],
      ),
      bottomNavigationBar: bottomBarWidget,
    );
  }
}
