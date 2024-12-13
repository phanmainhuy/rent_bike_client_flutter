import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class RoundedClickField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final IconData? icon;
  final TextInputType? keyboardType;
  final bool readOnly;
  final Color color;
  final int? length;
  // final Function onTap;



  const RoundedClickField({
    Key? key,
    required this.hintText,
    this.icon,
    required this.controller,
    required this.color,

    this.validator,
    this.keyboardType,
    required this.readOnly, this.length,
    // required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColor.kPrimaryColor,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: readOnly,
      maxLength: length,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        filled: true,
        fillColor: color,
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