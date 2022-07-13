import 'package:bel_cocuk_takip/screens/acc_info_screen.dart';
import 'package:bel_cocuk_takip/screens/history_screen.dart';
import 'package:bel_cocuk_takip/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



final homeScreenItems = [
  HomeScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  HistoryScreen(),
  AccInfoScreen(),
];
