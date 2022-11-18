import 'package:flutter/cupertino.dart';

class VerticalPadding extends StatelessWidget {
  const VerticalPadding({super.key, required this.height});
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
    );
  }
}
