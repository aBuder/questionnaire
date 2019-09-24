import 'package:fastic/constants.dart';
import 'package:flutter/material.dart';

class AnswerText extends StatelessWidget {
  final bool selected;
  final String text;
  final Function onTap;

  AnswerText({
    @required this.text,
    @required this.selected,
    @required this.onTap,
  });

  Widget _buildIcon() {
    if (selected) {
      return ClipOval(
        child: Container(
          height: 30,
          width: 30,
          color: kAnswerSelectIconColor,
          child: Icon(
            Icons.done,
            color: Colors.white,
            size: 16,
          ),
        ),
      );
    }

    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color(0XFFFBF8F1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: _buildIcon(),
        title: Text(
          text ?? '',
          style: kAnswerTextStyle,
        ),
        onTap: () => onTap(),
      ),
    );
  }
}
