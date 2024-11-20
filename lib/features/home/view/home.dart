import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/widgets/general/custom_loading.dart';
import 'package:progress_soft_app/features/home/view_model/bloc/home_bloc.dart';
import 'package:progress_soft_app/features/home/view_model/bloc/home_event.dart';
import 'package:progress_soft_app/features/home/view_model/bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetDataHomeEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AColors.primary,
          title: Builder(
            builder: (context) {
              return TextField(
                onChanged: (query) {
                  BlocProvider.of<HomeBloc>(context)
                      .add(SearchPostsEvent(title: query));
                },
                decoration: InputDecoration(
                  hintText: tr('search'),
                  border: InputBorder.none,
                  hintStyle: const TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is HomeGetDataError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeGetDataLoading) {
              return myLoadingIndicator(context);
            } else if (state is HomeGetDataSuccess) {
              final homeModelList = state.modelHomeList;
              if (homeModelList.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: homeModelList.length,
                  itemBuilder: (context, index) {
                    final model = homeModelList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                backgroundColor: AColors.primary,
                                radius: 25,
                                child: Text(
                                  '${model.id}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      model.title ?? 'No Title',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AColors.primary,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      model.body ?? 'No body available',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[700],
                                      ),
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text(tr('noDataAvailable')));
              }
            } else {
              return Center(child: Text(tr('pressButtonLoadData.')));
            }
          },
        ),
      ),
    );
  }
}
