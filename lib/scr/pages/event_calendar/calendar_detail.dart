import 'package:device_calendar/device_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_bike/scr/resources/app_color.dart';

class CalendarDetail extends StatelessWidget {
  final String name;
  final String calendarID;
  CalendarDetail({Key? key, required this.name, required this.calendarID}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _CalendarDetail(name: name, id: calendarID,);
  }
}

class _CalendarDetail extends StatefulWidget {
  String ?name;
  String ?id;


  _CalendarDetail({Key? key, required this.name, required this.id}) : super(key: key);



  @override
  _CalendarDetailState createState() => _CalendarDetailState();
}

class _CalendarDetailState extends State<_CalendarDetail> {

  List<Event> _event = [];
  DeviceCalendarPlugin ?_deviceCalendarPlugin;

  _CalendarDetailState() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }


  @override
  initState() {
    super.initState();
    _retrieveEvents();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${ widget.name} detail'),
        backgroundColor: AppColor.kPrimaryColor,
        actions: [_getRefreshButton()],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15,),
            SizedBox(
              child: Text(
                '${widget.name}',
                style: const TextStyle(fontSize: 17),
              ),
            ),

            SizedBox(
              width: 50000,

              child:
              ListView.separated(
                itemCount: _event.length,
                separatorBuilder: (_, index) =>
                  const SizedBox(height: 10,),

                itemBuilder: (_, index) => ListTile(
                  leading: SizedBox(
                    width: 80,
                    height: 80,
                    child: Text('${_event[index].calendarId}'),
                  ),
                  title: Text(
                    '${widget.name}',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  void _retrieveEvents() {

  }

  Widget _getRefreshButton() {
    return IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () async {
          _retrieveEvents();
        });
  }


}
