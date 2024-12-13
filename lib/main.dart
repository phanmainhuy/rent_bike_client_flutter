import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rent_bike/scr/base/di/locator.dart';
import 'package:rent_bike/scr/pages/home/main_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentContext!;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Rent Bike',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}