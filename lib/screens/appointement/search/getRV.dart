import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';

class GetMyAppoint extends StatefulWidget {
    final String documentId;
  const GetMyAppoint({required this.documentId});

  @override
  State<GetMyAppoint> createState() => _GetMyAppointState();
}

class _GetMyAppointState extends State<GetMyAppoint> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    CollectionReference appoint = FirebaseFirestore.instance.collection('appointments');
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<DocumentSnapshot>(
      future: appoint.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String imageLink = data['imageLink'];

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                     width: size.width * 0.8,
                     decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                     ),

                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child:Row(
                            children: [
                              Column(
                                children: [
                                  Text(data['weekdate']),
                                  Text(data['date']),
                                ],
                              ),
                              Container( child: Container(
            width: 1.0, 
            height: 100.0, 
            color: MyColors.hintTextColor,
          ),)
                            ],
                          ),
                        ),
                         Container(
                           width: size.width * 0.8,
                           child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(imageLink),
                                  radius: 30,
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text(
                                      '${data['Dname']}  ${data['Dlastname']}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color:Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                      
                                    const SizedBox(height: 10),
                                  
                                    Text(
                                      data['Dfield'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ],
                            ), 
                         )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text('Document does not exist');
          }
        }
        return const Text('loading...');
      },
    );
  }
}