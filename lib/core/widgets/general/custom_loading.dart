import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/helper/colors.dart';
import 'package:progress_soft_app/core/servise_network/get_device_type.dart';


Widget myLoadingIndicator(
  BuildContext context, {
  Color? color,
  double? radius,
  double? topPadding,
}) {
  if (Platform.isAndroid) {
    return topPadding == null
        ? Center(
            child: SizedBox(
              height: checkDeviceTaplet(context) ? 25 : null,
              width: checkDeviceTaplet(context) ? 25 : null,
              child: CircularProgressIndicator(
                color: color ?? AColors.primary,
              ),
            ),
          )
        : Column(
            children: [
              //(topPadding),
              CircularProgressIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
              ),
            ],
          );
  } else {
    return topPadding == null
        ? Center(
            child: CupertinoActivityIndicator(
              color: color ?? Theme.of(context).colorScheme.primary,
              radius: radius ?? 20,
            ),
          )
        : Column(
            children: [
             // heightSpace(topPadding),
              CupertinoActivityIndicator(
                color: color ?? Theme.of(context).colorScheme.primary,
                radius: radius ?? 20,
              ),
            ],
          );
  }
}

Widget myExpandedLoadingIndicator(
  BuildContext context, {
  Color? color,
  double? radius,
}) {
  if (Platform.isAndroid) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  } else {
    return Expanded(
      child: Center(
        child: CupertinoActivityIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
          radius: radius ?? 20,
        ),
      ),
    );
  }
}
showDailogWithLoadingIndecator(BuildContext context) async {
  return showDialog(
    useSafeArea: true,
    //barrierDismissible: false,
    context: context,
    builder: (context) => myLoadingIndicator(context),
  );
}
