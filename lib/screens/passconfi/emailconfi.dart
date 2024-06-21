import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroundmulti.dart';
import 'package:sante_en_poche/firebase/authenticate.dart';
import 'package:sante_en_poche/firebase/newpass.dart';
import 'package:sante_en_poche/screens/passconfi/conficode.dart';

class MyEmail extends StatefulWidget {
 const  MyEmail({super.key});

  @override
  State<MyEmail> createState() => _MyEmailState();
}

class _MyEmailState extends State<MyEmail> {
  TextEditingController confEmail = TextEditingController();
  
 final PassReset passReset = PassReset();

 

 @override
  void dispose () {
    confEmail.dispose();
    super.dispose();
  }


  @override
  
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset("assets/images/confirmer/icons8_mail.svg"),
          SizedBox(height: 70.h,),
         SizedBox(
          width: 400.w,
           child: Column(
            children: [
              Text("Entrez l'adresse e-mail associée à votre", style: TextStyle(color: Colors.white,fontSize: 18.sp),),
              Text('compte  et nous  vous enverrons un lien pour ', style: TextStyle(color: Colors.white,fontSize: 18.sp),),
              Text('réinitialiser votre mot de passe', style: TextStyle(color: Colors.white,fontSize: 18.sp),),
              ],
           ),
         ),
      
       
         SizedBox(height: 40.h,),
           _buildInputField(
                              controller: confEmail,
                              hintText: "Email",
                             
                            ),
                              SizedBox(height: 30.h,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                          minimumSize: Size(350.w, 60.h),
                          backgroundColor: const Color(0xff35cbcc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
          onPressed:() async {
             String email = confEmail.text.trim();
   AuthService authService = AuthService();
  await authService.sendPasswordResetEmail(email);
  
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyBackgroundMulti(useAppBar: true, child: MyCode()),
      ),
    );
        
    },
                            child: Text('Envoyer le code de confirmation', style: TextStyle(color: Colors.white,fontSize: 17.sp,fontWeight: FontWeight.bold),),
          ),
      
        ],
      ),
    );
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
