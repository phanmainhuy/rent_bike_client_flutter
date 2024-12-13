import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';


class StatisticsPage extends StatelessWidget {
  const StatisticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: Text ('Statistics Page'),  backgroundColor: AppColor.kPrimaryColor,),
      body: Center(
        child: Text ('Statistics'),
      ),
    );
  }
}
