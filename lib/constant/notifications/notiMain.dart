import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sante_en_poche/constant/background/back.dart';
import 'package:sante_en_poche/constant/colors/colors.dart';
import 'package:sante_en_poche/screens/appointement/appointlist.dart';

class NotiPatient extends StatefulWidget {
   
  const NotiPatient({super.key});
  @override
  State<NotiPatient> createState() => _NotiPatientState();
}

class _NotiPatientState extends State<NotiPatient> {
  final user = FirebaseAuth.instance.currentUser!;
  Map<String, bool> containerStates = {};
  bool allContainersWhite = false;

  @override
  void initState() {
    super.initState();
    _initializeContainerStates();
  }

  Future<void> _initializeContainerStates() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiPat')
        .where('user', isEqualTo: user.uid)
        .orderBy('timestampField', descending: true)
        .get();

    print('Fetched ${querySnapshot.docs.length} documents'); 

    final newStates = <String, bool>{};
    for (var doc in querySnapshot.docs) {
      newStates[doc.id] = doc['isRead'] ?? false;
    }

    setState(() {
      containerStates = newStates;
    });

    _updateUnreadCount();
  }

  Future<void> _updateUnreadCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiPat')
        .where('user', isEqualTo: user.uid)
        .where('isRead', isEqualTo: false)
        .get();

    final count = querySnapshot.docs.length;
    print('Unread count: $count'); 

    setState(() {});
  }

  void _handleContainerClick(String docId) async {
    setState(() {
      containerStates[docId] = true;
    });

    await FirebaseFirestore.instance.collection('notiPat').doc(docId).update({
      'isRead': true,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Back(child: MyAppointements())),
    );

    _updateUnreadCount();
  }

  void _turnAllContainersWhite() async {
    final batch = FirebaseFirestore.instance.batch();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiPat')
        .where('user', isEqualTo: user.uid)
        .get();

    for (var doc in querySnapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();

    setState(() {
      allContainersWhite = true;
    });

    _updateUnreadCount();
  }

  void _closeDialog() {
    Navigator.pop(context);
  }

  Future<List<DocumentSnapshot>> fetchUserData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notiPat')
        .where('user', isEqualTo: user.uid)
        .orderBy('timestampField', descending: true)
        .get();

    return querySnapshot.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<DocumentSnapshot>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
           if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Aucun Notification'));
            } else {
              List<DocumentSnapshot> documents = snapshot.data!;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  final docId = doc.id;
                  final isClicked = containerStates[docId] ?? false;
                  var data = documents[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                         color: allContainersWhite || isClicked ? Colors.white : MyColors.border,
                      ),
                       margin: EdgeInsets.symmetric(vertical: 8),
                               
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
                                            text: doc['date'] ?? 'No Date',
                                            style: const TextStyle(color: MyColors.notiText),
                                          ),
                                          const TextSpan(
                                            text: ' à ',
                                            style: TextStyle(color: MyColors.notiText),
                                          ),
                                          TextSpan(
                                            text: doc['time'] ?? 'No Time',
                                            style: const TextStyle(color: MyColors.notiText),
                                          ),
                                          const TextSpan(
                                            text: ' avec Dr.',
                                            style: TextStyle(color: MyColors.notiText),
                                          ),
                                          TextSpan(
                                            text: doc['Dname'] ?? 'No First Name',
                                            style: const TextStyle(color: MyColors.notiText),
                                          ),
                                          TextSpan(
                                            text: ' ' + (doc['Dlastname'] ?? 'No Last Name'),
                                            style: const TextStyle(color: MyColors.notiText),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: const Icon(Icons.navigate_next),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
    );
    
  }
}



//for doctor
class NotiDoctor extends StatefulWidget {
  const NotiDoctor({super.key});

  @override
  State<NotiDoctor> createState() => _NotiDoctorState();
}

class _NotiDoctorState extends State<NotiDoctor> {
 final user = FirebaseAuth.instance.currentUser!;
  Map<String, bool> containerStates = {};
  bool allContainersWhite = false;

  @override
  void initState() {
    super.initState();
    _initializeContainerStates();
  }

  Future<void> _initializeContainerStates() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiDoc')
        .where('user', isEqualTo: user.uid)
        .orderBy('timestampField', descending: true)
        .get();

    print('Fetched ${querySnapshot.docs.length} documents'); 

    final newStates = <String, bool>{};
    for (var doc in querySnapshot.docs) {
      newStates[doc.id] = doc['isRead'] ?? false;
    }

    setState(() {
      containerStates = newStates;
    });

    _updateUnreadCount();
  }

  Future<void> _updateUnreadCount() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiDoc')
        .where('user', isEqualTo: user.uid)
        .where('isRead', isEqualTo: false)
        .get();

    final count = querySnapshot.docs.length;
    print('Unread count: $count'); 

    setState(() {});
  }

  void _handleContainerClick(String docId) async {
    setState(() {
      containerStates[docId] = true;
    });

    await FirebaseFirestore.instance.collection('notiDoc').doc(docId).update({
      'isRead': true,
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Back(child: MyAppointements())),
    );

    _updateUnreadCount();
  }

  void _turnAllContainersWhite() async {
    final batch = FirebaseFirestore.instance.batch();
    final querySnapshot = await FirebaseFirestore.instance
        .collection('notiDoc')
        .where('user', isEqualTo: user.uid)
        .get();

    for (var doc in querySnapshot.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();

    setState(() {
      allContainersWhite = true;
    });

    _updateUnreadCount();
  }

  void _closeDialog() {
    Navigator.pop(context);
  }

  Future<List<DocumentSnapshot>> fetchUserData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('notiDoc')
        .where('user', isEqualTo: user.uid)
        .orderBy('timestampField', descending: true)
        .get();

    return querySnapshot.docs;
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<DocumentSnapshot>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
           if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Aucun Notification'));
            } else {
              List<DocumentSnapshot> documents = snapshot.data!;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  final docId = doc.id;
                  final isClicked = containerStates[docId] ?? false;
                  var data = documents[index].data() as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                         color: allContainersWhite || isClicked ? Colors.white : MyColors.border,
                      ),
                       margin: EdgeInsets.symmetric(vertical: 8),
                               
                      child:  ListTile(
                              leading: const Icon(Icons.notifications, color: MyColors.logoutButton),
                              title: RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Un rendez-vous est créé chez vous pour le ',
                                      style: TextStyle(color: MyColors.notiText),
                                    ),
                                    TextSpan(
                                      text: doc['date'] ?? 'No Date',
                                      style: const TextStyle(color: MyColors.notiText),
                                    ),
                                    const TextSpan(
                                      text: ' à ',
                                      style: TextStyle(color: MyColors.notiText),
                                    ),
                                    TextSpan(
                                      text: doc['time'] ?? 'No Time',
                                      style: const TextStyle(color: MyColors.notiText),
                                    ),
                                      const TextSpan(
                                      text: " d'aprés ",
                                      style: TextStyle(color: MyColors.notiText),
                                    ),
                                  
                                    TextSpan(
                                      text: ' ' + (doc['name'] ?? 'no Name'),
                                      style: const TextStyle(color: MyColors.notiText),
                                    ),
                                      TextSpan(
                                      text: ' ' + (doc['lastname'] ?? ' no lastName'),
                                      style: const TextStyle(color: MyColors.notiText),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: const Icon(Icons.navigate_next),
                            ),
                    ),
                  );
                },
              );
            }
          },
        ),
    );
    
  }
}


