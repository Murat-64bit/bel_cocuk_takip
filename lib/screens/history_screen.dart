import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  final uid;
  const HistoryScreen({Key? key, required this.uid}) : super(key: key);

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
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .collection('history')
              .orderBy('datetime',descending: true)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                shrinkWrap: true,
                itemCount: (snapshot.data! as dynamic).docs.length,
          
                itemBuilder: (context, index) {
                  DocumentSnapshot snap =
                      (snapshot.data! as dynamic).docs[index];

                  return HistoryCardItem(snap: snap);
                });
          },
        ));
  }
}
