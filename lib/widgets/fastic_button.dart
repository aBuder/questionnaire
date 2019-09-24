import 'package:fastic/constants.dart';
import 'package:flutter/material.dart';


/// Build an default button.
/// 
/// attributes:
///   - text: text of button
///   - onTap: Callback handler on tap
/// 
class FasticButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isEnabled;

  FasticButton({
    @required this.text,
    @required this.onTap,
    @required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    if(!isEnabled) {
      return SizedBox(
        height: 50,
        child: FlatButton(
          color: kFasticButtonColorInactive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () {},
        ),
      );
    } else {
      return SizedBox(
        height: 50,
        child: FlatButton(
          color: kFasticButtonColorActive,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: Text(
            text ?? '',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: () => onTap(),
        ),
      );
    }

  }
}
