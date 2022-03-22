import '../model/quiz_model.dart';

class QuestionState {}

class LoadingState extends QuestionState {
  String message;

  LoadingState(this.message);
}

class QuestionLoaded extends QuestionState {
  QuestionModel questionModel;

  QuestionLoaded({this.questionModel});
}

class NextQuestionState extends QuestionState {
  int nextQuestion;
  QuestionModel questionModel;

  NextQuestionState({this.nextQuestion, this.questionModel});
}

class PreviousQuestionState extends QuestionState {
  int previousQuestion;
  QuestionModel questionModel;

  PreviousQuestionState({this.previousQuestion, this.questionModel});
}

class UnableToFetchQuestionError extends QuestionState {
  final String error;

  UnableToFetchQuestionError({this.error});

  @override
  String toString() => 'UnableToScanReasonInAttendanceError';
}

class UninitializedState extends QuestionState {
  @override
  String toString() => 'UnableToScanReasonInAttendanceUninitialized';
}
