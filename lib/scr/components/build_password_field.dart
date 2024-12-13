import 'package:flutter/material.dart';
import 'package:rent_bike/scr/pages/login/login_page.dart';

class BuildPasswordField extends StatelessWidget {
  const BuildPasswordField({Key? key, controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Password",
          hintStyle: TextStyle (color: Colors.white),
          icon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          suffixIcon: Icon(
              Icons.visibility,
              color: Colors.white,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
