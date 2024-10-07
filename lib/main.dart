import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_list/pages/home.dart';


void main() async{
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
      theme: ThemeData(
        // TODO: change the colors so it looks nice
        primaryColor: Colors.grey[700],
        primaryColorDark: Colors.grey[850],
        primaryColorLight: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
          displayColor: Colors.white,
          bodyColor: Colors.white
        )
      ),
    );
  }
}
