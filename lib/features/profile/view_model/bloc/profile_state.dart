import 'package:progress_soft_app/core/model/model_user.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserModel userModel;

  ProfileSuccess(this.userModel);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError({required this.message});
}

class ProfileLoggedOut extends ProfileState {}

class ProfileLoadingLoggedOut extends ProfileState {}

class ProfileSuccessLoggedOut extends ProfileState {}

class ProfileErrorLoggedOut extends ProfileState {
  final String message;

  ProfileErrorLoggedOut({required this.message});
}
