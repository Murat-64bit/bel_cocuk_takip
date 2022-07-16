import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class History {
  final String transId;
  final String checkHour;
  final String exitHour;
  final String datetime;

  const History({
    required this.transId,
    required this.checkHour,
    required this.exitHour,
    required this.datetime,
  });

  Map<String, dynamic> toJson() => {
        "transId": transId,
        "checkHour": checkHour,
        "exitHour": exitHour,
        "datetime": datetime,
      };

  static History fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return History(
      transId: snapshot["transId"],
      checkHour: snapshot["checkHour"],
      exitHour: snapshot["exitHour"],
      datetime: snapshot["datetime"],
    );
  }
}
