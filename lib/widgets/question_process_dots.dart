import 'package:fastic/constants.dart';
import 'package:flutter/material.dart';

/// Build questionnaire process dots.
/// The index attribute describe current
/// position ind list of questions and total
/// the total number of questions
class QuestionProcessDots extends StatelessWidget {
  final int index; // index of current question
  final int total; // total number of questions

  QuestionProcessDots({
    @required this.index,
    @required this.total,
  });

  /// Build list with active in inactive dots
  List<Widget> _buildDots() {
    List<Widget> dots = List();
    int totalQuestions = total ?? 0;
    int currentQuestionIndex = index ?? 0;
    for (var count = 0; count < totalQuestions; count++) {
      final dot = Padding(
        padding: EdgeInsets.symmetric(horizontal: 2),
        child: ClipOval(
          child: Container(
            height: 12,
            width: 12,
            color: (count <= currentQuestionIndex)
                ? kQuestionProcessDotActive
                : kQuestionProcessDotInactive,
          ),
        ),
      );
      dots.add(dot);
    }
    return dots;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: _buildDots(),
    );
  }
}
