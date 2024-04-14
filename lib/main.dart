import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//needed for linking to url
//font icon package i found; should have github logo

import 'calendar.dart';
import 'lightVSdark.dart';
import 'signuppage.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

/* need to add some fast way to go through the months and years.

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('initalizing firebase...');
  try {
    await Firebase.initializeApp();
    print('firebase successful');
  } catch (error) {
    print('firebase initiazlating error: $error');
  }

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
