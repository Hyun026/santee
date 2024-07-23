import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';

//background for Login page
class MyBackground extends StatefulWidget {
  final Widget child;

   MyBackground({Key? key, required this.child}) : super(key: key);

  @override
  State<MyBackground> createState() => _MyBackgroundState();
}

class _MyBackgroundState extends State<MyBackground> {
  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height,
              width: size.width,
              child: SvgPicture.asset(
                'assets/images/background/Group 51866.svg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
               SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Center(
               child: Padding(
                 padding:  EdgeInsets.all(20.0.h),
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Text(
                      'Votre Santé',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                    Text(
                      'au bout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                      ),
                    ),
                    Text(
                      "d'1 Clic",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 6,
                      ),
                    ),
                  ],
                 ),
               ),
              ),
            ],
          ),
          widget.child,
        ],
      ),
    );
  }
}
