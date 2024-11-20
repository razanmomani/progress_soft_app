import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:progress_soft_app/core/model/model_user.dart';

class SingUpRepo {
  String? verificationId;
  Future<void> sentCode({
    required String phone,
    required Function() onSuccses,
    required Function(String error) onError,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (String verificationId, int? resendToken) async {
          this.verificationId = verificationId;
          onSuccses();
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
        verificationFailed: (FirebaseAuthException error) {
          onError(error.message ?? '');
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          onError('Time Out');
        },
      );
    } on FirebaseAuthException catch (error) {
      onError(error.message ?? '');
    }
  }

  Future<void> verifyCode({
    required String smsCode,
    required UserModel user,
    required String password,
    required Function() onSuccses,
    required Function(String error) onError,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId ?? '',
      smsCode: smsCode,
    );
    final userInfo =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (userInfo.user == null) {
      onError('Something Wrong');
    } else {
      user.id = userInfo.user?.uid;
      await saveUserData(user: user, password: password);
      onSuccses();
    }
  }

  Future<void> saveUserData({
    required UserModel user,
    required String password,
  }) async {
    await FirebaseFirestore.instance.collection('users').doc(user.id).set({
      'phone': user.phone,
      'age': user.age,
      'gender': user.gender,
      'fullName': user.fullName,
      'id': user.id,
      'password': password,
    });
  }
}
