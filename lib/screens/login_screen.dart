import 'package:bel_cocuk_takip/responsive/main_layout.dart';
import 'package:bel_cocuk_takip/screens/signup_screen.dart';
import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => MainLayout()),
        ),
      );
    }
  }

  void navigateToSignup() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => const SignupScreen())));
  }

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
                children: [
                  TextFieldInput(
                    name: "Email Adresiniz",
                    icon: const Icon(Icons.email),
                    textInputType: TextInputType.emailAddress,
                    IsPass: false,
                    textEditingController: _emailController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                    name: "Şifreniz",
                    icon: const Icon(Icons.lock),
                    textInputType: TextInputType.visiblePassword,
                    IsPass: true,
                    textEditingController: _passwordController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                        child: InkWell(
                            onTap: navigateToSignup,
                            child: const Text("Hesabınız yok mu?"))),
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
                        onPressed: loginUser,
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
