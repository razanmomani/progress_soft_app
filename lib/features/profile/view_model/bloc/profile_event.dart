part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

final class GetDataUserEvent extends ProfileEvent {}

final class LogoutUserEvent extends ProfileEvent{}
class ChangeLanguageEvent extends ProfileEvent {
  final String languageCode;

  ChangeLanguageEvent(this.languageCode);
}