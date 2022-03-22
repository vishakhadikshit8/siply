import 'package:siply/core/constant.dart';
import 'package:siply/quiz/widgets/quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() => runApp(Quiz());

class Quiz extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: new SplashScreen(
        seconds: animation_duration,
        navigateAfterSeconds: QuizPage(),
        image: new Image.asset('images/quiz_logo.png'),
        photoSize: photSize_130,
        gradientBackground: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            gradient_1,
            gradient_4,
            gradient_6,
            gradient_9,
          ],
          colors: [
            Colors.yellow,
            Colors.red,
            Colors.indigo,
            Colors.teal,
          ],
        ),
      ),
    );
  }
}
