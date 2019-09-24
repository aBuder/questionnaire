import 'package:bloc/bloc.dart';
import 'package:fastic/bloc/questions_bloc/questions_events.dart';
import 'package:fastic/bloc/questions_bloc/questions_states.dart';
import 'package:fastic/model/models.dart';
import 'package:fastic/repository/question_respository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

/// Bloc for Questions. This Bloc will fetch questions form
/// firebase remote config and display the user each question.
/// On answer an question, an firebase analytics event
/// would be send.
class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  List<Question> _questions = [];
  Iterator iterator;

  @override
  QuestionsState get initialState => QuestionsLoading();

  /// Handle incoming event `LoadQuestions` and
  /// will fetch questions from firebase remote config.
  /// While fetching the state would be set to `QuestionsLoading`
  /// after loading
  Stream<QuestionsState> _mapLoadQuestionsEventToState(
      LoadQuestions event) async* {
    yield QuestionsLoading();
    _questions = await QuestionRepository.fetchQuestions();
    iterator = _questions.iterator;

    if (iterator.moveNext()) {
      // log start event
      await _analytics.logEvent(name: "questionnaire_start", parameters: {});

      // set state to ShowQuestion
      yield ShowQuestion(
        question: iterator.current,
        hasNextQuestions: _questions.last != iterator.current,
        canTapNext: false,
        index: _questions.indexOf(iterator.current),
        total: _questions.length,
      );
    } else {
      // log finish event
      _analytics.logEvent(name: "questionnaire_finish", parameters: {});
      // set state FinishQuestion
      yield FinishQuestion();
    }
  }

  /// Handle incoming event for `NextQuestionEvent` and will
  /// show the next question. If no next question is available,
  /// the user get state `FinishQuestion`.
  /// Function always do firebase analytics event for
  Stream<QuestionsState> _mapNextQuestionEventToState(
      NextQuestion event) async* {
    yield QuestionsLoading();

    List<Answer> selectedAnswers =
        event.question.answers.where((a) => a.isSelected).toList();

    for (Answer answer in selectedAnswers) {
      List answerIds = selectedAnswers.map((a) => a.id).toList();

      // track question answerIds of question
      await _analytics.logEvent(
        name: event.question.id,
        parameters: {
          "answers": answerIds,
        },
      );

      // track question answer on analytics
      await _analytics.logEvent(name: answer.id);
    }

    // check if has next question
    if (iterator.moveNext()) {
      // set state to ShowQuestion
      yield ShowQuestion(
        question: iterator.current,
        hasNextQuestions: _questions.last != iterator.current,
        canTapNext: false,
        index: _questions.indexOf(iterator.current),
        total: _questions.length,
      );
    } else {
      // track event for finish questionnaire
      _analytics.logEvent(name: "questionnaire_finish", parameters: {});
      // set state to FinishQuestion
      yield FinishQuestion();
    }
  }

  /// Handle incoming event for event `SelectAnswer`. Will check if
  /// question allow multiple answers or single answer. If single
  /// answer allowed, all other answers would be set to unselected.
  /// If multiple answers, the specific answer would be toggle.
  Stream<QuestionsState> _mapSelectAnswerToState(SelectAnswer event) async* {
    Question question = event.question;
    Answer selectedAnswer = event.answer;

    // if question only allow one answer
    // set all answers to false
    if (!question.multiple) {
      for (Answer answer in question.answers) {
        answer.isSelected = false;
      }
    }

    // toggle the selected answer
    for (Answer answer in question.answers) {
      if (answer.id == selectedAnswer.id) {
        answer.isSelected = !answer.isSelected;
      }
    }

    bool isAnswerSelected = question.answers.where((a) => a.isSelected).isNotEmpty;
    yield QuestionsLoading();

    // set state to ShowQuestion
    yield ShowQuestion(
      question: question,
      hasNextQuestions: true,
      canTapNext: isAnswerSelected,
      index: _questions.indexOf(question),
      total: _questions.length,
    );
  }

  /// Handle all incoming events and navigate to separate functions
  ///
  @override
  Stream<QuestionsState> mapEventToState(QuestionsEvent event) async* {
    if (event is LoadQuestions) {
      yield* _mapLoadQuestionsEventToState(event);
    }
    if (event is NextQuestion) {
      yield* _mapNextQuestionEventToState(event);
    }
    if (event is SelectAnswer) {
      yield* _mapSelectAnswerToState(event);
    }
  }
}
