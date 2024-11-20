// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:progress_soft_app/core/servise_network/shared_preferences.dart';
//
// bool userIsSignIn = false;
//
// Future<void> checkIfUserSignIn() async {
//   AppSharedPreferences prefs = await AppSharedPreferences.getInstance();
//   String? id = await prefs.getSharedPreferences('id');
//   try {
//     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(id).get();
//     if (doc.exists) {
//       userIsSignIn = true;
//       await prefs.setUserSignInStatus(true);
//     } else {
//       userIsSignIn = false;
//       await prefs.setUserSignInStatus(false);
//     }
//   } catch (e) {
//     //  print("Error checking sign-in status: $e");
//     userIsSignIn = false;
//     await prefs.setUserSignInStatus(false);
//   }
// }
import 'package:progress_soft_app/core/servise_network/shared_preferences.dart';

bool userIsSignIn = false;
Future<void> checkIfUserSignIn() async {
  AppSharedPref prefs = await AppSharedPref.getInstance();
  String? id = await prefs.getSharedPreferences('id');
  try {
    if (id.isNotEmpty) {
      userIsSignIn = true;
      await prefs.setUserSignInStatus(true);
    } else {
      userIsSignIn = false;
      await prefs.setUserSignInStatus(false);
    }
  } catch (e) {
    //  print("Error checking sign-in status: $e");
    userIsSignIn = false;
    await prefs.setUserSignInStatus(false);
  }
}
