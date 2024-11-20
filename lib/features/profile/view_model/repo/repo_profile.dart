import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_soft_app/core/model/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RepoProfiles {
  UserModel user = UserModel();
  Future<UserModel> getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = pref.getString('id') ?? '';

    print("user id: $id");
    var responses =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    user = UserModel.fromJson(responses.data());
    return user;
    print(responses.data());
  }

  Future<void> logout() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signOut();
      await pref.remove("id");
      print('User logged out successfully');
    } on FirebaseException catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
