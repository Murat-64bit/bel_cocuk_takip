import 'package:bel_cocuk_takip/resources/auth_methods.dart';
import 'package:bel_cocuk_takip/screens/acc_management_screen.dart';
import 'package:bel_cocuk_takip/utils/global_variables.dart';
import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

class AccInfoScreen extends StatelessWidget {
  final uid;
  AccInfoScreen({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Hesap Bilgilerim"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                child: ListTile(
                  leading: Icon(Icons.mail),
                  title: Text('E-Posta Yönetimi'),
                  trailing: Icon(Icons.arrow_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => AccManagementScreen(
                              selectedManage: ChooseManage.Mail,
                              uid: uid,
                            )));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.phone),
                  title: Text('Telefon Yönetimi'),
                  trailing: Icon(Icons.arrow_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => AccManagementScreen(
                              selectedManage: ChooseManage.ParentPhone,
                              uid: uid,
                            )));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.password),
                  title: Text('Şifre Yönetimi'),
                  trailing: Icon(Icons.arrow_right_rounded),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => AccManagementScreen(
                              selectedManage: ChooseManage.Password,
                              uid: uid,
                            )));
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Çıkış Yap!'),
                  trailing: Icon(Icons.arrow_right_rounded),
                  tileColor: Colors.red,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  onTap: () async {
                    AuthMethods().signOut();
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => LoginScreen()));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
