import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/screen/signup/signup_container.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SignUpContainer(),
    );
  }
}
