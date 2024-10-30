import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/pages/home_page.dart';
import 'package:the_list/services/notification_services.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();

  // initialize the hive
  await Hive.initFlutter();

  // open the box
  var box = await Hive.openBox('mybox');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        '/homepage': (context) => HomePage()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: Colors.black,
          primary: Color(0xff1E1E2F), // this is the background color
          secondary: Color(0xff2B2B3C), // this is for the appbar color
          tertiary: Color(0xffFF6F61), // this is for the add button and dialog box'
        ),
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: Color(0xffeaeaea),
          bodyColor: Color(0xffeaeaea)
        ),
        iconTheme: IconThemeData(
          color: Color(0xffeaeaea)
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Color(0xff1E1E2F)
          ),
          hintStyle: TextStyle(
            color: Color(0xffeaeaea).withOpacity(0.8),
          ),
        ),
        datePickerTheme: DatePickerThemeData(
          cancelButtonStyle: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xffFF6F61)),
            foregroundColor: WidgetStatePropertyAll(Color(0xffeaeaea))
          ),
          confirmButtonStyle: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Color(0xffFF6F61)),
            foregroundColor: WidgetStatePropertyAll(Color(0xffeaeaea))
          ),
          surfaceTintColor: Colors.transparent,
          todayBackgroundColor: WidgetStatePropertyAll(Color(0xffFF6F61)),
        ),
      ),
    );
  }
}
