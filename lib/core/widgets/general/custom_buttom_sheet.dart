import 'package:flutter/material.dart';
import 'package:wtf_sliding_sheet/wtf_sliding_sheet.dart';
import 'package:easy_localization/easy_localization.dart';

import '../buttons/custom_button.dart';
import '../text_fields/custom_otp_textfield.dart';
import 'custom_text.dart';

customBottomSheet(BuildContext context, Widget body) {
  return showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
      duration: const Duration(milliseconds: 400),
      elevation: 8,
      cornerRadius: 16,
      snapSpec: const SnapSpec(
        snappings: [0.4, 0.7, 1.0],
      ),
      builder: (context, state) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Center(
            child: Material(
              child: body,
            ),
          ),
        );
      },
    );
  });
}

customOtpButtonSheet(
  BuildContext context, {
  required TextEditingController controller,
  required GlobalKey<FormState> formKey,
  required dynamic Function() onPressed,
}) {
  customBottomSheet(
    context,
    Material(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            CustomText(
              text: tr('enterOtp'),
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 3),
            CustomText(
              text: tr('sentOtp'),
              fontSize: 16,
              color: Colors.black54,
            ),
            const SizedBox(height: 20),
            CustomOtpTextField(
              controller: controller,
              formKey: formKey,
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              child: Text(
                tr('verify'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: onPressed,
            ),
          ],
        ),
      ),
    ),
  );
}
