import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fitness_track/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: const [ProfileCard()],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  void openInstagramLink() async {
    Uri url = Uri.parse("https://instagram.com/dafaqilaa");

    await launchUrl(url); //launch is from url_launcher package to launch URL
  }

  @override
  Widget build(BuildContext context) {
    String username =
        Provider.of<ProfileProvider>(context, listen: true).username;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            color: Theme.of(context).colorScheme.surface,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(username,
                        style: Theme.of(context).textTheme.titleSmall),
                    leading: CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.onSurface,
                        foregroundColor: Colors.black,
                        child: const Icon(Icons.person_outline)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Divider(
          height: 50,
        ),
        Text("Disclaimer", style: Theme.of(context).textTheme.titleLarge),
        const Text(
          "This is for Wireless Mobile Programming MidTerm Project",
          style: TextStyle(fontStyle: FontStyle.italic),
          textAlign: TextAlign.center,
        ),
        const Divider(
          height: 50,
        ),
        const Text(
            "This app created with Flutter and for the backend im using NodeJS, MongoDB\n"),
        TextButton(
          onPressed: openInstagramLink,
          child: const Text(
            "Instagram",
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
          ),
        )
      ],
    );
  }
}

class Field extends StatelessWidget {
  final String labelText;
  const Field({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.grey.shade500, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,
            alignLabelWithHint: false,
          ),
        ),
      ),
    );
  }
}
