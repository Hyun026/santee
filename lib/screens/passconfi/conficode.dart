import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';
import 'package:sante_en_poche/constant/background/backgroundmulti.dart';
import 'package:sante_en_poche/screens/passconfi/newpassword.dart';
import 'package:sante_en_poche/screens/signup/signup.dart';

class MyCode extends StatefulWidget {
  const MyCode({super.key});

  @override
  State<MyCode> createState() => _MyCodeState();
}

class _MyCodeState extends State<MyCode> {
  TextEditingController code0 = TextEditingController();
   TextEditingController code1 = TextEditingController();
    TextEditingController code2 = TextEditingController();
     TextEditingController code3 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 80.h,),
        SvgPicture.asset("assets/images/confirmer/icons8_keypad.svg"),
        SizedBox(height: 120.h,),
        Text("Code de confirmation", style: TextStyle(color: Colors.white, fontSize: 30.sp,fontWeight: FontWeight.bold),),
        SizedBox(height: 50.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              _buildInputField(
                              controller: code0,
                              hintText: "1",
                             
                            ),
              SizedBox(width: 15.w,),
                _buildInputField(
                              controller: code1,
                              hintText: "9",
                             
                            ),
                       SizedBox(width: 15.w,),
                  _buildInputField( 
                              controller: code2,
                              hintText: "3",
                             
                            ),
                  SizedBox(width: 15.w,),
                    _buildInputField(
                              controller: code3,
                              hintText: "4",
                             
                            ),
          ], ),
          SizedBox(height: 30.h,),
           ElevatedButton(
            style: ElevatedButton.styleFrom(
                          minimumSize: Size(350.w, 60.h),
                          backgroundColor: const Color(0xff35cbcc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
          onPressed: () async {  
            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyBackgroundMulti( useAppBar:true ,child :MyNewPass() ,),
                                ),
                              );
                            },
                            child: Text('Continuer', style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.bold),),
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

      ],),
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,

}) {
  return SizedBox(
    width: 80.w,
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
         contentPadding: EdgeInsets.symmetric(horizontal: 35.w),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
