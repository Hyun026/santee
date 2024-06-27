import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sante_en_poche/connection/check.dart';
import 'package:sante_en_poche/connection/serviceConn.dart';

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
  await Firebase.initializeApp();

  Get.put(NetworkManager());

  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: GoogleFonts.manropeTextTheme(),
          ),
          home: child,
        );
      },
      child: ConnectivityCheckPage(),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: AuthService().firebaseAuth.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.hasData) {
            return MyBackgroundHome(child: MyHome());
          }
          return MyBackground(
            child: const MyLogin(),
          );
        },
      ),
    );
  }
}

class NoConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('No Connexion')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Text('Pas de connexion Internet. Veuillez vérifier votre connexion..'),
        ),
      ),
    );
  }
}