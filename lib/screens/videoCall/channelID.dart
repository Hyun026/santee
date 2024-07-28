import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future<String?> getUserChannelId(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      if (userDoc.exists) {
        var channelId = userDoc.get('channelId');
        if (channelId != null && channelId is String) {
          return channelId;
        } else {
          print('User channelId is null or not a string');
          return null;
        }
      } else {
        print('User document does not exist');
        return null;
      }
    } catch (e) {
      print('Error retrieving user channelId: $e');
      return null;
    }
  }

  Future<String?> getDoctorChannelId(String doctorId) async {
    try {
      DocumentSnapshot doctorDoc = await FirebaseFirestore.instance.collection('doctors').doc(doctorId).get();
      if (doctorDoc.exists) {
        var channelId = doctorDoc.get('channelId');
        if (channelId != null && channelId is String) {
          return channelId;
        } else {
          print('Doctor channelId is null or not a string');
          return null;
        }
      } else {
        print('Doctor document does not exist');
        return null;
      }
    } catch (e) {
      print('Error retrieving doctor channelId: $e');
      return null;
    }
  }
}
