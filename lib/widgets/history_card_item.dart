import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:flutter/material.dart';

class HistoryCardItem extends StatelessWidget {
  const HistoryCardItem({Key? key}) : super(key: key);

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
                          const Text(" 16/07/2022"),
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
                          const Text(" 14:35"),
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
                          const Text(" 14:45"),
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
                            color: Colors.orange,
                          ),
                          const Text(" 7834587"),
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
