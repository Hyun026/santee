import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    CollectionReference appoint =
        FirebaseFirestore.instance.collection('appointments');


    return FutureBuilder<DocumentSnapshot>(
      future: appoint.doc(widget.documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            String imageLink = data['imageLink'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(data['weekdate'],
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp)),
                                    Text(data['date'],
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 3.0,
                                  thickness: 5.0,
                                  color: MyColors.lineColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('de',
                                            style: TextStyle(
                                                color: MyColors.navy,
                                                fontSize: 13.sp)),
                                        const SizedBox(width: 5),
                                        Text(data['time'],
                                            style: TextStyle(
                                                color: MyColors.navy,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('à',
                                            style: TextStyle(
                                                color: MyColors.navy,
                                                fontSize: 13.sp)),
                                        const SizedBox(width: 5),
                                        Text(data['to'],
                                            style: TextStyle(
                                                color: MyColors.navy,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 3.0,
                                  thickness: 1.0,
                                  color: MyColors.lineColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Durée',
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp)),
                                    Text(data['durée'],
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const VerticalDivider(
                                  width: 3.0,
                                  thickness: 1.0,
                                  color: MyColors.lineColor,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Il reste',
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp)),
                                    Text(data['resteTime'],
                                        style: TextStyle(
                                            color: MyColors.navy,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
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
                                    ' Dr. ${data['Dname']}  ${data['Dlastname']}',
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    data['Dfield'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
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
