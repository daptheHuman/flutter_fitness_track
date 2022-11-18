import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final Function(String) onChangeEmail;
  final Function(String) onChangeUsername;
  final Function(String) onChangePass;
  const SignUpForm(
      {super.key,
      required this.onChangeEmail,
      required this.onChangeUsername,
      required this.onChangePass});

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
            onChanged: onChangeUsername,
            decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(),
              border: UnderlineInputBorder(),
              labelText: "username",
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
