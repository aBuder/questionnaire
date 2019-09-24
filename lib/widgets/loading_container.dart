import 'package:fastic/constants.dart';
import 'package:flutter/material.dart';

/// Build loading container widget
/// 
class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircularProgressIndicator(
        ),
      ),
    );
  }
}
