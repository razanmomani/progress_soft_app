part of 'sing_up_bloc.dart';

@immutable
sealed class SingUpState {}

final class PhoneAuthInitial extends SingUpState {}

final class PhoneAuthLoading extends SingUpState {}

final class PhoneAuthSuccses extends SingUpState {}

final class PhoneVerifyCodeSuccses extends SingUpState {}

final class PhoneAuthError extends SingUpState {
  final String error;
  PhoneAuthError({required this.error});
}
