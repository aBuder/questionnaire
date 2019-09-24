import 'package:equatable/equatable.dart';
import 'package:fastic/model/models.dart';
import 'package:meta/meta.dart';

/// Base class for QuestionsEvent
@immutable
abstract class QuestionsEvent extends Equatable {
  QuestionsEvent([List props = const []]) : super(props);
}

/// Event class to load all questions
class LoadQuestions extends QuestionsEvent {
  @override
  String toString() => 'LoadQuestions';
}

/// Event for next question
class NextQuestion extends QuestionsEvent {
  final Question question;
  final List<Answer> answers;

  NextQuestion({
    @required this.question,
    @required this.answers,
  }) : super([question, answers]);

  @override
  String toString() => 'NextQuestion';
}

/// Event for select an answer
class SelectAnswer extends QuestionsEvent {
  final Question question;
  final Answer answer;

  SelectAnswer({
    @required this.question,
    @required this.answer,
  }) : super([question, answer]);

  @override
  String toString() => 'SelectAnswer';
}

/// Event for finish question
class FinishQuestions extends QuestionsEvent {
  final Question question;
  final List<Answer> answers;

  FinishQuestions({
    @required this.question,
    @required this.answers,
  }) : super([question, answers]);

  @override
  String toString() => 'FinishQuestions';
}
