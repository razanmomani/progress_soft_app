import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/core/extension/nav_extensions.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/helper/spacing_size.dart';
import 'package:progress_soft_app/core/widgets/general/custom_loading.dart';
import 'package:progress_soft_app/features/bottom_navigation_bar/cubit/screen_bottom_nav_cubit.dart';
import 'package:progress_soft_app/features/login/view/login_screen.dart';
import 'package:progress_soft_app/features/profile/view/widget/show_dilog_lang.dart';
import 'package:progress_soft_app/features/profile/view_model/bloc/profile_bloc.dart';
import 'package:progress_soft_app/features/profile/view_model/bloc/profile_state.dart';

class ProfileScreens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(GetDataUserEvent()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingLoggedOut) {
            showDailogWithLoadingIndecator(context);
          } else if (state is ProfileSuccessLoggedOut) {
            context.pushReplacement(LoginScreen());
          } else if (state is ProfileErrorLoggedOut) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.transparent,
                content: Text(
                  tr('errorLogout'),
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                )));
          }
        },
        builder: (context, state) {
          ProfileBloc profileBloc = context.read<ProfileBloc>();
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.read<BottomNavCubit>().goToHome();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showLanguageDialog(context);
                  },
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text(
                            tr("areYouLogOut"),
                            style:  TextStyle(color: Colors.black,
                            fontSize: AHelperFunction.fontSizeTitle(context),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                profileBloc.logout();
                              },
                              child: Text(
                                tr(
                                  'yes',
                                ),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                tr(
                                  'no',
                                ),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
              title: Text(
                tr('profile'),
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: AColors.primary,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileLoggedOut) {
                    Navigator.pop(context); // Close the loading dialog
                    context.pushReplacement(LoginScreen());
                  }
                },
                builder: (context, state) {
                  if (state is ProfileLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProfileSuccess) {
                    return Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: AColors.primary,
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildProfileInfo(
                            tr("fullName"), state.userModel.fullName ?? ""),
                        _buildProfileInfo(
                            tr("phone"), state.userModel.phone ?? ""),
                        _buildProfileInfo(
                            tr("gender"), state.userModel.gender ?? ""),
                        _buildProfileInfo(tr("age"), state.userModel.age ?? ""),
                      ],
                    );
                  } else if (state is ProfileError) {
                    return Center(child: Text(tr("errorLoadingProfile")));
                  } else {
                    return Center(child: Text(tr("noDataAvailable")));
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(
          Icons.info_outline,
          color: AColors.primary,
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
      ),
    );
  }
}
