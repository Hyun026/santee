import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/constant/buttons/gbuttons.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/screens/appointement/search/booking.dart';
import 'package:sante_en_poche/screens/videoCall/videoCall.dart';
import 'package:uuid/uuid.dart';

class Gastro extends StatefulWidget {
  const Gastro({super.key});

  @override
  State<Gastro> createState() => _GastroState();
}

class _GastroState extends State<Gastro> {
  User? user = FirebaseAuth.instance.currentUser;
  String searchQuery = '';
  int _selectedIndex = 0;

  Future<String> getCurrentUserChannel() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        return userDoc.data()?['channelId'] ?? '';
      }
    }
    throw Exception('User or Channel ID not found');
  }

  Future<int> fetchGeneralDoctorsCount() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('field', isEqualTo: 'Gastro-entérologue')
        .get();
    return querySnapshot.docs.length;
  }

  Stream<QuerySnapshot> fetchGeneralDoctors() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('field', isEqualTo: 'Gastro-entérologue')
        .snapshots();
  }

  Stream<QuerySnapshot> fetchFilteredDoctors() {
  var collection = FirebaseFirestore.instance
      .collection('doctors')
      .where('field', isEqualTo: 'Gastro-entérologue');

  if (_selectedIndex == 0) {
    // Filter for online doctors
    return collection.where('online', isEqualTo: true).snapshots();
  } else if (_selectedIndex == 1) {
    // Filter for doctors in Masahaty
    return collection
        .where('localisation', isEqualTo: 'Masahaty')
        .snapshots();
  } else if (_selectedIndex == 2) {
    // Filter for doctors who offer home visits
    return collection
        .where('localisation', isEqualTo: 'Domicile')
        .snapshots();
  } else {
    // Default to all doctors
    return collection.snapshots();
  }
}

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
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Container(
                    width: size.width * 1,
                    height: size.height * 0.73,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      
                        Padding(
                          padding: const EdgeInsets.only(right: 20,top: 80, left: 20),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value.toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Docteur, Allergie, Autisme,..',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: MyColors.searchFill,
                              suffixIcon: const Icon(
                                Icons.search,
                                color: MyColors.verydeepGrey,
                              ),
                            ),
                          ),
                        ),
                        Gbuttons(
                          selectedIndex: _selectedIndex,
                          onButtonPressed: (index) {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                        ),
                        Expanded(
                          child: Container(
                            width: size.width,
                            decoration: const BoxDecoration(
                              color: MyColors.container2,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                              ),
                            ),
                            child: StreamBuilder<QuerySnapshot>(
                              stream: fetchFilteredDoctors(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else if (!snapshot.hasData ||
                                    snapshot.data!.docs.isEmpty) {
                                  return const Padding(
                                    padding: EdgeInsets.all(25.0),
                                    child: Text('Aucun docteur'),
                                  );
                                } else {
                                  var filteredDocs =
                                      snapshot.data!.docs.where((doc) {
                                    var data =
                                        doc.data() as Map<String, dynamic>;
                                    var docName =
                                        data['name']?.toLowerCase() ?? '';
                                    return docName
                                        .contains(searchQuery.toLowerCase());
                                  }).toList();

                                  if (filteredDocs.isEmpty) {
                                    return const Padding(
                                      padding: EdgeInsets.all(25.0),
                                      child: Text('Aucun docteur'),
                                    );
                                  }

                                  return ListView.builder(
                                    itemCount: filteredDocs.length,
                                    itemBuilder: (context, index) {
                                      var doctorDoc = filteredDocs[index];
                                      var doctor = doctorDoc.data()
                                          as Map<String, dynamic>;
                                      var imageLink = doctor['imageLink'];
                                      var isOnline = doctor['online'] ?? false;

                                      return ListTile(
                                        title: Stack(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(11.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          Back(
                                                        useAppBar: true,
                                                        child: MyBooking(
                                                            doctorDetails:
                                                                doctor),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Container(
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.5),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: const Offset(0, 3),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  size.height *
                                                                      0.08,
                                                              width:
                                                                  size.width *
                                                                      0.1,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                        Radius.circular(
                                                                            20.0)),
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      imageLink ??
                                                                          'default_image_url'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                            0.5),
                                                                    spreadRadius:
                                                                        2,
                                                                    blurRadius:
                                                                        5,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 15.w),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Dr. ${doctor['name'] ?? 'No name'} ${doctor['lastname'] ?? 'No lastname'}',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12.0,
                                                                      color: MyColors
                                                                          .listText,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(doctor[
                                                                        'field'] ??
                                                                    'No field available',style: const TextStyle(fontSize: 12,color: Colors.black54),),
                                                                DoctorRating(
                                                                    rating: doctor['rating']
                                                                            ?.toDouble() ??
                                                                        0.0),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                        Icons
                                                                            .place,
                                                                        color: MyColors
                                                                            .lightGrey,size: 12,),
                                                                    const SizedBox(
                                                                        width:
                                                                            5.0),
                                                                    Text(
                                                                      doctor['localisation'] ??
                                                                          'No address available',
                                                                      style: TextStyle(
                                                                          fontSize: 12
                                                                              .sp,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),

                                                        //video call
                                                        /*  GestureDetector(
  onTap: () async {
    String userChannel = await getCurrentUserChannel();
    String channelId = generateChannelId();
     
    String? doctorChannelId = await UserService().getDoctorChannelId(doctor['user']);

    // Save call data to Firestore
    Map<String, dynamic> dataToSave2 = {
      'callerId': user!.uid, // i get erro
      'Doctor': doctor['user'],
      'channelId': channelId,
      'Calling': true,
      'docChannel': doctorChannelId
    };
    await FirebaseFirestore.instance.collection("calls").add(dataToSave2);

    // Navigate to VideoCall screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Videocall(channelId:channelId),
      ),
    );
  },*/
                                                        GestureDetector(
                                                          onTap: () async {
                                                            String userChannel =
                                                                await getCurrentUserChannel();
                                                            String channelId =
                                                                generateChannelId();
                                                            String?
                                                                doctorChannelId =
                                                                await UserService()
                                                                    .getDoctorChannelId(
                                                                        doctor[
                                                                            'user']);

                                                            // Save call data to Firestore
                                                            Map<String, dynamic>
                                                                dataToSave2 = {
                                                              'callerId':
                                                                  user!.uid,
                                                              'Doctor': doctor[
                                                                  'user'],
                                                              'channelId':
                                                                  channelId,
                                                              'Calling': true,
                                                              'docChannel':
                                                                  doctorChannelId
                                                            };
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "calls")
                                                                .add(
                                                                    dataToSave2);

                                                            // Navigate to VideoCall screen
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const Videocall(
                                                                        /*channelId: channelId*/),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Colors.red,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Icon(
                                                              Icons.videocam,
                                                              color:
                                                                  Colors.white,
                                                              size: 25,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              left: 0,
                                              top: 0,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Container(
                                                  margin: const EdgeInsets.all(8.0),
                                                  width: 14.0,
                                                  height: 14.0,
                                                  decoration: BoxDecoration(
                                                    color: isOnline
                                                        ? Colors.green
                                                        : Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 90.0.w,
                        height: 90.0.h,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [ Colors.white,MyColors.CalendarToday,],
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 50.0.w,
                            height: 50.0.h,
                            child: SvgPicture.asset(
                              'assets/images/search/Nephrologists.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          const Text(
                            'Gastro-entérologue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                           SizedBox(height: 8.h),
                          FutureBuilder<int>(
                            future: fetchGeneralDoctorsCount(),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data == 0) {
                                return const Text('Aucun docteur');
                              } else {
                                return Text(
                                  '${snapshot.data} Docteurs',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      color: MyColors.labeltext),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String generateChannelId() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}

class DoctorRating extends StatelessWidget {
  final double rating;

  DoctorRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: rating,
      itemSize: 15.0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: MyColors.starOn,
      ),
      onRatingUpdate: (rating) {},
      ignoreGestures: true,
    );
  }
}

class UserService {
  Future<String?> getDoctorChannelId(String doctorUserId) async {
    var doctorDoc = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(doctorUserId)
        .get();
    if (doctorDoc.exists) {
      return doctorDoc.data()?['channelId'];
    }
  }

  Stream<List<Map<String, dynamic>>> getDoctorIncomingCalls(
      String doctorUserId) {
    return FirebaseFirestore.instance
        .collection('calls')
        .where('Doctor', isEqualTo: doctorUserId)
        .where('Calling', isEqualTo: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
