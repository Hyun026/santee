import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Data {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getMessage() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return 'User not authenticated';
      }

      
      QuerySnapshot<Map<String, dynamic>> userSnapshot = await _db
          .collection('users')
          .where('user', isEqualTo: user.uid)
          .get();

      if (userSnapshot.docs.isNotEmpty) {
        String message = userSnapshot.docs.first.data()['name'] ?? 'No name found';
        return '$message!';
      } 

      
      QuerySnapshot<Map<String, dynamic>> doctorSnapshot = await _db
          .collection('doctors')
          .where('user', isEqualTo: user.uid)
          .get();

      if (doctorSnapshot.docs.isNotEmpty) {
        String message = doctorSnapshot.docs.first.data()['name'] ?? 'No name found';
        return '$message!';
      } 

      return 'Document does not exist';
    } catch (e) {
      print('Error fetching message: $e');
      return 'Failed to fetch message';
    }
  }
}