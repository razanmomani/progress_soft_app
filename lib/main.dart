import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:progress_soft_app/core/servise_network/cheak_sing_in_user.dart';
import 'package:progress_soft_app/core/widgets/theme/theme.dart';
import 'package:progress_soft_app/features/splach/splach_.dart';
import 'package:progress_soft_app/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  prefs = await SharedPreferences.getInstance();
  String savedLanguage = prefs.getString('language') ?? 'en';
  await checkIfUserSignIn();
  print("User signed in: $userIsSignIn");
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      saveLocale: false,
      startLocale: Locale(savedLanguage),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeData currentTheme =
        context.locale.languageCode == 'ar' ? themeArabic : themeEnglish;

    return MaterialApp(
      theme: currentTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
