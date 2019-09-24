import 'package:fastic/bloc/questions_bloc/questions_bloc.dart';
import 'package:fastic/bloc/questions_bloc/questions_events.dart';
import 'package:fastic/bloc/questions_bloc/questions_states.dart';
import 'package:fastic/model/models.dart';
import 'package:fastic/widgets/answer_text.dart';
import 'package:fastic/widgets/fastic_button.dart';
import 'package:fastic/widgets/loading_container.dart';
import 'package:fastic/widgets/question_process_dots.dart';
import 'package:fastic/widgets/question_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants.dart';

/// Build an screen for question with one
/// or multiple answers
class QuestionScreen extends StatelessWidget {
  final QuestionsBloc _bloc = QuestionsBloc();

  QuestionScreen() {
    // fire event to load questions
    _bloc.dispatch(LoadQuestions());
  }

  /// Method build an list with all answer widgets
  ///
  /// parameters:
  ///   - question: Question object
  ///
  /// return:
  ///   - List<Widget>: list of answer widgets
  List<Widget> _buildAnswers(Question question) {
    List<Widget> widgets = [];
    List<Answer> answers = question?.answers ?? [];
    for (Answer answer in answers) {
      widgets.add(AnswerText(
        text: answer.text,
        selected: answer.isSelected,
        onTap: () {
          final event = SelectAnswer(question: question, answer: answer);
          _bloc.dispatch(event);
        },
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsBloc, QuestionsState>(
      bloc: _bloc,
      builder: (BuildContext context, QuestionsState state) {
        // if state is loading
        if (state is LoadQuestions) {
          return Scaffold(
            body: LoadingContainer(),
          );
        }

        // if state is ShowQuestion
        if (state is ShowQuestion) {
          Question question = state.question;
          bool hasNextQuestion = state.hasNextQuestions;
          return Scaffold(
            body: Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.transparent,
                      expandedHeight: 200,
                      pinned: true,
                      elevation: 0,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                          'images/${question.image}.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate([
                        QuestionText(
                          text: question?.text ?? '',
                        ),
                        ..._buildAnswers(question),
                        SizedBox(
                          height: 100,
                        ),
                      ]),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 24,
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: QuestionProcessDots(
                          index: state?.index,
                          total: state?.total,
                        ),
                      ),
                      FasticButton(
                        text: hasNextQuestion ? 'WEITER' : 'DONE',
                        isEnabled: state.canTapNext,
                        onTap: () {
                          final event = NextQuestion(
                            question: question,
                            answers: [],
                          );
                          _bloc.dispatch(event);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }

        // if finish state
        if (state is FinishQuestion) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text('Prima alle Fragen wurden beantwortet'),
              ),
            ),
          );
        }

        // otherwise loading
        return Scaffold(
          body: LoadingContainer(),
        );
      },
    );
  }
}
