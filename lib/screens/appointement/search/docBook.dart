import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
//page to book the doctor 
class MyResult extends StatefulWidget {
  final Map<String, dynamic> doctorDetails;

  const MyResult({Key? key, required this.doctorDetails}) : super(key: key);

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  String? valueChoose;
  List<String> listItem = [
    "9:00-10:00",
    "10:00-11:00",
    "11:00-12:00",
    "13:00-14:00",
    "14:00-15:00",
    "15:00-16:00",
    "16:00-17:00",
    "17:00-18:00",
    "18:00-18:30"
  ];

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      _dateController.text = selectedDay
          .toLocal()
          .toString()
          .split(' ')[0]; 
    });
  }

 Future<String> getCurrentUserName() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['name'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}

Future<String> getCurrentImage() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return userDoc['imageLink'] ?? 'Unknown User'; 
    }
  }
  return 'Unknown User';
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
       
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(widget.doctorDetails['imageLink']),
                ),
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Dr. ${widget.doctorDetails['name']} ${widget.doctorDetails['lastname']}',
                      style: TextStyle(
                          fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      widget.doctorDetails['field'],
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.sp),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_pin, color: Colors.redAccent),
                    SizedBox(width: 5.sp),
                    Text(
                      widget.doctorDetails['city'] ?? "No address",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(width: 10.sp),
                    Text(
                      widget.doctorDetails['address'] ?? "No address",
                      style: TextStyle(fontSize: 18.sp),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.sp),
              Text(
                'About Dr. ${widget.doctorDetails['name']} ${widget.doctorDetails['lastname']}',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 10.sp),
              Text(
                widget.doctorDetails['bio'] ?? "No biography available.",
                style: TextStyle(fontSize: 16.sp, color: Colors.black54),
              ),
              SizedBox(height: 30.sp),

              Text(
                'Diploma',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              
              SizedBox(height: 10.sp),
             Container(
  width: 100, 
  height: 100, 
  child: Image.network(
    widget.doctorDetails['diploma'] ?? "No Diploma uploaded",
    fit: BoxFit.cover, 
  ),
),

              SizedBox(height: 30.sp),
              Text(
                'Contact Information',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  const Icon(Icons.email, color: Colors.blue),
                  SizedBox(width: 10.sp),
                  Text(
                    widget.doctorDetails['email'] ?? "No email available",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(height: 10.sp),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.green),
                  SizedBox(width: 10.sp),
                  Text(
                    widget.doctorDetails['phone'] ?? "No phone number available",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    
   /*bottomNavigationBar:BottomAppBar(
    color: Colors.white,
    child: 
     
   ),*/
    
    );
  }
}
