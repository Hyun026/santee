import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/firebase/dataRetrieve.dart';
import 'package:sante_en_poche/firebase/imageadd.dart';
import 'package:sante_en_poche/screens/appointement/category/general.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
 
 Uint8List? image;
  String image1 = "";

  Future<void> selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
      await saveProfile();
    }
  }

  Future<void> saveProfile() async {
    if (image == null) {
      print('No image selected');
      return;
    }
    String resp = await StoreData().saveData(file: image!);
    if (resp == 'success') {
      print('Profile updated successfully');
      await _updateImageLink();
    } else {
      print('Failed to update profile: $resp');
    }
  }

  Future<void> _updateImageLink() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedImageLink = prefs.getString("imageLink");
    if (savedImageLink != null) {
      setState(() {
        image1 = savedImageLink;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateImageLink();
  }

  final Data firestoreService = Data();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                
                children: [
                  GestureDetector(
                    onTap: selectImage,
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: image != null
                            ? DecorationImage(
                                image: MemoryImage(image!),
                                fit: BoxFit.cover,
                              )
                            : image1.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(image1),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                        border: Border.all(color: Colors.grey, width: 2), // Optional: Add border
                      ),
                      child: image == null && image1.isEmpty
                          ? Center(child: Icon(Icons.person, size: 50))
                          : null,
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Column(
                    children: [
                      Text('Bienvenue', style: TextStyle(color: Colors.white, fontSize: 17.sp),),
                       FutureBuilder<String>(
                    future: Data().getMessage(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'No message retrieved',
                          style: TextStyle(color: Colors.white, fontSize: 17.sp),
                        );
                      }
                    },
                  ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset('assets/images/search/List.png'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Trouver un docteur', style: TextStyle(color: Colors.white, fontSize: 23.sp),),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //row 1 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                         Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const Back(useAppBar: true,child: MyMedG(),),
                              ),
                            );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,),
                borderRadius: BorderRadius.circular(20),
                        ),
                        height: size.height*0.08,
                        width: size.width*0.43,
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/images/search/doc.svg', width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,),
                              SizedBox(width: 15.w,),
                              Column(children: [
                                Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 18.sp, fontWeight: FontWeight.bold),),
                                Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 18.sp, fontWeight: FontWeight.bold),),
                              ],),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                         decoration: BoxDecoration(
                          gradient: LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,),
                borderRadius: BorderRadius.circular(20),
                        ),
                        height: size.height*0.08,
                        width: size.width*0.43,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/search/baby-boy.svg', height: 50.h,width: 30.w,),
                                SizedBox(width: 8.w,),
                                Text('Pédiatrie' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                //row 2
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset('assets/images/search/fracture.svg',height: 35.h,),
                                      SizedBox(width: 15.w,),
                                      Text('Orthopédie' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 19.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset('assets/images/search/skin.svg', width: 30.w,),
                                    ),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Dermatologie' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                //row 3
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                //row 4
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                //row 5
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        
                      },
                      child: Container(
                        height: 90.h,
                        width: size.width*0.45,
                        child: Stack(
                          children: [
                            SvgPicture.asset('assets/images/search/Rectangle.svg'),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset('assets/images/search/doc.svg'),
                                    SizedBox(width: 15.w,),
                                    Column(children: [
                                      Text('Médecin' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                      Text('Générale' , style:  TextStyle(color: Color(0xff0074AF), fontSize: 20.sp, fontWeight: FontWeight.bold),),
                                    ],),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
        
          ],
        ),
      ),
    );
  }
}