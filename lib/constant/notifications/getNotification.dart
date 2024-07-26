import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sante_en_poche/constant/background/backgroun.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/screens/appointement/appointlist.dart';

// Widget for displaying doctor-related documents
class DoctorNotification extends StatelessWidget {
  final String documentId;

  const DoctorNotification({required this.documentId, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('notiDoc').doc(documentId).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('No data available'));
        } else {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          return ListTile(
            title: Text(data['name'] ?? 'No Title'),
            subtitle: Text(data['hey'] ?? 'No Description'),
          );
        }
      },
    );
  }
}

// For patient 

class PatientNotification extends StatefulWidget {
  final String documentId;

  const PatientNotification({required this.documentId, Key? key}) : super(key: key);

  @override
  State<PatientNotification> createState() => _PatientNotificationState();
}

class _PatientNotificationState extends State<PatientNotification> {
  static Set<String> _selectedDocuments = {};

  bool _isSelected = false;
  Map<String, dynamic>? data;

  @override
  void initState() {
    super.initState();
    _isSelected = _selectedDocuments.contains(widget.documentId);
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('notiPat')
          .doc(widget.documentId)
          .get();

      if (mounted) {
        setState(() {
          data = doc.data() as Map<String, dynamic>?;
        });
      }
    } catch (e) {
      // Handle any errors that occur during data fetching
      print('Error fetching data: $e');
    }
  }

  void _handleTap() async {
    setState(() {
      _isSelected = true;
      _selectedDocuments.add(widget.documentId);
    });

    // Navigate to a new page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Backmain(child: MyAppointements()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        decoration: BoxDecoration(
          color: _isSelected ? Colors.white : Colors.greenAccent,
          border: Border(
            bottom: BorderSide(
              color: MyColors.hintTextColor,
              width: 2.0,
            ),
          ),
        ),
        child: ListTile(
          leading: const Icon(Icons.notifications, color: MyColors.logoutButton),
          title: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: 'Un rendez-vous est créé pour le ',
                  style: TextStyle(color: MyColors.notiText),
                ),
                TextSpan(
                  text: data!['date'] ?? 'No Description',
                  style: const TextStyle(color: MyColors.notiText),
                ),
                const TextSpan(
                  text: ' à ',
                  style: TextStyle(color: MyColors.notiText),
                ),
                TextSpan(
                  text: data!['time'] ?? 'No Description',
                  style: const TextStyle(color: MyColors.notiText),
                ),
                const TextSpan(
                  text: ' avec Dr.',
                  style: TextStyle(color: MyColors.notiText),
                ),
                TextSpan(
                  text: data!['Dname'] ?? 'No Description',
                  style: const TextStyle(color: MyColors.notiText),
                ),
                TextSpan(
                  text: ' ' + (data!['Dlastname'] ?? 'No Description'),
                  style: const TextStyle(color: MyColors.notiText),
                ),
              ],
            ),
          ),
          trailing: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}