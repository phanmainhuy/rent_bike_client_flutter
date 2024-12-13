import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_bike/scr/pages/login/login_page.dart';

class BuildUsernameField extends StatelessWidget {
  const BuildUsernameField({Key? key, controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        child: TextField(
          decoration: InputDecoration(
              icon: Icon(Icons.mail, color: Colors.white),
              hintText:"Your Email",
              hintStyle: TextStyle (color: Colors.white),
              border: InputBorder.none
          ),
        ),
      );
  }
}
