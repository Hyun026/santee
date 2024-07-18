import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';

class MyBooking extends StatefulWidget {
   final Map<String, dynamic> doctorDetails;
  const MyBooking({Key? key, required this.doctorDetails}) : super(key: key);

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  final User? user = FirebaseAuth.instance.currentUser;
 //calendar

    DateTime _currentDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  DateTime _displayedDate = DateTime.now();

  final List<String> _months = [
    'janvier', 'février', 'mars', 'avril', 'mai', 'juin', 
    'juillet', 'août', 'septembre', 'octobre', 'novembre', 'décembre'
  ];
  final List<String> _daysOfWeek = [
    'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'
  ];
  final List<int> _years = List.generate(10, (index) => DateTime.now().year - 5 + index);

  List<DateTime> _getWeekDates(DateTime date) {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _updateDisplayedDate(String newValue) {
    final parts = newValue.split(' ');
    final month = _months.indexOf(parts[0]) + 1;
    final year = int.parse(parts[1]);
    setState(() {
      _displayedDate = DateTime(year, month, 1);
    });
  }

  String _formatMonthYear(DateTime date) {
    return '${_months[date.month - 1]} ${date.year}';
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
   
    Size size = MediaQuery.of(context).size;
   final weekDates = _getWeekDates(_displayedDate);
    final monthYear = _formatMonthYear(_displayedDate);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            SizedBox(height: size.height*0.16,),
            Stack(
              children: [
                Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(padding: const EdgeInsets.only(top: 30),
                   child:Container(
                     width: size.width * 1,
                    height: size.height * 0.70,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(75.0),
                      ),
                    ),
                    child:  Padding(
  padding: const EdgeInsets.only(left: 50),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start, 
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Row(
        children: [
          Icon(Icons.today, color: MyColors.navy),
          SizedBox(width: 10),
          Text('Rendez-vous', style: TextStyle(color: MyColors.navy)),
        ],
      ),
      const SizedBox(height: 10),
      const Text(
        "Masahaty Derb Sultan",
        style: TextStyle(color: MyColors.deepGrey, fontSize: 20,fontWeight: FontWeight.bold),
      ),
      // map
    Row(
  children: [
    const Icon(Icons.place, color: MyColors.lightGrey),
    const SizedBox(width: 8.0), 
    Text(
      widget.doctorDetails['address'] ?? "No address available.",
      style: TextStyle(fontSize: 16.sp, color: Colors.black54),
    ),
    //calendar
       Padding(
              padding: const EdgeInsets.all(16.0),
              child: DropdownButton<String>(
                value: monthYear,
                items: _years.expand((int year) {
                  return _months.map((String month) {
                    return DropdownMenuItem<String>(
                      value: '$month $year',
                      child: Text('$month $year'),
                    );
                  }).toList();
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _updateDisplayedDate(newValue);
                  }
                },
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  final date = weekDates[index];
                  final isSelected = date.day == _selectedDate.day &&
                                     date.month == _selectedDate.month &&
                                     date.year == _selectedDate.year;
                  final isToday = date.day == _currentDate.day &&
                                  date.month == _currentDate.month &&
                                  date.year == _currentDate.year;

                  return GestureDetector(
                    onTap: () => _onDateSelected(date),
                    child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? Colors.blue 
                            : isToday 
                                ? Colors.green 
                                : Colors.grey[300],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            _daysOfWeek[index % 7],
                            style: TextStyle(
                              color: isSelected || isToday ? Colors.white : Colors.black,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            date.day.toString(),
                            style: TextStyle(
                              color: isSelected || isToday ? Colors.white : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            //end of calendar
  ],
)

    ],
  ),
)

                   ) ,
                   ),
                ),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      Container(
  height: size.height * 0.15,
  width: size.width * 0.2,
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 5,
        blurRadius: 7,
        offset: const Offset(0, 3),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: const BorderRadius.all(Radius.circular(18.0)), 
    child: Image.network(
      widget.doctorDetails['imageLink'] ?? "No Image uploaded",
      fit: BoxFit.cover,
    ),
  ),
),

                       SizedBox(
                         width: 10.w,
                       ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                                               'Dr. ${widget.doctorDetails['name']} ${widget.doctorDetails['lastname']}',
                                               style:const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                                                            ) ,),
                           SizedBox(
                             height: 10.h,
                           ),
                           const Text('Consultation de spécialité' , style: TextStyle(color: MyColors.navy, fontSize: 17),),
                           Text('data'),
                         ],
                       ),
                     ],
                   ),
              ],
            ),

        ],
      ),
      );
  }
}