// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class RepoLogin {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   Future<void> loginUser(
//       {required String email, required String password}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     UserCredential user =
//         await auth.signInWithEmailAndPassword(email: email, password: password);
//
//     await prefs.setString(
//       'id',
//       user.user?.uid ?? '',
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_soft_app/core/const/firebase_const.dart';
import 'package:progress_soft_app/core/model/model_user.dart';
import 'package:progress_soft_app/core/servise_network/shared_preferences.dart';

class LoginRepository {
  Future<UserModel?> login({
    required String phone,
    required String password,
  }) async {
    try {
      final user = await _getUserByPhone(phone: phone);
      if (user != null) {
        if (user.password == password) {
          _saveUserDataInShared(user);
          return user;
        } else {
          throw Exception('Invalid password');
        }
      } else {
        throw Exception('User does not exist');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  Future<UserModel?> _getUserByPhone({
    required String phone,
  }) async {
    UserModel? user;
    await FireBaseConstants.usersCollection
        .where('phone', isEqualTo: phone)
        .get()
        .then((value) {
      for (var element in value.docs) {
        if (element.data()['phone'] == phone) {
          user = UserModel.fromJson(value.docs.first.data());
        }
      }
    });
    return user;
  }

  Future<void> _saveUserDataInShared(UserModel user) async {
    AppSharedPref prefe =  await AppSharedPref.getInstance();
    await prefe.setSharedPreferences('id', user.id ?? '');
    await prefe.setSharedPreferences('fullName', user.fullName ?? '');
    await prefe.setSharedPreferences('phone', user.phone ?? '');
    await prefe.setSharedPreferences('gender', user.gender ?? '');
    await prefe.setSharedPreferences('age', user.age ?? '');

  }
}
