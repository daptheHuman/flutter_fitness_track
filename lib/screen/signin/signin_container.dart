import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/screen/signup/signup.dart';
import 'widgets/signin_button.dart';
import 'widgets/signin_form.dart';
import 'widgets/signin_hero.dart';

class SignInContainer extends StatelessWidget {
  const SignInContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: double.infinity, child: BackdropFrontLayer());
  }
}

class BackdropFrontLayer extends StatefulWidget {
  const BackdropFrontLayer({
    Key? key,
    // required this.username,
    // required this.password
  }) : super(
          key: key,
        );

  @override
  State<BackdropFrontLayer> createState() => _BackdropFrontLayerState();
}

class _BackdropFrontLayerState extends State<BackdropFrontLayer> {
  String _email = "";
  String _password = "";
  String _error = "";

  void changeEmail(value) {
    setState(() {
      _email = value;
    });
  }

  void changePassword(value) {
    setState(() {
      _password = value;
    });
  }

  void changeError(value) {
    setState(() {
      _error = value;
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
                const SignInHero(),
                const VerticalDivider(indent: 40),
                SignInForm(
                    onChangeEmail: (val) => changeEmail(val),
                    onChangePass: (val) => changePassword(val)),
                const VerticalDivider(indent: 100),
                SignInBtn(
                    email: _email, password: _password, setError: changeError),
                const VerticalDivider(indent: 10),
                Text(
                  _error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      height: (_error.isNotEmpty) ? 1 : 0),
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: (() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const SignUp()));
          }),
          child: Text(
            "Create an account",
            style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 15),
          ),
        ),
        const VerticalDivider(
          indent: 30,
        )
      ],
    );
  }
}
