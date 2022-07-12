
import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Giriş Ekranı"),
        backgroundColor: secondaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 230,
                child: const Image(
                  image: AssetImage("assets/images/gebze_logo1.png"),
                ),
              ),
              const Center(child: Text("Lütfen kayıt bilgilerinizi giriniz.")),
              const Divider(),
              Column(
                children: const [
                  // TextFieldInput(
                  //   name: "Email Adresiniz",
                  //   icon: Icon(Icons.email),
                  //   textInputType: TextInputType.emailAddress,
                  //   IsPass: false,
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // TextFieldInput(
                  //   name: "Şifreniz",
                  //   icon: Icon(Icons.lock),
                  //   textInputType: TextInputType.visiblePassword,
                  //   IsPass: true,
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(child: Text("Hesabınız yok mu?")),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0)),
                        ),
                        onPressed: () {},
                        child: const Text("Giriş Yap!")),
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
