import 'package:flutter/material.dart';
import 'package:rent_bike/scr/pages/home/home_page.dart';
import 'package:rent_bike/scr/pages/notification/notification_page.dart';
import 'package:rent_bike/scr/pages/profile/profile_page.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController pageController = PageController();
  int pageIndex =1;
  List<Widget> pageList = <Widget>[
    NotificationPage(),
    HomePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pageList [pageIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) {//change page
            setState((){
              pageIndex = value;
            });
            pageController.animateToPage(pageIndex, duration: const Duration(milliseconds: 500),curve: Curves.easeIn);
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColor.kPrimaryColor,
          unselectedItemColor: AppColor.kFontColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Notification",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
