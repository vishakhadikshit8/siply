import 'package:siply/core/constant.dart';
import 'package:siply/quiz/bloc/question_bloc.dart';
import 'package:siply/quiz/bloc/question_events.dart';
import 'package:siply/quiz/bloc/question_state.dart';
import 'package:siply/quiz/model/quiz_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siply/quiz/widgets/start_quiz_widget.dart';

int option_index = 0;
int question_index = 0;
int points = 0;

class QuizPage extends StatefulWidget {
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final _quizBloc = QuizBloc(UninitializedState());
  QuestionModel _questionModel;
  bool nextQuestionButton = false;

  @override
  void initState() {
    _questionModel = QuestionModel();
    _quizBloc.add(LoadQuestion());
    super.initState();
  }

  @override
  void dispose() {
    _quizBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding:
            EdgeInsets.symmetric(vertical: padding_50, horizontal: padding_15),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: BlocBuilder(
              bloc: _quizBloc,
              builder: (BuildContext context, QuestionState state) {
                if (state is UninitializedState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is UnableToFetchQuestionError) {
                  return Center(
                    child: new Text(
                      state.error,
                      textAlign: TextAlign.start,
                    ),
                  );
                } else if (state is QuestionLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          Flexible(
                            child: IconButton(
                              onPressed: () => onPressedBackArrow(state),
                              icon: Icon(Icons.arrow_back_ios),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Flexible(
                            child: IconButton(
                              onPressed: () => onPressedForwardArrow(state),
                              icon: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: flex_12,
                        child: Center(
                          child: Text(
                            state.questionModel.question_info[question_index],
                            style: TextStyle(fontSize: font_size),
                          ),
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {
                            _quizBloc.add(TapNextQuestion());
                            points = points + 10;
                          },
                          child: getNameOfOptionButton(0, state)),
                      RaisedButton(
                          onPressed: () {
                            _quizBloc.add(TapNextQuestion());
                          },
                          child: getNameOfOptionButton(1, state)),
                    ],
                  );
                } else if (state is PreviousQuestionState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => onPressedBackArrow(state),
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          IconButton(
                            onPressed: () => onPressedForwardArrow(state),
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: flex_12,
                        child: Center(
                          child: Text(
                            (state)
                                .questionModel
                                .question_info[(state).previousQuestion],
                            style: TextStyle(fontSize: font_size),
                          ),
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {
                            points = 0;
                            _quizBloc.add(TapNextQuestion());
                            ;
                          },
                          child: getNameOfOptionButton(0, state)),
                      RaisedButton(
                          onPressed: () {
                            points = 0;
                            _quizBloc.add(TapNextQuestion());
                          },
                          child: getNameOfOptionButton(1, state)),
                    ],
                  );
                } else if (state is NextQuestionState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => onPressedBackArrow(state),
                            icon: Icon(Icons.arrow_back_ios),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                          ),
                          IconButton(
                            onPressed: () => onPressedForwardArrow(state),
                            icon: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: flex_12,
                        child: Center(
                          child: Text(
                            (state)
                                .questionModel
                                .question_info[(state).nextQuestion],
                            style: TextStyle(fontSize: font_size),
                          ),
                        ),
                      ),
                      RaisedButton(
                          onPressed: () {
                            points = points + 10;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen()),
                            );
                          },
                          child: getNameOfOptionButton(0, state)),
                      RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResultScreen()),
                            );
                          },
                          child: getNameOfOptionButton(1, state)),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

  Function onPressedBackArrow(QuestionState state) {
    if (state is QuestionLoaded) {
      int first = (state).questionModel.question_id[0];
      if (first == 1) {
        _quizBloc.add(TapPreviousQuestion());
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StartQuizScreen()),
        );
      }
    } else if (state is PreviousQuestionState) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizPage()),
      );
    } else if (state is NextQuestionState) {
      _quizBloc.add(TapPreviousQuestion());
    }
  }

  Function onPressedForwardArrow(QuestionState state) {
    if (state is QuestionLoaded) {
      _quizBloc.add(TapNextQuestion());
    } else if (state is PreviousQuestionState) {
      _quizBloc.add(TapNextQuestion());
    } else if (state is NextQuestionState) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ResultScreen()));
    }
  }

  // Function onPressedOption(QuestionState state) {
  //   if (state is QuestionLoaded) {
  //     _quizBloc.add(TapNextQuestion());
  //   } else if (state is PreviousQuestionState) {
  //     _quizBloc.add(TapNextQuestion());
  //   } else if (state is NextQuestionState) {
  //     WidgetsBinding.instance.addPostFrameCallback((_) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => ResultScreen()),
  //       );
  //     });
  //   }
  // }

  Widget getNameOfOptionButton(int option_index, QuestionState state) {
    if (state is QuestionLoaded) {
      return (Text((state).questionModel.options[option_index].option_info));
    } else if (state is NextQuestionState) {
      return (Text((state).questionModel.options[option_index].option_info));
    } else if (state is PreviousQuestionState) {
      return (Text((state).questionModel.options[option_index].option_info));
    }
  }

  Widget ResultScreen() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(resultTxt + (points * 2).toString(), style: retakeQuizTS),
          Padding(
            padding: const EdgeInsets.only(top: font_size),
            child:
                Text(totalRewardsTxt + points.toString(), style: retakeQuizTS),
          ),
          Padding(
            padding: const EdgeInsets.only(top: font_size),
            child: RaisedButton(
              child: Text(
                retakeQuizTxt,
                style: retakeQuizTS,
              ),
              onPressed: () {
                question_index = 0;
                points = 0;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// class QuizWidgets extends StatelessWidget {
//   final QuestionState state;
//   final Function(QuestionState) onClickBackArrow;
//   final Function(QuestionState) onClickForwardArrow;
//
//   const QuizWidgets(
//       {Key key, this.state, this.onClickBackArrow, this.onClickForwardArrow})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: <Widget>[
//         Row(
//           children: [
//             IconButton(
//               onPressed: () => onClickBackArrow,
//               icon: Icon(Icons.arrow_back_ios),
//             ),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.68,
//             ),
//             IconButton(
//               onPressed: () => onClickForwardArrow,
//               icon: Icon(Icons.arrow_forward_ios),
//             ),
//           ],
//         ),
//         Expanded(
//           flex: flex_12,
//           child: Center(
//             child: Text(getQuestion(state)),
//           ),
//         ),
//       ],
//     );
//   }
//
//   getQuestion(QuestionState state) {
//     if (state is QuestionLoaded) {
//       state.questionModel.question_info[question_index];
//     } else if (state is PreviousQuestionState) {
//       (state).questionModel.question_info[(state).previousQuestion];
//     } else if (state is NextQuestionState) {
//       (state).questionModel.question_info[(state).nextQuestion];
//     }
//   }
// }
