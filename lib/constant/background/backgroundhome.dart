import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
//background for home
class MyBackgroundHome extends StatelessWidget {
  final Widget child;

  const MyBackgroundHome({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
   return Scaffold(
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
              height: size.height * 0.3, // Adjust the height relative to screen height
              width: size.width * 0.4, // Adjust the width relative to screen width
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 80.h, horizontal: 40.w),
            child: Container(
              height: size.height * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Votre Santé',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                  Text(
                    'au bout',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.sp,
                    ),
                  ),
                  Text(
                    "d'1 Clic",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.all(8.0),
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
                    decoration: BoxDecoration(
                      color: Color(0xff005C8B),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        'assets/images/home/icons8_medical_doctor.svg',
                        height: 30.h, // Adjust height for responsiveness
                        width: 30.w,  // Adjust width for responsiveness
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Ensure `child` is defined and responsive
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox.expand(
                child: child, // The child widget should adapt to the available space
              ),
            ),
          ),
        ],
      ),
    );
  }
}