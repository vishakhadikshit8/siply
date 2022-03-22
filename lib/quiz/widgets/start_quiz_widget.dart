import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:flutter/material.dart';
import 'package:siply/core/constant.dart';
import 'package:siply/quiz/widgets/quiz_widget.dart';

class StartQuizScreen extends StatefulWidget {
  @override
  _StartQuizScreenState createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends State<StartQuizScreen>
    with TickerProviderStateMixin {
  ParticleOptions particleOptions = ParticleOptions(
    image: Image.asset('images/background.png'),
    baseColor: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: particleOptions,
        ),
        vsync: this,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizPage()),
                  );
                },
                child: Text(startTxt),
              )
            ],
          ),
        ),
      ),
    );
  }
}
