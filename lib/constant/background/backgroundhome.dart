import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
//background for home
class MyBackgroundHome extends StatelessWidget {
  final Widget child;

  const MyBackgroundHome({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
            Padding(
              padding:  EdgeInsets.symmetric(vertical: 80.h,horizontal: 40.w),
              child: Column(
              
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
             Padding(
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
                        child: SvgPicture.asset("assets/images/confirmer/icons8_headset.svg")),
                      SizedBox(width: 10.w,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        
                        Text("Assitance",style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                        Text('0522 30 60 60',style: TextStyle(color: Colors.white,fontSize: 20.sp, fontWeight: FontWeight.bold),),
                      ],),
                    ],
                               ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(color: Color(0xff005C8B),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50), bottomLeft: Radius.circular(50))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/images/home/icons8_medical_doctor.svg'),
                          ),
                      ),
                 ],
               ),
             ),
         
          child,
        ],
      ),
    );
  }
}
