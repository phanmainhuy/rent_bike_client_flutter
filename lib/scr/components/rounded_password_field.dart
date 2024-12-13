import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class MyPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final FormFieldValidator<String>? validator;

  const MyPasswordField({
    Key? key,
    this.hintText,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _MyPasswordFieldState createState() => _MyPasswordFieldState();
}

class _MyPasswordFieldState extends State<MyPasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      cursorColor: AppColor.kPrimaryColor,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColor.kPrimaryColor,
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColor.kPrimaryColor,
          ),
        ),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(200)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(200)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(200)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 0),
            borderRadius: BorderRadius.circular(200)),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(200),
        ),
      ),
    );
  }
}
