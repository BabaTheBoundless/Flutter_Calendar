import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

/* need to add some fast way to go through the months and years.

*/

void main() {
  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAH',
      theme: ThemeData(
        //they said primarySwatch will act as a theme; I don't see it but could be browser issue???
        primarySwatch: Colors.amber,
      ),
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testing testing 123'),
      ),
      body: TableCalendar(
        //may want to change the earilest start and end date later
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(2100, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },

        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        availableCalendarFormats: {
          //it wants a label ('Month'; gives me error without one), but it seems any label will do haha
          CalendarFormat.month: 'Month',
        },
        calendarStyle: CalendarStyle(
            selectedDecoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              //change to square at some point
              shape: BoxShape.circle,
            ),

            //don't think i want to keep the amber color but we shall see
            //also i think i will put some other textstyles here unless i find a better spot to put them
            selectedTextStyle: TextStyle(color: Colors.amber),
            todayTextStyle: TextStyle(color: Colors.amber)),
      ),
    );
  }
}
