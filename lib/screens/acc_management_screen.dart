import 'package:bel_cocuk_takip/resources/auth_methods.dart';
import 'package:bel_cocuk_takip/screens/login_screen.dart';
import 'package:bel_cocuk_takip/utils/global_variables.dart';
import 'package:bel_cocuk_takip/widgets/history_card_item.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class AccManagementScreen extends StatefulWidget {
  ChooseManage selectedManage;
  AccManagementScreen({Key? key, required this.selectedManage})
      : super(key: key);

  @override
  State<AccManagementScreen> createState() => AccManagementScreenState();
}

class AccManagementScreenState extends State<AccManagementScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _parentPhoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hesap Bilgilerim"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            chooseWidget(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0)),
                ),
                onPressed: chooseButtonAction,
                child: const Text("Değiştir!")), 
          ],
        ),
      ),
    );
  }

  chooseWidget() {
    if (widget.selectedManage == ChooseManage.Mail) {
      return mailColumn();
    } else if (widget.selectedManage == ChooseManage.ParentPhone) {
      return parentPhoneColumn();
    } else if (widget.selectedManage == ChooseManage.Password) {
      return passwordColumn();
    }
  }

  chooseButtonAction() {
    if (widget.selectedManage == ChooseManage.Mail) {
      AuthMethods().updateMail(_emailController.text);
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen()),
        ModalRoute.withName('/'),
      );
    } else if (widget.selectedManage == ChooseManage.ParentPhone) {
      return parentPhoneColumn();
    } else if (widget.selectedManage == ChooseManage.Password) {
      AuthMethods().updatePassword(_passwordController.text);
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginScreen()),
        ModalRoute.withName('/'),
      );
    }
  }

  Column mailColumn() {
    return Column(
      children: [
        const Text(
          "E-Posta Yönetim",
          style: TextStyle(fontSize: 28, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        TextFieldInput(
            name: "E-Posta Adresiniz",
            icon: Icon(Icons.mail),
            textInputType: TextInputType.emailAddress,
            IsPass: false,
            textEditingController: _emailController),
      ],
    );
  }

  Column parentPhoneColumn() {
    return Column(
      children: [
        const Text(
          "Numara Yönetimi",
          style: TextStyle(fontSize: 28, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        TextFieldInput(
            name: "Veli Telefon Numarası",
            icon: Icon(Icons.phone),
            textInputType: TextInputType.phone,
            IsPass: false,
            textEditingController: _parentPhoneController),
      ],
    );
  }

  Column passwordColumn() {
    return Column(
      children: [
        const Text(
          "Şifre Yönetimi",
          style: TextStyle(fontSize: 28, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        TextFieldInput(
          name: "Şifreniz",
          icon: Icon(Icons.password),
          textInputType: TextInputType.visiblePassword,
          IsPass: true,
          textEditingController: _passwordController,
        ),
      ],
    );
  }
}
