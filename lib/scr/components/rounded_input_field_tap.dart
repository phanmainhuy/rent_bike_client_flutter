import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class RoundedInputFieldTap extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final TextInputType? keyboardType;
  final int? length;
  final Function(String) onSubmit;
  final ValueChanged<String>? onChange;


  const RoundedInputFieldTap({
    Key? key,
    required this.hintText,
    this.icon,
    required this.controller,
    required this.onSubmit,
    this.validator,
    this.keyboardType, this.length, this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: length,
      cursorColor: AppColor.kPrimaryColor,
      validator: validator,
      onFieldSubmitted: onSubmit,
      keyboardType: keyboardType,
      onChanged: onChange,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: Colors.black,
        ),
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(200)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(200)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0),
            borderRadius: BorderRadius.circular(200)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 0),
            borderRadius: BorderRadius.circular(200)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 0),
          borderRadius: BorderRadius.circular(200),
        ),
      ),
    );
  }
}