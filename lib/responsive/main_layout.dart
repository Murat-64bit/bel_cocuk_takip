import 'package:bel_cocuk_takip/screens/qr_code_generator.dart';
import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/user.dart' as model;
import '../utils/global_variables.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _page = 0;
  late PageController pageController;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  bool isAdmin = false;

  getData() async {
    try {
      var userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      isAdmin = userSnap.data()!['admin'];

      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }


  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
// PageView(
//         children: homeScreenItems,
//         physics: NeverScrollableScrollPhysics(),
//         controller: pageController,
//         onPageChanged: onPageChanged,
//       ),
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isAdmin ? QrCodeGenerator() : IndexedStack(index: _page,children:homeScreenItems,),
      bottomNavigationBar: isAdmin ? null : BottomNavigationBar(
        backgroundColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? orangeColor : primaryColor,
              ),
              label: 'Ana Sayfa',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                color: _page == 1 ? orangeColor : primaryColor,
              ),
              label: 'Geçmiş',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: _page == 2 ? orangeColor : primaryColor,
              ),
              label: 'Hesabım',
              backgroundColor: primaryColor),
        ],
        onTap: onPageChanged,
      ),
    );
  }
}
