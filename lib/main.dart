import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quize_brain.dart';

QuizBrain quizeBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: Text('Quize App'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.0,
            ),
            child: _myQuizeApp(),
          ),
        ),
      ),
    );
  }
}

class _myQuizeApp extends StatefulWidget {
  const _myQuizeApp({super.key});

  @override
  State<_myQuizeApp> createState() => __myQuizeAppState();
}

class __myQuizeAppState extends State<_myQuizeApp> {
  List<Icon> scoreKeeper = [
  ];
  void checkAnswer(bool userPicked){
    bool correct = quizeBrain.getCorrectAns();
    setState(() {
      if(quizeBrain.isFinished()==true){
        Alert(
          context: context,
          title: 'Finished',
          desc: "you reached the last question",
        ).show();

        quizeBrain.reset();
        scoreKeeper=[];
      }else {
        if (userPicked == correct) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red,));
        }

        quizeBrain.nextQuestion();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizeBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: LinearBorder.start(), backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(true);
              },
              child: Text(
                'True',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: LinearBorder.start(), backgroundColor: Colors.red),
              onPressed: () {
                checkAnswer(false);
              },
              child: Text(
                'Fals',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: scoreKeeper, // Assuming scoreKeeper is a list of widgets
          ),
        )
      ],
    );
  }
}
