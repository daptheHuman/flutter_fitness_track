import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/screen/signup/widgets/signup_hero.dart';

import 'widgets/signup_button.dart';
import 'widgets/signup_form.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({super.key});

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
  String email = "";
  String username = "";
  String password = "";
  String error = "";

  void changeEmail(value) {
    setState(() {
      email = value;
    });
  }

  void changeUsername(value) {
    setState(() {
      username = value;
    });
  }

  void changePassword(value) {
    setState(() {
      password = value;
    });
  }

  void changeError(value) {
    setState(() {
      error = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SignUpHero(),
                const VerticalDivider(indent: 40),
                SignUpForm(
                  onChangeEmail: (val) => changeEmail(val),
                  onChangeUsername: (val) => changeUsername(val),
                  onChangePass: (val) => changePassword(val),
                ),
                const VerticalDivider(indent: 100),
                SignUpBtn(
                    email: email,
                    username: username,
                    password: password,
                    setError: changeError),
                const VerticalDivider(indent: 10),
                Text(
                  error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      height: (error.isNotEmpty) ? 1 : 0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
