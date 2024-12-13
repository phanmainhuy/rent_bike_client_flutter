import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class NotificationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: Text ('Notification'), backgroundColor: AppColor.kPrimaryColor,),
      body: Center(),
    );
  }
}
