import 'package:flutter/material.dart';
//needed for linking to url
//font icon package i found; should have github logo

import 'calendar.dart';
import 'lightVSdark.dart';

/* need to add some fast way to go through the months and years.

*/

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(CalendarApp());
}

class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: CalendarPage(),
    );
  }
}
