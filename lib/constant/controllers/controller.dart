import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Controller extends GetxController {
  static Controller get instance => Get.find();

  //variables
  final username = TextEditingController();
  final Nom = TextEditingController();
  final Prenom = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confimPasswordController = TextEditingController();
  final CarteID = TextEditingController();
  final Sexe = TextEditingController();
  final DNaiss = TextEditingController();
  final Civil = TextEditingController();
  final Phone = TextEditingController();
  final Adresse = TextEditingController();
  final Region = TextEditingController();
  final Assurance = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>(); }