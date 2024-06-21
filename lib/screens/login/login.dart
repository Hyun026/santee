import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroundhome.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';
import 'package:sante_en_poche/constant/background/backgroundmulti.dart';
import 'package:sante_en_poche/firebase/authenticate.dart';
import 'package:sante_en_poche/home.dart';
import 'package:sante_en_poche/screens/passconfi/emailconfi.dart';
import 'package:sante_en_poche/screens/signup/signup.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({super.key});

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  late final LocalAuthentication auth;
  bool _supportState = true;

  @override
  void initState() {
    super.initState();
    auth = LocalAuthentication();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() {
            _supportState = isSupported;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            height: size.height * 0.5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              10.horizontalSpace,
              RotatedBox(
                  quarterTurns: 3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                      ),
                      SvgPicture.asset(
                        'assets/images/login/icons8_headset.svg',
                        width: 20.w,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "Assistance ",
                        style: TextStyle(
                            color: const Color(0xff00388B), fontSize: 16.sp),
                      ),
                      Text(
                        '0522 30 60 60',
                        style: TextStyle(
                            color: const Color(0xff00388B),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp),
                      )
                    ],
                  )),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: Container(
                  width: 300.w,
                  height: size.height * 0.5,
                  decoration: const BoxDecoration(
                      color: Color(0xff00388b),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(60))),
                  child: Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 300.w,
                        height: size.height * 0.06,
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: '      E-mail ou CIN',
                            hintStyle: TextStyle(
                              color: Color(0xffafafaf),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xffCAEBF3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xffCAEBF3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 300.w,
                        height: size.height * 0.06,
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: ' Mot de passe',
                            hintStyle: TextStyle(
                              color: Color(0xffafafaf),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xffCAEBF3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1.5,
                                color: Color(0xffCAEBF3),
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      //button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(300.w, 50.h),
                          backgroundColor: const Color(0xff35cbcc),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () async {
                          if (emailController.text == "" ||
                              passwordController.text == "") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('All fields are required'),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthService().login(
                                emailController.text,
                                passwordController.text,
                                context);
                            if (result != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>const MyBackgroundHome(child:  MyHome()),
                                ),
                              );
                            }
                          }
                        },
                        child: Text(
                          'Connecter',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      //pass forgotten
                      TextButton(
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(fontSize: 16.sp),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const MyBackgroundMulti(useAppBar: true,child: MyEmail(),),
                              ),
                            );
                          },
                          child: const Text('Mot de passe oublié?',
                              style: TextStyle(color: Colors.white))),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            if (_supportState)
                              GestureDetector(
                                onTap: () {
                                 _getAvailableBiometrics();
                                },
                                child: SvgPicture.asset(
                                  'assets/images/login/icons8_face_id_1.svg',
                                  height: 0.05.sh,
                                ),
                              ),
                            const Padding(padding: EdgeInsets.all(14.0)),
                            GestureDetector(
                              onTap: (){
                                _authenticate();
                              },
                              child: SvgPicture.asset(
                                'assets/images/login/icons8_fingerprint_recognition_1.svg',
                                height: 0.05.sh,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Vous n'avez pas de compte?",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.sp),
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
 Future<void> _authenticate() async {
  try {
    bool authenticated = await auth.authenticate(
      localizedReason: 'Authenticate to continue',
      options: const AuthenticationOptions(
        stickyAuth: true,
        biometricOnly: true,
      ),
    );

    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  MyBackgroundMulti( child: MyHome()),
        ),
      );
      print('User authenticated successfully');
    } else {
     
      print('User authentication failed');
    }
  } on PlatformException catch (e) {
   
    print('Error during authentication: $e');
  
  } catch (e) {
   
    print('Unexpected error during authentication: $e');
 
  }
}


  Future<void> _getAvailableBiometrics()async{
    List<BiometricType> availableBiometrics=
    await auth.getAvailableBiometrics();

    print("List of availableBiometrics: $availableBiometrics");
    if(!mounted){
      return;
    }
  
}
}


