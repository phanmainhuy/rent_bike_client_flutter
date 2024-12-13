import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: Text ('Profile Page'),  backgroundColor:AppColor.kPrimaryColor,),
      body: Center(
        child: Text ('Profile'),
      ),
    );
  }
}