import 'package:flutter/material.dart';

class SignInHero extends StatelessWidget {
  const SignInHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome!",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.headlineMedium?.fontSize,
                fontWeight:
                    Theme.of(context).textTheme.headlineMedium?.fontWeight)),
        Text("Sign in to continue",
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: Theme.of(context).textTheme.headlineSmall?.fontSize,
                fontWeight:
                    Theme.of(context).textTheme.headlineMedium?.fontWeight)),
      ],
    );
  }
}
