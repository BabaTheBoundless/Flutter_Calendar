import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';

class HolidayPage extends StatefulWidget {
  @override
  _HolidayPageState createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  List<dynamic> _holidays = [];

  @override
  void initState() {
    super.initState();
    fetchHolidays();
  }

  Future<void> fetchHolidays() async {
    var connected = await Connectivity().checkConnectivity();
    if (ConnectivityResult != ConnectivityResult.none) {
      print('CONNECTED AND RUNNING');
    } else {
      print('not connected and running');
    }
    final apiKey = '6ejHzAidPCOiSeD1GyDUsAKSbob0Iwmx';
    final year = DateTime.now().year;
    final country = 'US';

    final url = Uri.parse(
        'https://calendarific.com/api/v2/holidays?&api_key=$apiKey&country=$country&year=$year');
    print('yo');

    /* NOTHING BELOW THIS EXECUTES; THIS IS SEEMINGLY THE PROBLEM
    Network connections seems to be fine. Perhaps something is wrong with my apiKey???
    */
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print('DOESITPRINT');
      setState(() {
        _holidays = data['response']['holidays'];
        print('whatisgoingon');
      });
      print(_holidays);
    } else {
      throw Exception('Failed to get holidays error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holidays'),
      ),
      body: ListView.builder(
        itemCount: _holidays.length,
        itemBuilder: (context, index) {
          final holiday = _holidays[index];
          return ListTile(
            title: Text(holiday['name']),
            subtitle: Text(holiday['date']['iso']),
          );
        },
      ),
    );
  }
}
