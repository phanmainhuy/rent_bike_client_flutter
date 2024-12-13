import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rent_bike/scr/pages/create_customer/create_customer_page.dart';
import 'package:rent_bike/scr/pages/customer_list/customer_list_page.dart';
import 'package:rent_bike/scr/pages/event_calendar/event_calendar_page.dart';
import 'package:rent_bike/scr/pages/login/login_page.dart';
import 'package:rent_bike/scr/pages/repair_vehicle_registration/repair_vehicle_registration_page.dart';
import 'package:rent_bike/scr/pages/statistics/statistics_page.dart';
import 'package:rent_bike/scr/pages/vehicle_fee_list/vehicle_fee_list_page.dart';
import 'package:rent_bike/scr/pages/vehicle_list/vehicle_list_page_1.dart';
import 'package:rent_bike/scr/pages/vehicle_registration/vehicle_registration_page.dart';
import 'package:rent_bike/scr/pages/vehicle_rental_registration/vehicle_rental_registration_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class NavDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            //statusBarColor: Colors.black,
            // For Android.
            // Use [light] for white status bar and [dark] for black status bar.
            statusBarIconBrightness: Brightness.light,
            // For iOS.
            // Use [dark] for white status bar and [light] for black status bar.
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: AppColor.kPrimaryColor,
          ),
      child: Material (
        color: AppColor.kPrimaryColor,
        child: ListView(
          children: <Widget> [
            SizedBox(
              height: 100,
              child: DrawerHeader (
                decoration: BoxDecoration(
                  // gradient: LinearGradient (colors: <Color>[
                  //   Colors.white,
                  //   Colors.blueGrey,
                  // ])
                  color: Colors.white,
                ), child: Text (
                  'Rent Bike',
                  textAlign: TextAlign.center,
                  style: TextStyle (
                      color: Colors.black,
                      fontWeight:FontWeight.w600,
                      fontSize: 40,
                  ),
              ),
              ),
            ),
            //const SizedBox (height: 10),
            //padding:padding,
            buildMenuItem(
              text: 'Statistics',
              icon: Icons.car_repair,
              onClicked: () => selectedItem (context,0),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text:"Vehicle List",
              icon: Icons.motorcycle,
              onClicked: () => selectedItem (context,1),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text: "Customer List",
              icon: Icons.person,
              onClicked: () => selectedItem (context,2),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text: "Vehicle Fees",
              icon: Icons.alarm,
              onClicked: () => selectedItem (context,3),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text: "Vehicle Registration",
              icon: Icons.app_registration,
              onClicked: () => selectedItem (context,4),
            ),
            //const SizedBox (height: 10),
            buildMenuItem(
              text: "Customer Registration",
              icon:Icons.person,
              onClicked: () => selectedItem (context,5),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text: "Vehicle Rental Registration",
              icon:Icons.doorbell,
              onClicked: () => selectedItem (context,6),
            ),
            //const SizedBox (height: 20),
            buildMenuItem(
              text: "Repair Vehicle Registration",
              icon:  Icons.home_repair_service,
              onClicked: () => selectedItem (context,7),
            ),

            buildMenuItem(
              text: "Event Calendar",
              icon: Icons.calendar_today_outlined,
              onClicked: () => selectedItem (context,8),
            ),
            SizedBox(
              height: 2.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 5.0,
                  color: Colors.white70,
                ),
              ),
            ),
            buildMenuItem(
              text: "Logout",
              icon: Icons.logout,
              onClicked: () => selectedItem (context,9),
            ),
          ],
        ),
      ),
        ),
    );
  }


  Widget buildMenuItem({required String text, required IconData icon,VoidCallback ?onClicked})
  {
      final color = Colors.white;
      final hoverColor = Colors.white70;

      return ListTile(
        leading: Icon (icon, color: color),
        title: Text(text, style: TextStyle(
            fontSize: 17,
            color: color,
        )),
        hoverColor: hoverColor,
        onTap: onClicked,
      );
  }
}

void selectedItem(BuildContext context, int index) {
  Navigator.of(context).pop();
  switch (index) {
    case 0:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const StatisticsPage(),
      ));
      break;
    case 1:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const VehicleListPage1(),
      ));
      break;
    case 2:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const CustomerListPage(),
      ));
      break;
    case 3:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const VehicleFeeListPage(),
      ));
      break;
    case 4:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const VehicleRegistrationPage(),
      ));
      break;
    case 5:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const CreateCustomerPage(),
      ));
      break;
    case 6:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const VehicleRentalRegistrationPage(),
      ));
      break;
    case 7:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const VehicleRentalRegistrationPage(),
      ));
      break;
    case 8:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const EventCalendarPage(),
      ));
      break;
    case 9:
      Navigator.of(context ).push(MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ));
      break;
  }
}



