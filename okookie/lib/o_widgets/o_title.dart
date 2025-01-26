import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class OTitle extends StatelessWidget {
  const OTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const AutoSizeText(
      'Okookie',
      maxFontSize: 50,
      minFontSize: 20,
      style: TextStyle(
          fontFamily: 'mataryah', color: Colors.black, fontSize: 50),
    );
  }
}
