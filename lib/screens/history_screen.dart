import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Geçmiş Kayıtlarım"),
        ),
        body: ListView(
          children: const [
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
            HistoryCardItem(),
          ],
        ));
  }
}