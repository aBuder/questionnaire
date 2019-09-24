import 'package:fastic/constants.dart';
import 'package:flutter/material.dart';

class QuestionText extends StatelessWidget {
  final String text;

  QuestionText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Text(
        text ?? '',
        style: kQuestionTextStyle
      ),
    );
  }
}
