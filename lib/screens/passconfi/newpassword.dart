import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroundhome.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';
import 'package:sante_en_poche/home.dart';
import 'package:sante_en_poche/screens/signup/signup.dart';

class MyNewPass extends StatefulWidget {
  const MyNewPass({super.key});

  @override
  State<MyNewPass> createState() => _MyNewPassState();
}

class _MyNewPassState extends State<MyNewPass> {
  TextEditingController newpass = TextEditingController();
  TextEditingController newpassconf = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(child: 
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          SizedBox(height: 80.h,),
        SvgPicture.asset("assets/images/confirmer/icons8_password.svg"),
        SizedBox(height: 120.h,),
        Text('Nouveau mot de passe',style: TextStyle(color: Colors.white, fontSize: 30.sp,fontWeight: FontWeight.bold),),
         SizedBox(height: 50.h,),
           _buildInputField(
                              controller:newpass ,
                              hintText: "Nouveau mot de passe",
                             
                            ),
       SizedBox(height: 20.h,),
           _buildInputField(
                              controller:newpassconf ,
                              hintText: "Retapez le nouveau mot de passe",
                             
                            ),
       SizedBox(height: 20.h,),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                          minimumSize: Size(350.w, 60.h),
                          backgroundColor: const Color(0xff35cbcc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
          onPressed: () { Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyBackgroundHome(child :MyHome() ,),
                                ),
                              );
                            },
                            child: Text('Changer le mot de passe', style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 70.h,),
           Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte?",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 17.sp),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(
                                    decoration: TextDecoration.underline),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyBackground1(
                                        useAppBar: true,
                                        useMenuBar: false,
                                        child: const MySignup()),
                                  ),
                                );
                              },
                              child: Text(
                                'Créer le',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),

        
      ],
    )
    ,);
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,

}) {
  return SizedBox(
    width: 350.w,
    height: 60.h,
    child: TextFormField(
      controller: controller, 
      decoration: InputDecoration(
       
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffafafaf),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 25.w),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    ),
  );
}
