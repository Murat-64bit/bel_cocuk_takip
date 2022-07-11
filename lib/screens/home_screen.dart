import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Sayfa"),
      ),
        body: Column(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 35, right: 35, top: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              height: MediaQuery.of(context).size.height * 0.30,
              width: MediaQuery.of(context).size.width * 0.97,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 50),
                    child: Image.asset("assets/images/qr_code2.png"),
                    height: MediaQuery.of(context).size.height * 0.20,
                    width: MediaQuery.of(context).size.width * 0.47,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 130),
                    child: Text("Tıklayın ve QR okutun."),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 35, right: 35, top: 10),
              child: Image.asset("assets/images/gebze_yatay_logo.png"),
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 0.97,
            ),
            Divider()
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              HistoryCardItem(),
              HistoryCardItem(),
              HistoryCardItem(),
            ],
          ),
        )
      ],
    ));
  }
}
