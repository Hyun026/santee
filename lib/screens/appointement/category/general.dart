import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/screens/appointement/search/booking.dart';
//show doc from general field
class MyMedG extends StatefulWidget {
  const MyMedG({super.key});

  @override
  State<MyMedG> createState() => _MyMedGState();
}

class _MyMedGState extends State<MyMedG> {
 //search
  String searchQuery = '';
 Future<int> fetchGeneralDoctorsCount() async {
    var querySnapshot = await FirebaseFirestore.instance
        .collection('doctors')
        .where('field', isEqualTo: 'General')
        .get();
    return querySnapshot.docs.length;
  }

  Stream<QuerySnapshot> fetchGeneralDoctors() {
    return FirebaseFirestore.instance
        .collection('doctors')
        .where('field', isEqualTo: 'General')
        .snapshots();
  }
  @override
  Widget build(BuildContext context) {
      Size size = MediaQuery.of(context).size;
    return Center(
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: size.width * 1,
              height: size.height * 0.73,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
                child:  Column(
                  children: [
                  SizedBox(height: 80.h,),
                     Padding(
              padding: const EdgeInsets.all(20.0),
              child:TextField(
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
    suffixIcon: Icon(Icons.search,color: MyColors.verydeepGrey,),
  ),
),

            ),
            // i want to add 4 buttons 
    Expanded(
  child: Container(
    width: size.width,
    decoration: const BoxDecoration(
      color: MyColors.container2,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(75.0),
      ),
    ),
    child: StreamBuilder<QuerySnapshot>(
      stream: fetchGeneralDoctors(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No doctors found');
        } else {
          var filteredDocs = snapshot.data!.docs.where((doc) {
            var docName = (doc.data() as Map<String, dynamic>)['name'].toLowerCase();
            return docName.contains(searchQuery);
          }).toList();

          if (filteredDocs.isEmpty) {
            return const Text('No doctors found');
          }

          return ListView.builder(
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              var doctorDoc = filteredDocs[index];
              var doctor = doctorDoc.data() as Map<String, dynamic>;
              var imageLink = doctor['imageLink'];
              var isOnline = doctor['online'] ?? false;

              return ListTile(
                title: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Back(
                                useAppBar: true,
                                child: MyBooking(doctorDetails: doctor),
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
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                               Container(
                     height: size.height * 0.08,
              width: size.width * 0.1,
                    decoration: BoxDecoration(
                       borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                      image: DecorationImage(
                        image: NetworkImage(imageLink ?? 'default_image_url'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                                SizedBox(width: 15.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                      'Dr. ${doctor['name'] ?? 'No name'} ${doctor['lastname'] ?? 'No lastname'}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 20.0,color: MyColors.listText,fontWeight: FontWeight.bold),

                      
                    ),
                     Text(doctor['field'] ?? 'No field available'),
                      DoctorRating(rating: doctor['rating']?.toDouble() ?? 0.0),
                    Row(
                      children: [
                        const Icon(Icons.place, color: MyColors.lightGrey),
                        const SizedBox(width: 8.0), 
                        Text(
                         doctor['address'] ?? 'No address available',
                          style: TextStyle(fontSize: 16.sp, color: Colors.black54),
                        ),
                       
                      ],
                      ),


                                  ],
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
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          width: 14.0,
                          height: 14.0,
                          decoration: BoxDecoration(
                            color: isOnline ? Colors.green : Colors.red,
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
                          padding: EdgeInsets.symmetric(horizontal:20 .w,vertical: 220.h),
            child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                
                 children: [
          Container(
  width: 150.0,
  height: 150.0,
  decoration: const BoxDecoration(
    gradient: LinearGradient(
      colors: [MyColors.CalendarToday, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    shape: BoxShape.circle,
  ),
  child: Center(
    child: SizedBox(
      width: 100.0, 
      height: 100.0, 
      child: SvgPicture.asset(
        'assets/images/search/doc.svg',
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
                       const Text('Médecine générale' , style: TextStyle(color: MyColors.navy, fontSize: 17),),
                      
                        const SizedBox(height: 20),
                        FutureBuilder<int>(
                      future: fetchGeneralDoctorsCount(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (!snapshot.hasData || snapshot.data == 0) {
                          return const Text('No doctors found');
                        } else {
                          return Text(
                            '${snapshot.data} doctors available',
                            style: TextStyle(fontSize: 16.0),
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
    );
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
      itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: MyColors.starOn,
      ),
      onRatingUpdate: (rating) {
        
      },
      ignoreGestures: true, 
    );
  }
}