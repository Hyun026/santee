import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
//background  for confirmations
class MyBackgroundMulti extends StatelessWidget {
  final Widget child;
   final bool useAppBar;

  const MyBackgroundMulti({Key? key, required this.child, this.useAppBar = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     PreferredSizeWidget? appBarWidget;
     if (useAppBar) {
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
            padding: const EdgeInsets.all(18.0),
            child: Row(
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
                  
                  Text("Assitance",style: TextStyle(color: Colors.white,fontSize: 16.sp),),
                  Text('0522 30 60 60',style: TextStyle(color: Colors.white,fontSize: 20.sp, fontWeight: FontWeight.bold),),
                ],),
              ],
            ),
          ),
        
          child,
        ],
      ),
    );
  }
}
