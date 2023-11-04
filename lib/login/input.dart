import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final TextEditingController controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  const InputWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, left: 5),
            child: Text(
              title,
              style: const TextStyle(color: Color.fromARGB(255, 225, 225, 225)),
            ),
          ),
          SizedBox(
            width: 275,
            child: TextFormField(
              obscureText: isPassword,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  icon,
                  color: Colors.black,
                ),
                errorMaxLines:
                    1,
              ),
              validator: validator,
            ),
          )
        ],
      ),
    );
  }
}
