import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/model/model_user.dart';
import 'package:progress_soft_app/features/profile/view_model/bloc/profile_state.dart';
import 'package:progress_soft_app/features/profile/view_model/repo/repo_profile.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  RepoProfiles repoProfiles = RepoProfiles();
  String selectedLanguage = 'en';
  ProfileBloc() : super(ProfileInitial()) {
    on<GetDataUserEvent>((event, emit) async {
      emit(ProfileLoading());

      try {
        UserModel user = await repoProfiles.getUserData();
        emit(ProfileSuccess(user));
      } on FirebaseException catch (e) {
        print("Profile user $e");
        emit(ProfileError(message: e.message ?? 'SomeThing Error'));
      }
    });
  }

  logout() async {
    try {
      emit(ProfileLoadingLoggedOut());
      await repoProfiles.logout();
      emit(ProfileSuccessLoggedOut());
    } on FirebaseException catch (e) {
      emit(ProfileErrorLoggedOut(message: e.message ?? 'Error logout'));
    }
  }
}
