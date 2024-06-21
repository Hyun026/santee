import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroun.dart';
import 'package:sante_en_poche/constant/background/background.dart';
import 'package:sante_en_poche/constant/background/backgroundnoti.dart';
import 'package:sante_en_poche/screens/appointement/appointlist.dart';
import 'package:sante_en_poche/screens/login/login.dart';
import 'package:sante_en_poche/screens/medicalfile/medfile.dart';





class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:size.height*0.2 ,),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/images/home/Group 51867.svg'),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(vertical: 170.h, horizontal: 180.w),
                child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Backmain(child: MyAppointements()) ),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/home/Group 51870.svg',
                      ),
                    ),
              ),
              
      
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BackNoti(child: MyMedFile()) ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [
                            Color(0xffffffff),
                            Color(0xffD0E0FC),
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                    child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: SvgPicture.asset(
                            'assets/images/home/doc2(1).svg',
                          ),
                        ),
                    ),
                  ),
            ],
      
          ),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: SizedBox(height: 60.h, 
              child: ElevatedButton(onPressed:  () {
                
                FirebaseAuth.instance.signOut();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MyBackground(
                                             
                                              child: MyLogin()),
                                        ),
                                      );
                                    }, style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white, backgroundColor: Color(0xffE00000),
                                      
                                    ),
                                     child: Center(
                                       child: Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                      
                                        
                                         children: [
                                           Text('Se déconnecter',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                                           SizedBox(width: 20.w,),
                                           SvgPicture.asset('assets/images/home/icons8_logout_rounded_up.svg')
                                         ],
                                       ),
                                     )),
            ),
          ),
          
        ],
      ),
    );
  }
}