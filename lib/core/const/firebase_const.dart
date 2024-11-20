import 'package:cloud_firestore/cloud_firestore.dart';

class FireBaseConstants {
  static final usersCollection = FirebaseFirestore.instance.collection('users');
  static const usersName = 'users';
}
