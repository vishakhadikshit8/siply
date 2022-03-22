import '../model/quiz_model.dart';
import '../quiz_repository/quiz_repo.dart';
import 'question_events.dart';
import 'question_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizBloc extends Bloc<QuestionEvent, QuestionState> {
  QuizBloc(QuestionState initialState) : super(initialState);

  @override
  QuestionState get initialState => LoadingState("Fetching Quiz Questions...");

  @override
  Stream<QuestionState> mapEventToState(QuestionEvent event) async* {
    if (event is LoadQuestion) {
      QuestionModel result = await QuestionsRepository().getresponse();
      yield QuestionLoaded(questionModel: result);
    } else if (event is TapNextQuestion) {
      QuestionModel result = await QuestionsRepository().getresponse();
      yield NextQuestionState(questionModel: result, nextQuestion: 1);
    } else if (event is TapPreviousQuestion) {
      QuestionModel result = await QuestionsRepository().getresponse();
      yield PreviousQuestionState(questionModel: result, previousQuestion: 0);
    }
  }
}
