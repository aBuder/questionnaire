import 'package:equatable/equatable.dart';
import 'package:fastic/model/models.dart';
import 'package:meta/meta.dart';

@immutable
abstract class QuestionsState extends Equatable {
  QuestionsState([List props = const []]) : super(props);
}

/// State for loading questions
class QuestionsLoading extends QuestionsState {
  @override
  String toString() => 'QuestionsLoading';
}

/// State if an error occurs
class QuestionsError extends QuestionsLoading {
  @override
  String toString() => 'QuestionsError';
}

/// State for show an question
class ShowQuestion extends QuestionsState {
  final Question question;
  final bool hasNextQuestions;
  final bool canTapNext;
  final int index;
  final int total;

  ShowQuestion({
    @required this.question,
    @required this.hasNextQuestions,
    @required this.canTapNext,
    @required this.index,
    @required this.total,
  }) : super([question, hasNextQuestions, index, total]);

  @override
  String toString() => 'ShowQuestions';
}

/// State for finish questions
class FinishQuestion extends QuestionsState {
  @override
  String toString() => 'FinishQuestion';
}
