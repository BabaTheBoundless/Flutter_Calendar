import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
);

ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      background: Colors.grey.shade400,
      primary: Colors.blue.shade100,
      secondary: Colors.purple.shade50,
    ));



/*class CalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAH',
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
}*/
