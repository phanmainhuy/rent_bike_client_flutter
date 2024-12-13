import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class RoundedCalendarInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData icon;
  final TextInputType? keyboardType;
  final VoidCallback onTap;
  final ValueChanged<String>? onChange;

  const RoundedCalendarInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardType,
    required this.onTap,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.kPrimaryColor,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: true,
      onTap: onTap,
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
