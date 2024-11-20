import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_app/main.dart';

void showLanguageDialog(BuildContext context) {
  String selectedLanguage = prefs.getString('language') ?? 'en';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(tr('selectLanguage')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'en',
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  _changeLanguage(context, value);
                  prefs.setString('language', value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<String>(
              title: Text('Arabic'),
              value: 'ar',
              groupValue: selectedLanguage,
              onChanged: (value) {
                if (value != null) {
                  _changeLanguage(context, value);
                  prefs.setString('language', value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

void _changeLanguage(BuildContext context, String languageCode) {
  context.setLocale(Locale(languageCode));
}
