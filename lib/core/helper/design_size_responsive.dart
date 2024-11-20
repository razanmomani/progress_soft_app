import 'dart:developer';

import 'package:flutter/material.dart';

Size getDesignSize(BuildContext context) {
  final Size screenSize = MediaQuery.of(context).size;
  final double width = screenSize.width;
  final double height = screenSize.height;

  const double smallMobileWidth = 400;

  const double bigMobileWidth = 414;
  const double tabletWidth = 768;
  const double ipadWidth = 1024;

  double designWidth;
  double designHeight;

  if (width < smallMobileWidth) {
    log('Small Mobile');
    //Small Mobile
    designWidth = isPortraitScreen(context) ? (width + 50) : 800;
    designHeight = isPortraitScreen(context) ? 1000 : (width + 50);
  } else if (width < bigMobileWidth && width > smallMobileWidth) {
    //Medium Mobile
    log('Medium Mobile');
    designWidth = isPortraitScreen(context) ? width : height;
    designHeight = isPortraitScreen(context) ? height : width;
  } else if (width < bigMobileWidth) {
    log('Big Mobile');
    //Big Mobile
    designWidth = isPortraitScreen(context) ? width : height;
    designHeight = isPortraitScreen(context) ? height : width;
  } else if (width < tabletWidth) {
    log('Tablet');
    //Tablet
    designWidth = isPortraitScreen(context) ? 450 : 1000;
    designHeight = isPortraitScreen(context) ? 1000 : 450;
  } else if (width < ipadWidth) {
    log('Ipad');
    //Ipad
    designWidth = isPortraitScreen(context) ? 650 : 900;
    designHeight = isPortraitScreen(context) ? 900 : 650;
  } else {
    //Desktop
    designWidth = isPortraitScreen(context) ? 700 : 1200;
    designHeight = isPortraitScreen(context) ? 1200 : 700;
  }
  return Size(designWidth, designHeight);
}

bool isPortraitScreen(BuildContext context) {
  return MediaQuery.of(context).orientation == Orientation.portrait;
}
