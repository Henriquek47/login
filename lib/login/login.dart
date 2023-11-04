import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/home.dart';
import 'package:url_launcher/url_launcher.dart';

import 'input.dart';
import 'login_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height * 1,
          width: Get.width * 1,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [Color(0XFF1e4d61), Color(0xFF2d958e)],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        InputWidget(
                          icon: Icons.person,
                          title: 'Usuário',
                          controller: controller.email,
                          validator: controller.validateEmail,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        InputWidget(
                          icon: Icons.lock,
                          title: 'Senha',
                          controller: controller.password,
                          isPassword: true,
                          validator: controller.validatePassword,
                        ),
                        const SizedBox(height: 35),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: TextButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.green[800]!;
                                  }
                                  return Colors.green;
                                },
                              ),
                            ),
                            onPressed: () {
                              final localContext = context;
                              if (_formKey.currentState?.validate() ?? false) {
                                controller.login().then((isLoggedIn) {
                                  if (isLoggedIn) {
                                    Navigator.push(
                                      localContext,
                                      MaterialPageRoute(
                                          builder: (context) => const Home()),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        controller.showCustomSnackBar());
                                  }
                                });
                              }
                            },
                            child: const Text(
                              'Entrar',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 225, 225, 225)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (!await launchUrl(controller.url)) {
                      throw Exception('Could not launch ${controller.url}');
                    }
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Política de privacidade',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
