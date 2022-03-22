abstract class QuestionEvent {}

class LoadQuestion extends QuestionEvent {
  @override
  String toString() {
    return "QuestionLoading";
  }
}

class TapOption extends QuestionEvent {
  int quizId;
  int optionId;

  TapOption(this.quizId, this.optionId);
}

class TapNextQuestion extends QuestionEvent {}

class TapPreviousQuestion extends QuestionEvent {}
