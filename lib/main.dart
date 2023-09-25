import 'package:agros/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agros',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
        primaryColor: Colors.blue,
        colorScheme: ColorScheme.light(
          primary: Colors.blue,
          secondary: Colors.green,
        ),
      ),
      home: LoginPage(),
    );
  }
}
