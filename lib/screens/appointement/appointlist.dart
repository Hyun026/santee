import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sante_en_poche/screens/appointement/search/getRV.dart';
//shows all the appointements i have
class MyAppointements extends StatefulWidget {
  const MyAppointements({super.key});

  @override
  State<MyAppointements> createState() => _MyAppointementsState();
}

class _MyAppointementsState extends State<MyAppointements> {
    final user = FirebaseAuth.instance.currentUser!;
  List<String> docIDs = [];
  Future getDocId() async {
    await FirebaseFirestore.instance
        .collection('appointments')
        .where('user', isEqualTo: user.uid)
        .get()
        .then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
        );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Mes rendez-vous', style: TextStyle(color: Colors.white,fontSize: 17.sp),),
             Expanded(
          child: FutureBuilder(
            future: getDocId(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: docIDs.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: GetMyAppoint(documentId: docIDs[index]),
                  );
                },
              );
            },
          ),
        ),
      
        ],
      ),
    );
    
  }
}