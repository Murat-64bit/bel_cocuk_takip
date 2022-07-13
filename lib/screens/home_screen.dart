import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool activity = false;
  int point =0;
  var userData = {};

  getData() async {
  
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      point = userSnap.data()!['point'];
    
      userData = userSnap.data()!;
      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  String? qrResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${userData['name']} - ${userData['point']}P"),
        ),
        body: Column(
          children: [
            Column(
              children: [
                activity
                    ? activityStatus(context)
                    : InkWell(
                        onTap: () async {
                          String barcodeScanRes =
                              await FlutterBarcodeScanner.scanBarcode(
                                  '#ff6666', 'İptal', true, ScanMode.BARCODE);
                          setState(() {
                            qrResult = barcodeScanRes;
                            print(qrResult);
                            if (qrResult != "-1") {
                              activity = true;
                            }
                          });
                        },
                        child: activity
                            ? activityStatus(context)
                            : waitActivity(context),
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 35, right: 35, top: 10),
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.97,
                  child: Image.asset("assets/images/gebze_yatay_logo.png"),
                ),
                const Divider()
              ],
            ),
            Expanded(
              child: ListView(
                children: const [
                  HistoryCardItem(),
                  HistoryCardItem(),
                  HistoryCardItem(),
                ],
              ),
            )
          ],
        ));
  }

  Container waitActivity(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, top: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.97,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 50),
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.47,
            child: Image.asset("assets/images/qr_code2.png"),
          ),
          Container(
            margin: const EdgeInsets.only(top: 130),
            child: const Text("Tıklayın ve QR okutun."),
          ),
        ],
      ),
    );
  }

  Container activityStatus(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 35, right: 35, top: 20),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
      ),
      height: MediaQuery.of(context).size.height * 0.30,
      width: MediaQuery.of(context).size.width * 0.97,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.97,
                  child: const Center(child: Text("00:00:00")),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 140),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("İşlem No: ${qrResult!}"),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                          ),
                          onPressed: () {
                            setState(() {
                              if (qrResult != "-1") {
                                activity = false;
                              }
                            });
                          },
                          child: const Text("Çıkış Yap!")),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
