import 'package:bel_cocuk_takip/screens/acc_info_screen.dart';
import 'package:bel_cocuk_takip/screens/history_screen.dart';
import 'package:bel_cocuk_takip/screens/home_screen.dart';
import 'package:bel_cocuk_takip/screens/qr_code_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final homeScreenItems = [
  HomeScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  HistoryScreen(uid: FirebaseAuth.instance.currentUser!.uid),
  AccInfoScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];

enum ChooseManage { Mail, Password, ParentPhone }
