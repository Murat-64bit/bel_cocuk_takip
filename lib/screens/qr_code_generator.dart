import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../resources/firestore_methods.dart';

class QrCodeGenerator extends StatefulWidget {
  QrCodeGenerator({Key? key}) : super(key: key);

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  TextEditingController controller = TextEditingController();
  String _qrCodeString = "";
  var now = new DateTime.now();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timerQr();
  }

  void timerQr() {
    now = new DateTime.now();
      _qrCodeString = DateFormat('hhmm').format(now);
    timer = Timer.periodic(Duration(seconds: 60), (Timer t) {
      now = new DateTime.now();
      _qrCodeString = DateFormat('hhmm').format(now);
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: _qrCodeString,
              size: 300,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Text(_qrCodeString),
            ),
          ],
        ),
      )),
    ));
  }
}
