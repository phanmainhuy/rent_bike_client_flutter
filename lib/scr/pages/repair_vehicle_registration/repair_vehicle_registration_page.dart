import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';


class RepairVehicleRegistrationPage extends StatelessWidget {
  const RepairVehicleRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: Text ('Repair Vehicle Registration Page'),  backgroundColor: AppColor.kPrimaryColor),
      body: Center(
        child: Text ('Repair Vehicle Registration'),
      ),
    );
  }
}

