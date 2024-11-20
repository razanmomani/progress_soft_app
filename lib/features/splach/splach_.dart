import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/extension/nav_extensions.dart';
import 'package:progress_soft_app/core/servise_network/cheak_sing_in_user.dart';
import 'package:progress_soft_app/core/widgets/general/custom_animation.dart';
import 'package:progress_soft_app/features/bottom_navigation_bar/bottom_navigation.dart';
import 'package:progress_soft_app/features/login/view/login_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkIfUserSignInAndNavigate();
  }

  Future<void> checkIfUserSignInAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));
    await checkIfUserSignIn();
    print("User signed in: $userIsSignIn");

    if (userIsSignIn) {
      context.pushAndRemoveAll(const ScreenBottomNavigations());
    } else {
      context.pushAndRemoveAll(LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimationColorWidget(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Image.asset(
              'assets/images/logo_progresssoft.png',
            ),
          ),
        ), // Your logo here
      ),
    );
  }
}
