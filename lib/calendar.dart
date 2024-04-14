import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//needed for linking to url
import 'package:url_launcher/url_launcher.dart';
//font icon package i found; should have github logo
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'signuppage.dart';
import 'holidaypage.dart';

/* need to add some fast way to go through the months and years.

*/

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  int _currentIndex = 0;

  ThemeMode _themeMode = ThemeMode.dark;
  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;

      //Home button
      if (_currentIndex == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
        //_openURL('https://theuselessweb.com');

        //Calendar button
      } else if (_currentIndex == 1) {
        //_openURL('https://www.pro-football-reference.com');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HolidayPage()));

        //Github button
      } else if (_currentIndex == 2) {
        _openURL('https://github.com/BabaTheBoundless/Flutter_Calendar');

        //test button
      } else if (_currentIndex == 3) {
        if (_themeMode == ThemeMode.light) {
          changeTheme(ThemeMode.dark);
          _openURL('https://www.pro-football-reference.com');
        } else if (_themeMode == ThemeMode.dark) {
          changeTheme(ThemeMode.light);
          _openURL('https://github.com/BabaTheBoundless/Flutter_Calendar');
        }
      }
    });
  }

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _openURL('https://theuselessweb.com');
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testing testing 123'),
      ),
      body: Theme(
        data: Theme.of(context),
        child: TableCalendar(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.sign_language),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.join_full),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.github),
            label: 'Github',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'test',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _itemTapped,
      ),
    );
  }

  void _openURL(urlLink) async {
    const githubLink = 'https://github.com';

    Uri uriLink = Uri.parse(urlLink);
    await launchUrl(uriLink);
  }
}
