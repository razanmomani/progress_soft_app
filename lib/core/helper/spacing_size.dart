import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class AHelperFunction {
  AHelperFunction._();
  static void showAlert(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK")),
              ],
            ));
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  static String getFileExtensionFromUrl(String url) {
    // Parse the URL
    Uri uri = Uri.parse(url);
    // Extract the path from the URL
    String filePath = uri.path;
    // Get the file extension from the path
    return path.extension(filePath);
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //=================================================================FONT SIZE
  static double fontSize(BuildContext context) {
    return MediaQuery.of(context).size.height * .018;
  }

  static double fontSizeTitle(BuildContext context) {
    return MediaQuery.of(context).size.height * .020;
  }

  static double fontSizeSubTitle(BuildContext context) {
    return MediaQuery.of(context).size.height * .015;
  }

  //=================================================================FONT SIZE
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static String extractVideoId(String url) {
    // Regular expression to match both YouTube URL formats
    final RegExp regExp = RegExp(
        r'(?:youtu\.be\/|youtube\.com\/(?:watch\?v=|embed\/|v\/|.+\?v=))([a-zA-Z0-9_-]{11})');
    final match = regExp.firstMatch(url);
    return match?.group(1) ??
        ''; // Returns the video ID or an empty string if not found
  }
}
