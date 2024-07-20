import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late TextEditingController _dateController;
  final TextEditingController _weekdayController = TextEditingController();
   TextEditingController timeDifferenceController = TextEditingController();
   late TextEditingController timeDifferenceInMinutesController;

 

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

   final Map<String, String> _weekdayNames = {
  'Lun': 'Lundi',
  'Mar': 'Mardi',
  'Mer': 'Mercredi',
  'Jeu': 'Jeudi',
  'Ven': 'Vendredi',
  'Sam': 'Samedi',
  'Dim': 'Dimanche'
};

  final List<int> _years = List.generate(10, (index) => DateTime.now().year - 5 + index);

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
     selectedTimeController.text = selectedTime;
      timeDifferenceController = TextEditingController();
 timeDifferenceInMinutesController = TextEditingController();
  }

  List<DateTime> _getWeekDates(DateTime date) {
    DateTime firstDayOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return List.generate(7, (index) => firstDayOfWeek.add(Duration(days: index)));
  }

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _dateController.text = date.toIso8601String(); 
      final index = (date.weekday - 1) % 7; 
  final shortWeekday = _daysOfWeek[index];
  final fullWeekday = _weekdayNames[shortWeekday] ?? shortWeekday; 
  _weekdayController.text = fullWeekday;
    _updateDateDifference();
      
    });
  }

  void _onNewTimeChanged(String newTime) {
  setState(() {
    _updateTimeDifference(newTime);
  });
}


  final List<DateTime> weekDates = List.generate(7, (index) {
    final now = DateTime.now();
    return now.add(Duration(days: index - now.weekday % 7));
  });

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

//hour
 List<String> times = [
    "10:00", "10:45", "11:30", "12:15", "13:00",
    "14:00", "14:30", "15:00", "15:30", "16:00"
  ];

  String selectedTime = "10:45";
  TextEditingController selectedTimeController = TextEditingController();
  TextEditingController newTimeController = TextEditingController();

 
  //calculate diff
  void _updateDateDifference() {
  final difference = _selectedDate.difference(_currentDate).inDays;
  timeDifferenceController.text = '$difference jours';
}

void _updateTimeDifference(String newTime) {
  final selectedTimeDateTime = DateTime(
    _selectedDate.year,
    _selectedDate.month,
    _selectedDate.day,
    int.parse(selectedTime.split(':')[0]),
    int.parse(selectedTime.split(':')[1]),
  );

  final newTimeDateTime = DateTime(
    _selectedDate.year,
    _selectedDate.month,
    _selectedDate.day,
    int.parse(newTime.split(':')[0]),
    int.parse(newTime.split(':')[1]),
  );

  final difference = newTimeDateTime.difference(selectedTimeDateTime).inMinutes;
  timeDifferenceInMinutesController.text = '$difference minutes'; 
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
      List<DateTime> weekDates = _getWeekDates(_displayedDate);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            SizedBox(height: size.height*0.232,),
            Stack(
              children: [
                Align(
                   alignment: Alignment.bottomCenter,
                   child: Padding(padding: const EdgeInsets.only(top: 30),
                   child:Container(
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
                        const SizedBox(height: 90,),
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
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
                             
                            ],
                            ),
                            //calendar
                           Align(
                                    alignment: Alignment.topLeft,
                                    child: DropdownButton<String>(
                                      value: _formatMonthYear(_displayedDate),
                                      items: _years.expand((int year) {
                                        return _months.map((String month) {
                                          return DropdownMenuItem<String>(
                                            value: '$month $year',
                                            child: Text(
                          '$month $year',
                          style: const TextStyle(
                            color: MyColors.deepGrey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                                            ),
                                          );
                                        }).toList();
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if (newValue != null) {
                                          _updateDisplayedDate(newValue);
                                        }
                                      },
                                      underline: const SizedBox(),
                                      iconEnabledColor: MyColors.CalendarDropDown,
                                    ),
                                  ),
                            
                                     Row(
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
                                          margin: const EdgeInsets.all(4),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: isSelected 
                            ? MyColors.CalendarChoosen
                            : isToday 
                                ? MyColors.CalendarToday
                                : MyColors.calendarGrey, 
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
                          const SizedBox(height: 8),
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
                              Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Heures de visites",
                                style: TextStyle(
                                  color: MyColors.deepGrey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10), 
                              Wrap(
                                spacing: 10,  
                                runSpacing: 10,  
                                children: List.generate(times.length, (index) {
                                  return SizedBox(
                                    width: (MediaQuery.of(context).size.width - 70) / 5,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedTime = times[index];
                DateTime parsedTime = DateFormat("HH:mm").parse(selectedTime);
                DateTime newTime = parsedTime.add(Duration(minutes: 45));
                String formattedNewTime = DateFormat("HH:mm").format(newTime);
                selectedTimeController.text = selectedTime;
                newTimeController.text = formattedNewTime;
                                        });
                                      },
                                      child: Container(
                                        
                                        height: 30, 
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: selectedTime == times[index] ? MyColors.CalendarChoosen : MyColors.CalendarToday,
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        child: Text(
                                          times[index],
                                          style: TextStyle(
                                            color: selectedTime == times[index] ? Colors.white : MyColors.navy,
                                            fontWeight: selectedTime == times[index] ? FontWeight.bold : FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height*0.10,),
                          //booking button
                          Center(
                            child: ElevatedButton(onPressed: ()async {
                                if (selectedTimeController.text.isEmpty ||
                                _dateController.text.isEmpty ) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('All fields are required'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }else{
                                 String userName = await getCurrentUserName();
                             String userImage = await getCurrentImage();
                             //give me a string equal 45 mins
                               Map<String, dynamic> dataToSave = {
                                'user': user!.uid,
                                'date': _dateController.text,
                                'time': selectedTimeController.text,
                                'name': userName,
                                 'Doctor':widget.doctorDetails['user'],
                                 'Dname':widget.doctorDetails['name'],
                                 'Dlastname':widget.doctorDetails['lastname'],
                                 'Dfield':widget.doctorDetails['field'],
                                 'imageLink':widget.doctorDetails['imageLink'],
                                 'to': newTimeController.text,
                                 'durée':'45 mins',
                                 'weekdate':_weekdayController.text,
                                 'userImage':userImage,
                                 'resteDate':timeDifferenceController.text,
                                 'resteTime': timeDifferenceInMinutesController.text,
                                 
                              };

                             await FirebaseFirestore.instance.collection("appointments").add(dataToSave);
                              Navigator.pop(context);
                            } 
                            
                            },
                            style: ElevatedButton.styleFrom(
                               minimumSize: Size(100.w, 50.h),
                                 shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: MyColors.buttonRes,
                            ),
                            child: const Text('Réservez un rendez-vous',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),) ),
                          ),
                          
                          
                              ],
                            ),
                          ),
                        ),
                      ],
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
                            Text( widget.doctorDetails['phone'] ?? "No phone available.",style: const TextStyle(color: MyColors.hintTextColor),),
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
   @override
  void dispose() {
    _dateController.dispose();
     selectedTimeController.dispose();
      _weekdayController.dispose(); 
    super.dispose();
  }
}