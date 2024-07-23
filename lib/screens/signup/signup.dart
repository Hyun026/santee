import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/background.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';
import 'package:sante_en_poche/firebase/authenticate.dart';
import 'package:sante_en_poche/screens/login/login.dart';
import 'package:sante_en_poche/screens/signup/signup2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySignup extends StatefulWidget {
  const MySignup({super.key});

  @override
  State<MySignup> createState() => _MySignupState();
}

class _MySignupState extends State<MySignup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            
            Stack(
              children: [
                
                Padding(
                  padding:  EdgeInsets.only(top: 35.h),
                  child: Container(
                    width: size.width * 1,
                    height: size.height*0.7,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 100.h,
                            ),
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildInputField1(
                                    controller: lastnameController,
                                    hintText: "Nom",
                                    prefixIcon:
                                        'assets/images/signup/Icon awesome-user-tiegreen.svg',
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  _buildInputField1(
                                    controller: nameController,
                                    hintText: "prénom",
                                    prefixIcon:
                                        'assets/images/signup/Icon awesome-user-tiegreen.svg',
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              controller: emailController,
                              hintText: "Adresse mail",
                              prefixIcon:
                                  'assets/images/signup/mail(1).svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              controller: passwordController,
                              hintText: "Mot de passe",
                              prefixIcon:
                                  'assets/images/signup/lock open.svg',
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _buildInputField(
                              controller: confpassController,
                              hintText: "Confirmer le mot de passe",
                              prefixIcon:
                                  'assets/images/signup/lock open.svg',
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            //buttons
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              
                //circle
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 55.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [
                            Color(0xffffffff),
                            Color(0xffd0e0fc),
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
                            'assets/images/signup/icons8_inscription_2.svg',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Inscriptions',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/signup/Icon awesome-user-tie.svg',
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text('Informations'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
               
               Positioned(
               bottom: 0,
                 child: Container(
                           height: size.height * 0.1,
                           width: size.width * 1,
                           decoration: const BoxDecoration(color: Colors.white),
                           child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyBackground(child: MyLogin()),
                            ),
                          );
                        },
                        child: const Text(
                          'Retour',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                      minimumSize: Size(155.w, 45.h),
                      backgroundColor: const Color(0xff35cbcc),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                        onPressed: () async {
                          if (nameController.text.isEmpty || lastnameController.text.isEmpty|| emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All fields are required.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                     
                          if (passwordController.text != confpassController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Passwords do not match.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          final prefs = await   SharedPreferences.getInstance();
                                prefs.setString("name", nameController.text);
                                prefs.setString("lastname", lastnameController.text);
                     
                        
                          User? result = await AuthService().register(
                            emailController.text,
                            passwordController.text,
                            context,
                          );
                     
                          if (result != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyBackgroundMain(
                                  useAppBar: true,
                                  useMenuBar: false,
                                  child: const MySignup2(),
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Suivant',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                           ),
                         ),
               ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}

Widget _buildInputField({
  required TextEditingController controller,
  required String hintText,
  required String prefixIcon,
  
}) {
  return SizedBox(
    width: 350.w,
    height: 60.h,
    child: TextFormField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffafafaf),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
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

Widget _buildInputField1({
  required TextEditingController controller,
  required String hintText,
  required String prefixIcon,
}) {
  return SizedBox(
    width: 165.w,
    height: 60.h,
    child: TextFormField(
      controller: controller, 
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
          child: SvgPicture.asset(prefixIcon),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color(0xffafafaf),
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
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
