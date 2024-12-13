import 'package:flutter/material.dart';

class MenuItem {
  String title;
  IconData icon;

  MenuItem({required this.title, required this.icon});
}
List<MenuItem> menuItems =[
  MenuItem (title: "Statistics", icon: Icons.car_repair),
  MenuItem (title:"Vehicle List",icon: Icons.motorcycle),
  MenuItem (title:"Customer List", icon: Icons.person),
  MenuItem (title: "Vehicle Fees", icon: Icons.alarm),
  MenuItem (title: "Vehicle Registration",icon: Icons.app_registration),
  MenuItem (title:"Customer Registration",icon:Icons.person),
  MenuItem (title: "Vehicle Rental Registration", icon:Icons.doorbell),
  MenuItem (title: "Repair Vehicle Registration",icon:  Icons.home_repair_service),
  MenuItem (title:"Event Calendar",icon: Icons.calendar_today_outlined),
  ];
