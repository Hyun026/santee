import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAppointements extends StatefulWidget {
  const MyAppointements({super.key});

  @override
  State<MyAppointements> createState() => _MyAppointementsState();
}

class _MyAppointementsState extends State<MyAppointements> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Mes rendez-vous', style: TextStyle(color: Colors.white,fontSize: 17.sp),)
        ],
      ),
    );
    
  }
}