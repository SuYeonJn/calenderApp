import 'package:flutter/material.dart';
import 'package:scheduler/database/schedule_manager.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'navigator.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static ScheduleManager schmng = ScheduleManager();
  static int nowYear = DateTime.now().year;

  static String formatTime(int hour, int minute) {
    String ampm;
    if (hour >= 12) {
      ampm = "PM";
      hour -= 12;
    } else {
      ampm = "AM";
    }
    if (hour == 0) {hour = 12;}
    return "$hour:${(0 <= minute && minute < 10) ? "0" : ""}$minute $ampm";
  }
  
   MyApp({super.key}) {
    //We will be using this method as the real start of the app.
    schmng.openDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'calendar_app_new',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            shadowColor: Color.fromARGB(255, 220, 220, 220),
            backgroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(100))),
            backgroundColor: Color.fromARGB(220, 255, 255, 255),
          ),
          fontFamily: 'Lato',
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(
                fontSize: 15, fontFamily: 'Hind', fontWeight: FontWeight.bold),
          ),
        ),
        home: NavigatorBar());
  }
}
