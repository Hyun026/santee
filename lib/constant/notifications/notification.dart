import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sante_en_poche/constant/background/back.dart';

import 'package:sante_en_poche/constant/colors/colors.dart';

import 'package:sante_en_poche/screens/appointement/appointlist.dart';

class NotificationItem extends StatelessWidget {
  final IconData icon;
  final String message;
  final bool isRed;

  NotificationItem({required this.icon, required this.message, this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: isRed ? Colors.red : Colors.blue),
        SizedBox(width: 10),
        Expanded(child: Text(message)),
        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      ],
    );
  }
}

//show notification
class NotificationDialog extends StatefulWidget {
   final VoidCallback onNotificationsRead;

  const NotificationDialog({required this.onNotificationsRead, Key? key})
      : super(key: key);

  @override
  State<NotificationDialog> createState() => _NotificationDialogState();
}

class _NotificationDialogState extends State<NotificationDialog> {
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

    setState(() {
      (context as Element).markNeedsBuild(); 
    });

    widget.onNotificationsRead();
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

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Align(
              alignment: Alignment.topRight,
              child: CustomPaint(
                size: Size(20, 20),
                painter: TrianglePainter(),
              ),
            ),
          ),
          Container(
            width: 350,
            height: 500,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Stack(
                children: [
                  FutureBuilder<QuerySnapshot>(
                  future: fetchUserData(),
                  builder: (context, snapshot) {
                   

                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text('Aucun Notification'));
                    }

                    final documents = snapshot.data!.docs;

                    return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final doc = documents[index];
                        final docId = doc.id;
                        final isClicked = containerStates[docId] ?? false;

                        return GestureDetector(
                          onTap: () => _handleContainerClick(docId),
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            color: allContainersWhite || isClicked ? Colors.white : MyColors.border,
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
                  },
                ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(onPressed: _closeDialog, child: Text('Fermer')),
                            TextButton(
                              onPressed: _turnAllContainersWhite,
                              child: Text("lu"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<QuerySnapshot> fetchUserData() async {
    return FirebaseFirestore.instance
        .collection('notiPat')
        .where('user', isEqualTo: user.uid)
        .orderBy('timestampField', descending: true)
        .get();
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}