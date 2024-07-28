import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sante_en_poche/screens/appointement/category/general.dart';
import 'package:sante_en_poche/screens/videoCall/videoCall.dart';

class IncomingCallsScreen extends StatelessWidget {
  final String doctorUserId;

  IncomingCallsScreen({required this.doctorUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incoming Calls'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: UserService().getDoctorIncomingCalls(doctorUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No incoming calls'));
          }

          var calls = snapshot.data!;

          return ListView.builder(
            itemCount: calls.length,
            itemBuilder: (context, index) {
              var call = calls[index];
              return ListTile(
                title: Text('Call from User: ${call['callerId']}'),
                subtitle: Text('Channel ID: ${call['channelId']}'),
                trailing: IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Videocall(/*channelId: call['channelId']*/),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
