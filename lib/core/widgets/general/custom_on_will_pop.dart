import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_soft_app/core/widgets/general/custom_text.dart';

Future<bool> onPopInvoked(BuildContext context) async {
  bool exit =
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: CustomText(
          text: ('exitApp'),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        content: CustomText(
          text: (tr('areExitApp')),
          color: Colors.black,
        ),
        actionsAlignment: MainAxisAlignment.start,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Don't exit
            },
            child: CustomText(
              text: (tr('no')),
              color: Colors.red,
            ),
          ),
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: CustomText(
              text: (tr('yes',
              )),
              color: Colors.blueAccent,
            ),
          ),
        ],
      );
    },
  );

  return exit;
}
