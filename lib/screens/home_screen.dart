import 'package:bel_cocuk_takip/resources/firestore_methods.dart';
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
  String _exitHour = "";
  String _dateTime = "";
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _stopWatchTimer.dispose();
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
                              var now = new DateTime.now();

                              _stopWatchTimer.onExecute
                                  .add(StopWatchExecute.start);
                              _checkHour =
                                  DateFormat('Hm').format(now); // 28/03/2020
                              _dateTime = DateFormat('yMd').format(now);
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
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                        }
                      });
                    },
                    child: const Text("Çıkış Yap!")),
              ],
            )),
          ],
        ));
  }
}
