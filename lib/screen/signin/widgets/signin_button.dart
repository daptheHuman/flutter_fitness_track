import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness_track/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignInBtn extends StatefulWidget {
  final String email;
  final String password;
  final Function(String) setError;

  const SignInBtn(
      {super.key,
      required this.email,
      required this.password,
      required this.setError});

  @override
  State<SignInBtn> createState() => _SignInBtnState();
}

class _SignInBtnState extends State<SignInBtn> {
  dynamic signinBtn() async {
    bool isEmailValid = EmailValidator.validate(widget.email);

    if (!isEmailValid) {
      return widget.setError("Please enter a valid email");
    }

    if (widget.password == "") {
      return widget.setError("Please enter a password");
    }
    try {
      await context.read<AuthProvider>().signin(
            email: widget.email,
            password: widget.password,
          );

      if (!mounted) return;
      Map profile = context.read<AuthProvider>().getProfile;
      Provider.of<ProfileProvider>(context, listen: false).setProfile = profile;
    } catch (error) {
      print(error);
      return widget.setError(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () => {signinBtn()},
            child: const Text(
              "Login",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
