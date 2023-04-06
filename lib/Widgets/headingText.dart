// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import '../constants.dart';

class HeadingText extends StatelessWidget {
  String headingText;
  HeadingText(this.headingText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Text(
            headingText,
            style: const TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
