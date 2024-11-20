import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/model/model_home.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeGetDataLoading extends HomeState {}

final class HomeGetDataSuccess extends HomeState {
  final List<ModelHome> modelHomeList;
  HomeGetDataSuccess({required this.modelHomeList});
}

final class HomeGetDataError extends HomeState {
  final String error;
  HomeGetDataError({required this.error});
}
