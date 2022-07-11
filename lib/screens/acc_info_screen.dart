import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class AccInfoScreen extends StatefulWidget {
  AccInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccInfoScreen> createState() => AccInfoScreenState();
}

class AccInfoScreenState extends State<AccInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hesap Bilgilerim"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFieldInput(
                  name: "E-Posta Adresiniz",
                  icon: Icon(Icons.mail),
                  textInputType: TextInputType.emailAddress,
                  IsPass: false),
              SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  name: "Veli Telefon Numarası",
                  icon: Icon(Icons.phone),
                  textInputType: TextInputType.phone,
                  IsPass: false),
              SizedBox(
                height: 10,
              ),
              TextFieldInput(
                  name: "Şifreniz",
                  icon: Icon(Icons.lock),
                  textInputType: TextInputType.visiblePassword,
                  IsPass: true),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                  onPressed: () {},
                  child: Text("Kaydet")),
            ],
          ),
        ));
  }
}
