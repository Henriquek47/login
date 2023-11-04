import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login/login/service.dart';
import 'package:login/login/user_model.dart';

class LoginController extends GetxController {
  LoginConnection connection = LoginConnection();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Uri _url = Uri.parse('https://google.com');

  TextEditingController get email => _email;
  TextEditingController get password => _password;
  Uri get url => _url;

  Future<bool> login() async {
    validateEmail(_email.text.trimRight().toLowerCase());
    validatePassword(_password.text.trimRight());
    UserModel user = UserModel(
        email: _email.text.trimRight().toLowerCase(),
        password: _password.text.trimRight());
    final body = await connection.login(user.toJson());
    if (body == null || body.isEmpty) {
      return false;
    }
    return true;
  }

  String? validatePassword(String? value) {
    // Make sure the value can be null
    if (value == null || value.isEmpty) {
      return 'Coloque uma senha';
    } else if (value.length <= 2 || value.length > 20) {
      return 'Senha tem que ter entre 3 a 20 caracteres';
    } else {
      final RegExp passwordRegExp = RegExp(r'^[a-zA-Z0-9]+$');
      if (!passwordRegExp.hasMatch(value)) {
        return 'Senha pode ter apenas números e letras';
      }
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Coloque um email';
    } else if (value.length > 20) {
      return 'Email até 20 catecteres';
    } else {
      // Coloque aqui sua validação de e-mail (por exemplo, regex para formato de e-mail)
    }
    return null;
  }

  SnackBar showCustomSnackBar() {
    return const SnackBar(
      backgroundColor: Colors.red,
      content: Text('Usuario inexistente'),
    );
  }
}
