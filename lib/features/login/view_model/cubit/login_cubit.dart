import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/features/login/view_model/cubit/login_state.dart';
import 'package:progress_soft_app/features/login/view_model/reposetry_login/repo_login.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final formKeyLogin = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String countryCode = '';
  final LoginRepository loginRepository = LoginRepository();

  Future<void> loginUser() async {
    print('Attempting to log in...');
    //  if (formKeyLogin.currentState?.validate() ?? false) {
    print(
        "Attempting to login with phone: ${countryCode + phoneController.text} and password: ${passwordController.text}");
    emit(LoginLoading());
    try {
      final user = await loginRepository.login(
          phone: phoneController.text.trim(),
          password: passwordController.text.trim());
      if (user != null) {
        print('Login successful: $user');
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailure(tr('loginFailed')));
      }
    } on FirebaseException catch (e) {
      print('loginErorr ${e.toString()}');
      emit(LoginFailure(e.toString()));
    }
    // } else {
    //   emit( LoginFailure(tr('invalidError')));
    // }
  }
}
//
// String? validatePhone(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Phone number is required';
//   }
//   return null;
// }
//
// String? validatePassword(String? value) {
//   if (value == null || value.isEmpty) {
//     return 'Password is required';
//   }
//   return null;
// }
