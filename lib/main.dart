import 'package:bel_cocuk_takip/responsive/main_layout.dart';
import 'package:bel_cocuk_takip/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Montserrat', primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SignupScreen(),
    );
  }
}
