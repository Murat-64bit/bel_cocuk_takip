import 'package:bel_cocuk_takip/responsive/main_layout.dart';
import 'package:bel_cocuk_takip/screens/login_screen.dart';
import 'package:bel_cocuk_takip/utils/colors.dart';
import 'package:bel_cocuk_takip/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

import '../resources/auth_methods.dart';
import '../utils/utils.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _parentPhoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _parentPhoneController.dispose();
    _nameController.dispose();
  }

  void signUpUser() async {
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      parentPhone: _parentPhoneController.text,
    );

    if (res != 'succes') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((context) => MainLayout()),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text("Kayıt Ol!"),
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
                    name: "Adınız ve Soyadınız",
                    icon: Icon(Icons.person),
                    textInputType: TextInputType.text,
                    IsPass: false,
                    textEditingController: _nameController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFieldInput(
                    name: "Email Adresiniz",
                    icon: Icon(Icons.email),
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
                  TextFieldInput(
                    name: "Veli Telefon Numarası",
                    icon: Icon(Icons.phone),
                    textInputType: TextInputType.phone,
                    IsPass: false,
                    textEditingController: _parentPhoneController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                      child: InkWell(
                          onTap: navigateToLogin,
                          child: const Text("Hesabınız var mı?"))),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0)),
                  ),
                  onPressed: signUpUser,
                  child: const Text("Üye Ol!")),
            ],
          ),
        ),
      ),
    );
  }
}
