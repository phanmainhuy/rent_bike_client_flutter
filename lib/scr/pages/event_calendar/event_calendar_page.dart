import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/material.dart';
import 'package:rent_bike/scr/pages/event_calendar/calendar_detail.dart';
import 'package:rent_bike/scr/pages/event_calendar/test_add_2_calendar.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class EventCalendarPage extends StatelessWidget {
  const EventCalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _EventCalendarPage();
  }


}
class _EventCalendarPage extends StatefulWidget {
  const _EventCalendarPage({Key? key}) : super(key: key);

  @override
  _EventCalendarPageState createState() => _EventCalendarPageState();

  void _calendarCallback(String? id, String? name, DeviceCalendarPlugin? deviceCalendarPlugin) {}

}

class _EventCalendarPageState extends State<_EventCalendarPage> {
  DeviceCalendarPlugin ?_deviceCalendarPlugin;
  List<Calendar>? _calendars;
  Calendar? _selectedCalendar;

  // String _calendarName = '';

  _EventCalendarPageState(){
    _deviceCalendarPlugin = DeviceCalendarPlugin();
    // this._calendarCallback;
  }

  @override
  initState() {
    super.initState();
    _retrieveCalendars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar (title: const Text ('Event Calendar Page'),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [_getRefreshButton()],
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child:  ListView.builder(
                  itemCount: _calendars?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return  GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCalendar = _calendars![index];
                          widget._calendarCallback(_selectedCalendar!.id, _selectedCalendar!.name, _deviceCalendarPlugin);
                          print('tap: ${_calendars![index].name} ');
                          WidgetsBinding.instance!
                              .addPostFrameCallback((_) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CalendarDetail(
                                        name: _calendars![index].name ?? '',
                                        calendarID: _calendars![index].id ?? '0',
                                        ),

                                ));
                          });
                        });
                      },
                      child:  Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:  Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child:  Text(
                                _calendars![index].name ?? '',
                                style: TextStyle(fontSize: 25.0),
                              ),
                            ),
                            // Icon(_calendars![index].isReadOnly ?? false
                            //     ? Icons.lock
                            //     : Icons.lock_open, color: Colors.black,)
                            SizedBox(
                              child: TextButton(onPressed: () {
                                WidgetsBinding.instance!.addPostFrameCallback((_) {
                                  Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TestAdd2()
                                      ));
                                  });
                              },
                                child: Text(_calendars![index].id ?? ''),

                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              // FlatButton(
              //   color: Colors.greenAccent,
              //     child: const Icon(
              //       Icons.add_box_outlined
              //     ),
              //     onPressed: () async {
              //       // var result = await _deviceCalendarPlugin!.createCalendar
              //       //   (
              //       //   calendarName : 'nhuy',
              //       //   calendarColor : Color(0xFFe0e0e0),
              //       //   localAccountName : '',
              //       // );
              //       // var result = await _deviceCalendarPlugin!.createCalendar(
              //       //     calendarName: _calendarName)
              //     },
              // )
            ],
          ),

        ),
     );
  }




  void _retrieveCalendars() async {
    //Retrieve user's calendars from mobile device
    //Request permissions first if they haven't been granted
    try {
      var permissionsGranted = await _deviceCalendarPlugin!.hasPermissions();
      if (permissionsGranted.isSuccess && (permissionsGranted.data ?? true)) {
        permissionsGranted = await _deviceCalendarPlugin!.requestPermissions();
        if (!permissionsGranted.isSuccess || (permissionsGranted.data ?? true)) {
          final calendarsResult = await _deviceCalendarPlugin!.retrieveCalendars();
          _calendars = calendarsResult.data;
        }
      }

      final calendarsResult = await _deviceCalendarPlugin!.retrieveCalendars();
      setState(() {
        _calendars = calendarsResult.data;
        print("Calendar result: ${_calendars!.length}");
      });
    } catch (e) {
      print(e);
    }
  }

  Widget _getRefreshButton() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () async {
          _retrieveCalendars();
        });
  }



}



