
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/const/api_string.dart';
import 'package:progress_soft_app/core/model/model_home.dart';
import 'package:progress_soft_app/core/servise_network/htpp.dart';
import 'package:progress_soft_app/features/home/view_model/bloc/home_event.dart';
import 'package:progress_soft_app/features/home/view_model/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  List<ModelHome> _allModelHomes = [];
  final searchController = TextEditingController();
  HomeBloc() : super(HomeInitial()) {
    {
      on<GetDataHomeEvent>((event, emit) async {
        emit(HomeGetDataLoading());

        try {
          final response = await AHttpHelper.get(ApiString.posts);

          if (response is List) {
            _allModelHomes =
                response.map((data) => ModelHome.fromJson(data)).toList();
            emit(HomeGetDataSuccess(modelHomeList: _allModelHomes));
          } else {
            emit(HomeGetDataError(error: 'Unexpected response format'));
          }
        } catch (error) {
          emit(HomeGetDataError(error: error.toString()));
        }
      });

      on<SearchPostsEvent>((event, emit) {
        if (_allModelHomes.isEmpty) {
          emit(HomeGetDataError(error: 'No data available to search.'));
          return;
        }

        final filteredList = _allModelHomes
            .where((model) =>
                model.title!.toLowerCase().contains(event.title.toLowerCase()))
            .toList();

        emit(HomeGetDataSuccess(modelHomeList: filteredList));
      });
    }
  }

  // String _formatTitleForSearch(String title) {
  //   title = title.toLowerCase();
  //   return title.replaceAll(' ', '');
  // }
}
