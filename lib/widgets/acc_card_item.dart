import 'package:flutter/material.dart';

class AccCardItem extends StatefulWidget {
  const AccCardItem({Key? key}) : super(key: key);

  @override
  State<AccCardItem> createState() => _AccCardItemState();
}

class _AccCardItemState extends State<AccCardItem> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: FlutterLogo(size: 56.0),
        title: Text('Two-line ListTile'),
        subtitle: Text('Here is a second line'),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }
}
