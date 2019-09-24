import 'package:fastic/screen/question_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(FasticApp());
}

/// Class of FasticApp will start MaterialApp
class FasticApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: QuestionScreen(),
    );
  }
}
