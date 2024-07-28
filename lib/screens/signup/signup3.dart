

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/backgroundhome.dart';
import 'package:sante_en_poche/constant/background/backgroundmain.dart';
import 'package:sante_en_poche/home.dart';
import 'package:sante_en_poche/screens/signup/signup2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OptionsController extends ValueNotifier<String?> {
  OptionsController(String? value) : super(value);
}

class MySignup3 extends StatefulWidget {
  const MySignup3({super.key});

  @override
  State<MySignup3> createState() => _MySignup3State();
}

class _MySignup3State extends State<MySignup3> {
   
  List<Option> optionsList = [
    Option(
      value: "Option 1",
      controller: TextEditingController(),
    ),
    Option(
      value: "Option 2",
      controller: TextEditingController(),
    ),
    Option(
      value: "Option 3",
      controller: TextEditingController(),
    ),
    Option(
      value: "Option 4",
      controller: TextEditingController(),
    ),
  ];

  List<Options> optionsList1 = [
    Options(
      values: "Option 1",
    ),
    Options(
      values: "Option 2",
    ),
    Options(
      values: "Option 3",
    ),
    Options(
      values: "Option 4",
    ),
  ];

   OptionsController _optionsController = OptionsController(null);

  @override
  void dispose() {
    _optionsController.dispose();
    super.dispose();
  }

  Option? selectedOption;
  Options? selectedOptions;
  String uid = '';
  String name = "";
  String lastname = "";
  String cin = "";
  String gender = "";
  String birthday = "";
  String civil = "";
  String phone = "";
  String adress = "";
  String region = "";
  String assurance = "";
  String regime = "";
  String affiliation = "";
  String kidName = "";
  String kidLastName = "";
  String kidCIN = "";

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("name")!;
      lastname = prefs.getString("lastname")!;
      cin = prefs.getString("CIN")!;
      gender = prefs.getString("Gender")!;
      birthday = prefs.getString("Birthday")!;
      civil = prefs.getString("Etat Civil")!;
      phone = prefs.getString("Phone")!;
      adress = prefs.getString("Adresse")!;
      region = prefs.getString("Région")!;
      assurance = prefs.getString("Assurance")!;
      regime = prefs.getString("Régime")!;
      affiliation = prefs.getString("Affiliation")!;
      kidName = prefs.getString("kidName")!;
      kidLastName = prefs.getString("kidLastName")!;
      kidCIN = prefs.getString("kidCIN")!;
    });
  }

  TextEditingController commentController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.h),
                    child: Container(
                      width: size.width * 1,
                      height: size.height * 0.7,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(75.0),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: Column(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Lorem ipsum dolor sit amet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                  Column(
                                    children: optionsList.map((option) {
                                      return SizedBox(
                                        height: 40.h,
                                        child: Row(
                                          children: [
                                            Radio<Option>(
                                              value: option,
                                              groupValue: selectedOption,
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedOption = value;
                                                });
                                              },
                                              activeColor: Colors.blue,
                                            ),
                                            Text(
                                              option.value,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  Text(
                                    'Lorem ipsum dolor sit amet',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.sp),
                                  ),
                                  Column(
                                    children: optionsList1.map((Options) {
                                      return Container(
                                        height: 40.h,
                                        child: Row(
                                          children: [
                                            Radio(
                                              value: Options,
                                              groupValue: selectedOptions,
                                              onChanged: (values) {
                                                setState(() {
                                                  selectedOptions = values;
                                                });
                                              },
                                              activeColor: Colors.blue,
                                            ),
                                            Text(
                                              Options.values,
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              _buildInputField(
                                controller: commentController,
                                context: context,
                                hintText: "Commentaire",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.w,
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
                            ]),
                        child: Padding(
                            padding: EdgeInsets.all(20.w),
                            child: SvgPicture.asset(
                                'assets/images/signup/icons8_inscription_2.svg')),
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
                                fontSize: 22),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/images/signup/icons8_questions_2(1).svg'),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Text('Questionnaire')
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
                             decoration: BoxDecoration(color: Colors.white),
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
                              builder: (context) => MyBackgroundMain(
                                child: MySignup2(),
                                useAppBar: true,
                                useMenuBar: false,
                              ),
                            ),
                          );
                        },
                        child: Text(
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
                          String downloadUrl = await uploadImage(
                              'assets/images/search/Sanstitre.png');
                            

                          Map<String, dynamic> dataToSave = {
                            'user': user!.uid,
                            'name': name,
                            'lastname': lastname,
                            'adress': adress,
                            'cin': cin,
                            'birthday': birthday,
                            'assurance': assurance,
                            'gender': gender,
                            'Etat Civil': civil,
                            'Phone': phone,
                            'Région': region,
                            'Régime': regime,
                            'Affiliation': affiliation,
                            'kidName': kidName,
                            'kidLastName': kidLastName,
                            'kidCIN': kidCIN,
                            'comment': commentController.text,
                            'imageLink': downloadUrl,
                            'online': true,
                            //put the channel id here
                          };
                 
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(user!.uid)
                              .set(dataToSave);
                 
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setString("imageLink", downloadUrl);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MyBackgroundHome(child: MyHome()),
                            ),
                          );
                        },
                        child: Text(
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

  Future<String> uploadImage(String assetPath) async {
    try {
      // Load image data from the asset
      final byteData = await rootBundle.load(assetPath);
      final imageData = byteData.buffer.asUint8List();

      // Extract the file name from the path
      final fileName = assetPath.split('/').last;

      // Upload image to Firebase Storage
      final storageRef =
          FirebaseStorage.instance.ref().child('ProfileImage/$fileName');
      final uploadTask = storageRef.putData(imageData);

      // Wait for the upload to complete and get the download URL
      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
}

class Option {
  String value;

  bool isSelected;
  final TextEditingController controller;

  Option({
    required this.value,
    this.isSelected = false,
    required this.controller,
  });
}

class Options {
  String values;

  bool isSelected;

  Options({
    required this.values,
    this.isSelected = false,
  });
}

Widget _buildInputField({
  required BuildContext context,
  required String hintText,
  required TextEditingController controller,
}) {
  Size size = MediaQuery.of(context).size;
  return SizedBox(
    width: 350,
    height: size.height * 0.5,
    child: TextFormField(
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(13.0),
        ),
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Color(0xffCAEBF3),
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
  );
}
