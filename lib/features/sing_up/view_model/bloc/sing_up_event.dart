part of 'sing_up_bloc.dart';

@immutable
sealed class SingUpEvent {}

class SentCodeEvent extends SingUpEvent{}
