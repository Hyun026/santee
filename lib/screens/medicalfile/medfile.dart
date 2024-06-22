import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/firebase/readfile.dart';

class MyMedFile extends StatefulWidget {
  const MyMedFile({super.key});

  @override
  State<MyMedFile> createState() => _MyMedFileState();
}

class _MyMedFileState extends State<MyMedFile> {
 
   final User user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  String collection = '';

  Future<void> checkUserCollection() async {
    // Clear previous results
    docIDs.clear();
    collection = '';

    // Check in 'users' collection
    var userSnapshot = await FirebaseFirestore.instance.collection('users').where('user', isEqualTo: user.uid).get();
    if (userSnapshot.docs.isNotEmpty) {
      collection = 'users';
      docIDs = userSnapshot.docs.map((doc) => doc.id).toList();
      return;
    }

    // Check in 'doctor' collection
    var doctorSnapshot = await FirebaseFirestore.instance.collection('doctors').where('user', isEqualTo: user.uid).get();
    if (doctorSnapshot.docs.isNotEmpty) {
      collection = 'doctors';
      docIDs = doctorSnapshot.docs.map((doc) => doc.id).toList();
      return;
    }
  }

 
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: size.height*0.16,),
          Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    width: size.width * 1,
                    height: size.height * 0.70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: Column(children: [
                      Expanded(
                                child:  FutureBuilder(
                            future: checkUserCollection(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              }
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              if (docIDs.isEmpty) {
                                return Center(child: Text('No documents found for user.'));
                              }
                              return ListView.builder(
                                itemCount: docIDs.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: GetUser(documentId: docIDs[index], collection: collection),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                                
                            
                              
                    ],),
                  ),
                ),
              ),
              //circle
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
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SvgPicture.asset(
                          'assets/images/myfile/icons8_resume.svg',
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
                          'Mon Dossier Médical',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        const Text('Fiche Patient' , style: TextStyle(color: Color(0xff35CBCC), fontSize: 17),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: size.height * 0.1,
            width: size.width * 1,
            decoration: BoxDecoration(
              color: Color(0xffF0FCFF),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                            'assets/images/myfile/doc2(1).svg',
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w,),
                  TextButton(onPressed: () {}, child: Text('Dossiers de Consultation',
                  style: TextStyle(fontSize: 20.sp,color: Color(0xff35CBCC)),
              
                  ), ),
                ],
              ),
            ),
          ),
         
        ],
      
      ),
    );
  }
}

