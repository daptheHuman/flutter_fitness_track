import 'package:flutter/material.dart';

class SignUpHero extends StatelessWidget {
  const SignUpHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Sign Up First!",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                fontWeight:
                    Theme.of(context).textTheme.headlineMedium?.fontWeight)),
      ],
    );
  }
}
