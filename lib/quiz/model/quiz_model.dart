class QuestionModel {
  final List<int> question_id;
  final List<String> question_info;
  final List<Option> options;

  QuestionModel({this.question_id, this.options, this.question_info});
}

class Option {
  final int option_id;
  final String option_info;
  bool selected = false;

  Option(this.option_id, this.option_info);

  bool set_selection_state(bool selection_state) {
    this.selected = selection_state;
    return true;
  }
}
