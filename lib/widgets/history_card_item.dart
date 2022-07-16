import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:flutter/material.dart';

class HistoryCardItem extends StatefulWidget {
  final snap;
  const HistoryCardItem({Key? key, required this.snap}) : super(key: key);

  @override
  State<HistoryCardItem> createState() => _HistoryCardItemState();
}

class _HistoryCardItemState extends State<HistoryCardItem> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 10,
                            color: Colors.purple,
                          ),
                          Text(" ${widget.snap['datetime']}"),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 10,
                            color: Colors.green,
                          ),
                          Text(" ${widget.snap['checkHour']}"),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 10,
                            color: Colors.red,
                          ),
                          Text(" ${widget.snap['exitHour']}"),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10,),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 10,
                            color: Colors.orange,
                          ),
                          Text(" ${widget.snap['transId']}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
