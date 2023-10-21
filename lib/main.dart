import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia_app/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Trivia App',
      theme: ThemeData(
        fontFamily: 'Architects Daughter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(31, 31, 31, 1.0),
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
