import 'package:get_it/get_it.dart';
import 'package:rent_bike/scr/services/network/api_store.dart';
GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(APIStore());
  // locator.registerSingleton(_AuthService());

}