import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:progress_soft_app/core/model/model_user.dart';
import 'package:progress_soft_app/features/sing_up/view_model/repo/repo_sing_up.dart';
part 'sing_up_event.dart';
part 'sing_up_state.dart';

class SingUpBloc extends Bloc<SingUpEvent, SingUpState> {
  SingUpBloc() : super(PhoneAuthInitial());
  final singUpRepo = SingUpRepo();
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String countryCode = '';
  //
  final otpFormKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  String? selectGender;
  sentCode() {
    log(countryCode + phoneController.text);
    emit(PhoneAuthLoading());
    singUpRepo.sentCode(
      phone: countryCode + phoneController.text,
      onSuccses: () {
        emit(PhoneAuthSuccses());
      },
      onError: (error) {
        emit(PhoneAuthError(error: error));
      },
    );
  }

 void verifyCode() {
    emit(PhoneAuthLoading());
    singUpRepo.verifyCode(
      smsCode: otpController.text,
      user: _handleUserModel(),
      password: passwordController.text,
      onSuccses: () {
        emit(PhoneVerifyCodeSuccses());
      },
      onError: (error) {
        emit(PhoneAuthError(error: error));
      },
    );
  }

  UserModel _handleUserModel() {
    return UserModel(
      phone: phoneController.text,
      fullName: fullNameController.text,
      age: ageController.text,
      gender: selectGender,
    );
  }
}
