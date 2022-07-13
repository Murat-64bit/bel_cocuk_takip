import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;
  final String parentPhone;
  final int point;

  const User({
    required this.uid,
    required this.name,
    required this.email,
    required this.parentPhone,
    required this.point,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "name": name,
        "email": email,
        "parentPhone": parentPhone,
        "point": point,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot["uid"],
      name: snapshot["name"],
      email: snapshot["email"],
      parentPhone: snapshot["parentPhone"],
      point: snapshot["point"],
    );
  }
}
