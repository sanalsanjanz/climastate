import 'package:climastate/screens/loadingScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Clima State",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyText1: TextStyle(
                color: Colors.black, fontSize: 26, fontWeight: FontWeight.bold),
          ),
          primaryColor: const Color(0xff54ffff),
          scaffoldBackgroundColor: Colors.black),
      home: const LoadingScreen(),
    );
  }
}
