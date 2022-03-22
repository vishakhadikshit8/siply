import '../model/quiz_model.dart';

class QuestionsRepository {
  List<int> questionIds = [0, 1];
  List<String> questionInfo = ["Question 1", "Question 2"];
  List<Option> options = [
    Option(1, 'opt a'),
    Option(2, 'opt b'),
    Option(3, 'opt c'),
    Option(4, 'opt d'),
  ];

  QuestionModel getresponse() {
    return (QuestionModel(
        question_id: questionIds,
        question_info: questionInfo,
        options: options));
  }
}
