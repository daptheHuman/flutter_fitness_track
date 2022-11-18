import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:flutter_fitness_track/screen/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_fitness_track/provider/auth_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class SignUpBtn extends StatefulWidget {
  final String email;
  final String username;
  final String password;
  final Function(String) setError;

  const SignUpBtn(
      {super.key,
      required this.email,
      required this.username,
      required this.password,
      required this.setError});

  @override
  State<SignUpBtn> createState() => _SignUpBtnState();
}

class _SignUpBtnState extends State<SignUpBtn> {
  dynamic signupBtn() async {
    bool isEmailValid = EmailValidator.validate(widget.email);

    if (!isEmailValid) {
      return widget.setError("Please enter a valid email");
    }

    if (widget.username.length < 6) {
      return widget.setError("Username must be at least 6 characters");
    }

    if (widget.password.length < 8) {
      return widget.setError("Password must be at least 8 characters");
    }
    try {
      await context.read<AuthProvider>().signup(
            email: widget.email,
            username: widget.username,
            password: widget.password,
          );
      if (!mounted) return;

      Map profile = context.read<AuthProvider>().getProfile;
      Provider.of<ProfileProvider>(context, listen: false).setProfile = profile;
      Navigator.pop(context);
    } catch (error) {
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
            onPressed: () => signupBtn(),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
