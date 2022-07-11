import 'package:bel_cocuk_takip/responsive/main_layout.dart';
import 'package:bel_cocuk_takip/screens/login_screen.dart';
import 'package:bel_cocuk_takip/screens/signup_screen.dart';
import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue
      ),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MainLayout(),
    );
  }
}
