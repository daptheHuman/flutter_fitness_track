import 'package:flutter/material.dart';

class SignInForm extends StatelessWidget {
  final Function(String) onChangeEmail;
  final Function(String) onChangePass;
  const SignInForm(
      {super.key, required this.onChangeEmail, required this.onChangePass});

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            onChanged: onChangeEmail,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(),
              border: UnderlineInputBorder(),
              labelText: "email",
            ),
          ),
          TextField(
            onChanged: onChangePass,
            obscureText: true,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(),
              border: UnderlineInputBorder(),
              labelText: "password",
            ),
          ),
          const VerticalDivider(
            indent: 15,
          ),
          // const Text("Forget password?", textAlign: TextAlign.end),
        ]);
  }
}
