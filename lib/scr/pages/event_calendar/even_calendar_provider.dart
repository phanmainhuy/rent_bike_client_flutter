import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';

class EventCalendarProvider extends ChangeNotifier{

  DeviceCalendarPlugin ?_deviceCalendarPlugin;
  List<Calendar> _calendars = [];
  List<Event> _events = [];


  void _retrieveCalendars() async {
    //Retrieve user's calendars from mobile device
    //Request permissions first if they haven't been granted
    try {
      var permissionsGranted = await _deviceCalendarPlugin!.hasPermissions();
      if (permissionsGranted.isSuccess && (permissionsGranted.data ?? true)) {
        permissionsGranted = await _deviceCalendarPlugin!.requestPermissions();
        if (!permissionsGranted.isSuccess || (permissionsGranted.data ?? true)) {
          final calendarsResult = await _deviceCalendarPlugin!.retrieveCalendars();
          _calendars = calendarsResult.data!;
        }
      }

    //   final calendarsResult = await _deviceCalendarPlugin!.retrieveCalendars();
    //   setState(() {
    //     _calendars = calendarsResult.data!;
    //   });
    } catch (e) {
      print(e);
    }
  }





}