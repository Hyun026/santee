
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/back.dart';

import 'package:sante_en_poche/constant/background/backgroun.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';

import 'package:sante_en_poche/screens/appointement/appointlist.dart';
import 'package:sante_en_poche/screens/medicalfile/medfile.dart';







class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
    return Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(left: 7,top: 20),
              child: Container(
                width: size.width,
                height: size.height*0.6,
                child: SvgPicture.asset(
                  'assets/images/home/Group 51867.svg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Center Icon
            Positioned(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: -9, 
              blurRadius: 15,
              offset: const Offset(0, 2), 
            ),
          ],
        ),
                    child: ClipOval(
                      child: SvgPicture.asset(
                        'assets/images/home/Group 51873.svg',
                        fit: BoxFit.cover,
                        width: 120.0.w,
                        height: 120.0.h,
                      ),
                    ),
                  ),
                  Text('Ma Santé en poche', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
             Shadow(
        offset: const Offset(0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),
    ],)),
                ],
              ),
            ),
            // Ambulance
            Positioned(
              top: size.height * 0.23,
              right: size.width * 0.3,
              child: Column(
                children: [
                  Container(
                        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: -9, 
              blurRadius: 15,
              offset: const Offset(0, 2), 
            ),
          ],
        ),
                    child: SvgPicture.asset(
                      'assets/images/home/Group 51872.svg',
                      fit: BoxFit.cover,
                      width: 80.0.w,
                      height: 80.0.h,
                    ),
                  ),
                  Text('Ambulance', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
      Shadow(
        offset: const Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),
    ],)),
                ],
              ),
            ),
            // Pharmacy
            Positioned(
              top: size.height * 0.33,
              right: size.width * 0.02,
              child: Column(
                children: [
                Container(
                  decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: -9, 
              blurRadius: 15,
              offset: const Offset(0, 2), 
            ),
          ],
        ),
                    child: SvgPicture.asset(
                      'assets/images/home/Group 51868.svg',
                      fit: BoxFit.cover,
                      width: 95.0.w,
                      height: 95.0.h,
                    ),
                ),
                 Text('Pharmacie', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
      Shadow(
        offset: const Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),
    ],)),
                ],
              ),
            ),
            // Notifications
           Positioned(
            top: MediaQuery.of(context).size.height * 0.55,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Column(
              children: [
                Container(
                  width: 40.0.w, 
                  height: 40.0.h, 
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.white,
                      MyColors.CalendarToday,
                    ]),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: -5,
                        blurRadius: 8,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/home/icons8_alarm_1(1).svg',
                      width: 26.w, 
                      height: 26.h, 
                    ),
                  ),
                ),
               
                SizedBox(height: 8.0.h), 
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,fontWeight: FontWeight.bold, shadows: [
      Shadow(
        offset: const Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),],
                  ),
                ),
              ],
            ),
          ),
        
      
    
            // Teleconsultation
            Positioned(
              bottom: size.height * 0.18,
              right: size.width * 0.27,
              child: Column(
                children: [
                  Container(
                  decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: -9, 
              blurRadius: 15,
              offset: const Offset(0, 2), 
            ),
          ],
        ),
                    child: SvgPicture.asset(
                      'assets/images/home/Group 51869.svg',
                      fit: BoxFit.cover,
                      width: 105.0.w,
                      height: 105.0.h,
                    ),
                ),
                  Text('Téléconsultation', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
      Shadow(
        offset: const Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),
    ],)),
                ],
              ),
            ),
            // Mon Dossier Médical
            Positioned(
              bottom: size.height * 0.28,
              left: size.width * 0.017,
              child: Column(
                children: [
                  GestureDetector(
                       onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const Back(child:  MyMedFile()),
                                ),
                              );
              },
                    child: Container(
                        width: 70.0.w, 
                        height: 70.0.h, 
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Colors.white,
                            MyColors.CalendarToday
                          ]),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.6),
                              spreadRadius: -5,
                              blurRadius: 8,
                              offset: const Offset(0, 11),
                            ),
                          ],
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/images/home/doc2(1).svg',
                            width: 45.w, 
                            height: 45.h, 
                          ),
                        ),
                      ),
                  ),
                  Column(
                    children: [
                      Text('Mon Dossier ', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
                            Shadow(
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],)),
                           Text(' Médical', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
                            Shadow(
                              offset: const Offset(2.0, 2.0),
                              blurRadius: 3.0,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],)),
                    ],
                  ),
                 
                ],
              ),
            ),
            // Mes RDV
            Positioned(
              bottom: size.height * 0.45,
              left: size.width * 0.08,
              child: Column(
                children: [
                GestureDetector(
                    onTap: () {
                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const Backmain(child:  MyAppointements()),
                                ),
                              );
              },
                  child: Container(
                              
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2), 
                                spreadRadius: -15, 
                                blurRadius: 15,
                                offset: const Offset(0, 2), 
                              ),
                        ],
                      ),
                      child: SvgPicture.asset(
                        'assets/images/home/Group 51870.svg',
                        fit: BoxFit.cover,
                        width: 80.0.w,
                        height: 80.0.h,
                      ),
                  ),
                ),
                  Text('Mes RDV', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
                  Shadow(
                    offset: const Offset(2.0, 2.0),
                    blurRadius: 3.0,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ],)),
                 
                ],
              ),
            ),
            // SOS Médecin
            Positioned(
              top: size.height * 0.28,
              left: size.width * 0.05,
              child: Column(
                children: [
                 Container(
                  decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              spreadRadius: -15, 
              blurRadius: 15,
              offset: const Offset(0, 2), 
            ),
          ],
        ),
                    child: SvgPicture.asset(
                      'assets/images/home/Group 51871.svg',
                      fit: BoxFit.cover,
                      width: 105.0.w,
                      height: 105.0.h,
                    ),
                ),
                  Text('SOS Médecin', style: TextStyle(fontSize: 14.sp, color: Colors.white,fontWeight: FontWeight.bold, shadows: [
      Shadow(
        offset: const Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
      ),
    ],)),
                  
                ],
              ),
            ),
          ],
        ),
      );
  }
}