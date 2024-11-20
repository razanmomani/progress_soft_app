import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? label;
  final TextInputType keyboardType;
  final TextInputAction inputAction;
  final bool isObscure;
  final ValueChanged<String>? onSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? errorColor;
  final String? errorText;
  final String? hintText;
  final int? maxLines;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool showCursor;
  final Color? cursorColor;

  const CustomTextFormField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.label,
    this.keyboardType = TextInputType.text,
    this.inputAction = TextInputAction.done,
    this.isObscure = false,
    this.onSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.errorColor,
    this.errorText,
    this.hintText,
    this.maxLines,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.enabled = true,
    this.showCursor = true,
    this.cursorColor, required TextInputType textInputType,
     bool? obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      inputFormatters: inputFormatters,
      controller: controller,
      validator: validator,
      focusNode: focusNode,
      obscureText: isObscure,
      keyboardType: keyboardType,
      textInputAction: inputAction,
      onFieldSubmitted: onSubmitted,
      onChanged: onChanged,
      enabled: enabled,
      maxLines: maxLines ?? 1,
      showCursor: showCursor,
      cursorColor: cursorColor ?? Colors.black,
      decoration: InputDecoration(
        alignLabelWithHint: true,

        labelText: label,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 14, // Adjust this according to your app's design size
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelStyle: const TextStyle(
          color: Colors.black45,
          fontSize: 16, // Adjust this according to your app's design size
        ),
        errorText: errorText,
        border: _getBorder(),
        enabledBorder: _getBorder(),
        disabledBorder: _getBorder(),
        focusedBorder: _getBorder(),
      ),
    );
  }

  OutlineInputBorder _getBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    );
  }
}
