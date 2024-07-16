import 'dart:async';

import 'package:flutter/material.dart';


import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sante_en_poche/connection/notConnected.dart';
import 'package:sante_en_poche/main.dart';



class connectCheck extends StatefulWidget {
  const connectCheck({super.key});

  @override
  State<connectCheck> createState() => _connectCheckState();
}

class _connectCheckState extends State<connectCheck> {
  bool isConnected= false;

  StreamSubscription? _internetConnectionStreamSubscription;

  @override
  void initState() {
    super.initState();
   _internetConnectionStreamSubscription =  
    InternetConnection().onStatusChange.listen((event) {
      print(event);
      switch (event) {
        case InternetStatus.connected:
           setState(() {
          isConnected = true;
        });
        _navigateToNextPage();
          break;
        case InternetStatus.disconnected:
           setState(() {
          isConnected = false;
        });
        _navigateToNextPage();
          break;
        default:
        setState(() {
          isConnected = false;
        });
        _navigateToNextPage();
        break;
      }
    });
  }

   void _navigateToNextPage() {
    if (isConnected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Notconnected()),
      );
    }
  }



  @override
  void dispose() {
   _internetConnectionStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
