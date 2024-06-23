import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:sante_en_poche/constant/background/background.dart';
import 'package:sante_en_poche/constant/background/backgroundhome.dart';

import 'package:sante_en_poche/firebase/authenticate.dart';
import 'package:sante_en_poche/home.dart';
import 'package:sante_en_poche/screens/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
           textTheme: GoogleFonts.manropeTextTheme(),
        ),
     home: StreamBuilder<List<ConnectivityResult>>(
       stream: Connectivity().onConnectivityChanged,
       builder: (context, snapshot) {
           if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Scaffold(
                body: StreamBuilder<User?>(
                  stream: AuthService().firebaseAuth.authStateChanges(),
                  builder: (context, AsyncSnapshot<User?> snapshot) {
                    if (snapshot.hasData) {
                      return MyBackgroundHome(child: MyHome());
                    } else {
                      return MyBackground(
                        child: const MyLogin(),
                      );
                    }
                  },
                ),
              );
            } else {
              return Center(child: Text('No connection state detected'));
            }
          },
        ),
      ),
    );
  }
}