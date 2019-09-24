import 'package:flutter/material.dart';

/// Model class for Question.
///
/// attributes:
///  - id: String
///  - text: String
///  - multiple: bool
///  - image: String
///  - answers: List of Answer objects
///
class Question {
  String id; // id of question
  String text; // text of question
  bool multiple; // if multiple answers allowed
  String image; // image name, have to exists in assets folder
  List<Answer> answers; // list of answers

  Question({
    @required this.id,
    @required this.text,
    @required this.multiple,
    @required this.image,
    @required this.answers,
  });

  /// Convert json to an [Question] object. If json
  /// is null, method will return null
  ///
  ///  Sample json:
  ///
  /// {
  ///   "id": "goals",
  ///   "text": "Welche persönlichen Ziele möchtest du verfolgen?",
  ///   "multiple": true,
  ///   "image": "question_1_header",
  ///   "answers": [
  ///     {
  ///       "id": "loose_weight",
  ///       "text": "Ich möchte abnehmen"
  ///     },
  ///   ]
  /// }
  ///
  ///
  factory Question.fromJson(Map<String, dynamic> json) {
    // check if null
    if (json == null) {
      return null;
    }

    // convert to [Answer] object
    return Question(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      multiple: json['multiple'] ?? false,
      image: json['image'] ?? '',
      answers:
          (json['answers'] as List).map((a) => Answer.fromJson(a)).toList(),
    );
  }
}

/// Model class for Answer.
///
/// attributes:
///  - id: String
///  - text: String
///
class Answer {
  String id; // id of answer
  String text; //text of answer
  bool isSelected = false;

  Answer({
    @required this.id,
    @required this.text,
  });

  /// Convert json to an [Answer] object. If json
  /// is null, method will return null
  ///
  ///  Sample json:
  ///
  ///   {
  ///     "id": "more_energy",
  ///     "text": "Mehr Energie im Alltag haben"
  ///   }
  ///
  ///
  factory Answer.fromJson(Map<String, dynamic> json) {
    // check if null
    if (json == null) {
      return null;
    }

    // convert to [Answer] object
    return Answer(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}
