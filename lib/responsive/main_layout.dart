import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _page=0;
  late PageController pageController;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page){
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page){
    setState(() {
      _page=page;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: _page == 0 ? orangeColor : primaryColor,), label: '', backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.history, color: _page == 1 ? orangeColor : primaryColor,),
              label: '',
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: _page == 2 ? orangeColor : primaryColor,),
              label: '',
              backgroundColor: primaryColor),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
