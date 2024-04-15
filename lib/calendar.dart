import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert';
//needed for linking to url
import 'package:url_launcher/url_launcher.dart';
//font icon package i found; should have github logo
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'signuppage.dart';
import 'holidaypage.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

/* need to add some fast way to go through the months and years.

*/

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<dynamic> _holiday = [];
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

        //Holidays button
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Theme(
              data: Theme.of(context),

              //table calendarr config
              child: TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) async {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });

                  final holidays = await fetchHoliday(selectedDay);
                  setState(() {
                    _holiday = holidays;
                  });
                  print(_holiday.length);
                },
                availableCalendarFormats: {
                  CalendarFormat.month: 'Month',
                },
                calendarStyle: CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayTextStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: _holiday.length,
                itemBuilder: (context, index) {
                  final holiday = _holiday[index];
                  return ListTile(
                    title: Text(holiday['name'] ?? 'No name'),
                    subtitle: Text(holiday['description'] ?? 'No desc'),
                  );
                },
              )),

          //bottomnavigationabar config
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.sign_language),
                label: 'Sign Up',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.party_mode),
                label: 'Holidays',
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
        ],
      ),
    );
  }

  void _openURL(urlLink) async {
    const githubLink = 'https://github.com';
    Uri uriLink = Uri.parse(urlLink);
    await launchUrl(uriLink);
  }

  Future<List<dynamic>> fetchHoliday(DateTime selectedDay) async {
    final apiKey = API_KEY;
    final year = selectedDay.year;
    final month = selectedDay.month;
    final day = selectedDay.day;
    final url = await http.get(Uri.parse(
        'https://calendarific.com/api/v2/holidays?&api_key=$apiKey&country=US&day=$day&month=$month&year=$year'));

    if (url.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(url.body);
      _holiday = data['response']['holidays'];
      return _holiday;
    } else {
      throw Exception('error error in fetchHoliday');
    }
  }
}
