import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/background.dart';

import 'package:sante_en_poche/screens/login/login.dart';



class MyEmail extends StatefulWidget {
 const  MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
 TextEditingController emailController = TextEditingController();

@override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
         try {
           await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
          showDialog(context: context, builder: (context){
            return const AlertDialog(
              content: const Text("Link pour réinitialiser le mot de passe  à été envoyer"),
            );
          });
         } on FirebaseAuthException catch (e) {
          print(e);
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
           
         }
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/images/confirmer/icons8_mail.svg"),
                      SizedBox(height: 70.h),
                      SizedBox(
                        width: constraints.maxWidth * 0.8, // Responsive width
                        child: Column(
                          children: [
                            Text(
                              "Entrez l'adresse e-mail associée à votre",
                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'compte  et nous  vous enverrons un lien pour',
                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'réinitialiser votre mot de passe',
                              style: TextStyle(color: Colors.white, fontSize: 16.sp),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      _buildInputField(
                        controller: emailController,
                        hintText: "Email",
                      ),
                      SizedBox(height: 30.h),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(constraints.maxWidth * 0.7, 60.h),
                          backgroundColor: const Color(0xff35cbcc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          // Implement password reset logic here
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyBackground(
                                child: const MyLogin(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Envoyer',
                          style: TextStyle(color: Colors.white, fontSize: 17.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
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
}
