import 'dart:typed_data';


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/firebase/dataRetrieve.dart';
import 'package:sante_en_poche/firebase/imageadd.dart';
import 'package:sante_en_poche/screens/appointement/category/general.dart';
import 'package:sante_en_poche/screens/appointement/search/searchPage.dart';
import 'package:shared_preferences/shared_preferences.dart';


//main page
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
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70.h,
              ),
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
                          border: Border.all(color: Colors.grey, width: 2), 
                        ),
                        child: image == null && image1.isEmpty
                            ? const Center(child: Icon(Icons.person, size: 50))
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
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return Text(
                            snapshot.data ?? 'No message retrieved',
                            style: TextStyle(color: Colors.white, fontSize: 17.sp,fontWeight: FontWeight.bold),
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
              //search
              Container(
                  
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(  topLeft: Radius.circular(30.0),
    topRight: Radius.circular(30.0),bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: MyColors.navy
                ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                             Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Back(useAppBar: false,child: MySearch(),),
                                ),
                              );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(50.0),
                            color: Colors.white
                          ),
                            height: MediaQuery.of(context).size.height * 0.05,
                                        width: MediaQuery.of(context).size.width * 0.9,
                          child:const Padding(
                                          padding: EdgeInsets.all(11.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                        Text(
                          'Chercher un docteur ,  spécialité...',
                          style: TextStyle(color: MyColors.hintTextColor), 
                        ),
                        Icon(Icons.search,color: MyColors.hintTextColor,),
                                            ],
                                          ), 
                        ),
                        ),
                      ),
                      // to be worked on later
                      Container(
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(  bottomRight: Radius.circular(30.0),
    bottomLeft: Radius.circular(30.0),),
                          color: MyColors.navy
                        ),
                            height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.9,
                      ),
                    ],
                  ),
                  ),
              
              SizedBox(
                height: 10.h,
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
                            gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
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
                                SvgPicture.asset('assets/images/search/doc.svg', width: 40.w,
              height: 40.h,
              fit: BoxFit.contain,),
                                SizedBox(width: 15.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text('Médecine' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                  Text('Générale' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
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
                            gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
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
                                  SvgPicture.asset('assets/images/search/baby-boy.svg', height: 40.h,width: 40.w,),
                                  SizedBox(width: 8.w,),
                                  Text('Pédiatrie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                SizedBox(height: 20.sp,),
                  //row 2
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                       height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/search/fracture.svg',height: 40.h,width: 40.w,),
                                  SizedBox(width: 8.w,),
                                  Text('Orthopédie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                           height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 19.0),
                              child: Row(
                                                  
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/search/skin.svg', width: 40.w,height: 40.h,),
                                  SizedBox(width: 5.w,),
                                  Text('Dermatologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
              SizedBox(height: 20.sp,),
                  //row 3
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                           height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/search/eye.svg',height: 25.h,width: 25.w, fit: BoxFit.contain,),
                                  SizedBox(width: 15.w,),
                                  Text('Ophtalmologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                           height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/search/breath.svg', width: 30.w,height: 30.h,),
                                SizedBox(width: 15.w,),
                                Text('Pneumologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                 SizedBox(height: 20.sp,),
                  //row 4
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                          height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/search/heart.svg',width: 30.w,height: 30.w,),
                                  SizedBox(width: 15.w,),
                                  Text('Cardiologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                           height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/search/Nephrologists.svg',height: 30.h,width: 30.w, fit: BoxFit.contain,),
                                SizedBox(width: 15.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text('Gastro-' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                  Text('entérologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                 SizedBox(height: 20.sp,),
                  //row 5
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Container(
                        height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset('assets/images/search/teeth.svg',height: 30.h,width: 30.w,  fit: BoxFit.contain,),
                                SizedBox(width: 15.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text('Médecine' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                  Text('Dentaire' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
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
                           height: size.height*0.08,
                          width: size.width*0.43,
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(colors:[Color(0xffD0E0FC), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,),
                  borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset('assets/images/search/brain.svg'),
                                  SizedBox(width: 15.w,),
                                  Text('Neurologie' , style:  TextStyle(color: const Color(0xff0074AF), fontSize: 17.sp, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
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
      ),
    );
  }
}