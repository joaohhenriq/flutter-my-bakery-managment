import 'package:flutter/material.dart';
import 'package:my_bakery_managment/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      title: 'My Bakery Managment',
      home: LoginPage(),
    );
  }
}