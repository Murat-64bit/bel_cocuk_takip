import 'dart:async';
import 'dart:math';

import 'package:bel_cocuk_takip/resources/firestore_methods.dart';
import 'package:bel_cocuk_takip/screens/qr_code_generator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  final String uid;

  const HomeScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  final _isHours = true;
  bool activity = false;
  var now = new DateTime.now();
  String _checkHour = "";
  String _nowQr = "";
  String _exitHour = "";
  String _dateTime = "";
  Timer? timer;
  int point = 0;
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
    timerQr();
  }

  void timerQr() {
    now = new DateTime.now();
    _nowQr = DateFormat('hhmm').format(now);
    timer = Timer.periodic(Duration(seconds: 20), (Timer t) {
      now = new DateTime.now();
      _nowQr = DateFormat('hhmm').format(now);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopWatchTimer.dispose();
    timer?.cancel();
  }

  String? qrResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${userData['name']} - ${point}P"),
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
                            if (qrResult != "-1" && qrResult == _nowQr) {
                              activity = true;

                              var now = new DateTime.now();

                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                              _checkHour = DateFormat('Hm').format(now);
                              _dateTime = DateFormat('dd/MM/yyyy').format(now);

                              timer = Timer.periodic(
                                  Duration(seconds: 18),
                                  (Timer t) => {
                                        FirestoreMethods()
                                            .addPoint(point++, widget.uid)
                                      });
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
                const Divider(),
                SingleChildScrollView(
                  child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.uid)
                        .collection('history')
                        .orderBy('datetime', descending: true)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      int a = (snapshot.data as dynamic).docs.length;
                      return a < 3
                          ? Padding(
                              padding: EdgeInsets.only(top: 50,left: 30,right: 30),
                              child: Text(
                                  "Geçmişinizin gözükmesi için ${3-a} işlem daha yapmanız gereklidir."))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (context, index) {
                                DocumentSnapshot snap =
                                    (snapshot.data! as dynamic).docs[index];
                                return HistoryCardItem(snap: snap);
                              });
                    },
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                children: const [],
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
            Stack(alignment: Alignment.center, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 0.10,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: StreamBuilder<int>(
                      stream: _stopWatchTimer.rawTime,
                      initialData: _stopWatchTimer.rawTime.value,
                      builder: (context, snapshot) {
                        final value = snapshot.data;
                        final displayTime = StopWatchTimer.getDisplayTime(
                            value!,
                            hours: _isHours,
                            milliSecond: false);
                        return Center(child: Text(displayTime));
                      },
                    )),
              ),
            ]),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("İşlem No: ${qrResult!}"),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              var now = new DateTime.now();

                              _exitHour =
                                  DateFormat('Hm').format(now); // 28/03/2020

                              FirestoreMethods().addHistory(qrResult.toString(),
                                  _checkHour, _exitHour, _dateTime, widget.uid);
                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.reset);
                              timer!.cancel();
                            }
                          });
                        },
                        child: const Text("Çıkış Yap!")),
                  ],
                )
              ],
            )),
          ],
        ));
  }
}
