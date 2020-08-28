import 'dart:math';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/model/user_model.dart';
import 'package:quiz_app/view_model/data_view_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/widgets/clip_oval_widget.dart';

class QuizPage extends StatefulWidget {
  String categoryName;
  UserModel user;

  QuizPage({this.categoryName, this.user});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<List<Color>> colorCodes = [
    [Color(0xFF5086FF), Color(0xFF1749FF)],
    [Color(0xFF5086FF), Color(0xFF1749FF)],
    [Color(0xFF5086FF), Color(0xFF1749FF)]
  ];
  List<int> questionNumbers = [];
  int score = 0;
  int quizNumber = 0;
  int refreshBonus = 2;
  int showAnswer = 1;
  bool error = false;
  double award = 0.0;

  @override
  Widget build(BuildContext context) {
    final _dataViewModel = Provider.of<DataViewModel>(context, listen: false);

    QuizModel question = randomQuestion(_dataViewModel.questions);

    try {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
          backgroundColor: Color(0xFF333333),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Text(
                    quizNumber.toString(),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: 150,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF333333),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(
                        child: Text(
                      question.quizTitle,
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(top: 14),
                        decoration: new BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          gradient: new LinearGradient(
                            colors: colorCodes[index],
                            begin: FractionalOffset.centerLeft,
                            end: FractionalOffset.centerRight,
                          ),
                        ),
                        child: FlatButton(
                          child: Text(
                            question.quizOptions[index],
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (question.quizCorrectAnswer == index) {
                              setState(() {
                                score += 10;
                                quizNumber += 1;
                                colorCodes[index] = [
                                  Color(0xFF5086FF),
                                  Color(0xFF1749FF)
                                ];
                                award = score * 0.01;
                              });
                            } else {
                              setState(() {
                                error = true;
                                colorCodes[index] = [Colors.red, Colors.red];
                              });
                              await Future.delayed(Duration(seconds: 1));
                              _dataViewModel.coinsEarned(
                                  widget.user.userId, score);
                              if (award > 1) {
                                _dataViewModel.coinsEarned(
                                    widget.user.userId, 100);
                              }
                              wrongAnswerDialog(context);
                            }
                          },
                        ),
                      );
                    },
                    itemCount: question.quizOptions.length,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.only(top: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Badge(
                        badgeContent: Text(
                          refreshBonus.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              icon: Icon(Icons.refresh),
                              onPressed: () {
                                if (refreshBonus > 0) {
                                  setState(() {
                                    refreshBonus--;
                                    colorCodes[question.quizCorrectAnswer] = [
                                      Color(0xFF5086FF),
                                      Color(0xFF1749FF)
                                    ];
                                  });
                                }
                              }),
                        ),
                      ),
                      Badge(
                        badgeContent: Text(
                          showAnswer.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.blue,
                          child: IconButton(
                              icon: Icon(Icons.person),
                              onPressed: () {
                                if (showAnswer > 0) {
                                  setState(() {
                                    showAnswer--;
                                    colorCodes[question.quizCorrectAnswer] = [
                                      Colors.green,
                                      Colors.green
                                    ];
                                  });
                                }
                              }),
                        ),
                      ),
                      ClipOvalWidget(
                        clipColor: Colors.red,
                        iconSign: Icon(
                          Icons.do_not_disturb_on,
                          color: Colors.white,
                        ),
                        onTap: () {
                          if (award > 1) {
                            _dataViewModel.coinsEarned(widget.user.userId, 100);
                          }
                          _dataViewModel.coinsEarned(widget.user.userId, score);
                          showDialogMethod(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: award < 1
                      ? Row(
                          children: [
                            LinearPercentIndicator(
                              width: MediaQuery.of(context).size.width * 0.50,
                              lineHeight: 20.0,
                              percent: award < 1 ? award : 1,
                              backgroundColor: Colors.grey,
                              progressColor: Colors.blue,
                              center: Text(
                                (score * 0.5).toString() + "%",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Container(
                                width: 55,
                                height: 50,
                                child: Image.asset(
                                  "assets/images/leader-board.png",
                                  fit: BoxFit.fill,
                                )),
                          ],
                        )
                      : Column(
                          children: [
                            Text("You earned 100 Stone"),
                            Container(
                                width: 55,
                                height: 50,
                                margin: EdgeInsets.only(top: 10),
                                child: Image.asset(
                                  "assets/images/leader-board.png",
                                  fit: BoxFit.fill,
                                )),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      return CircularProgressIndicator();
    }
  }

  void wrongAnswerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Wrong Answer",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/leader-board.png",
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Score",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40),
                    ),
                    Text(
                      score.toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight:
                              FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: Text("Close"),
                )
              ],
            ));
  }

  void showDialogMethod(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "You Left The Game",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/leader-board.png",
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Score",
                      style: TextStyle(color: Colors.green, fontSize: 40),
                    ),
                    Text(
                      score.toString(),
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  color: Colors.green,
                  child: Text("Close"),
                )
              ],
            ));
  }

  QuizModel randomQuestion(List<QuizModel> allQuestions) {
    var index;
    if (showAnswer == 1) {
      index = Random().nextInt(allQuestions.length);
      questionNumbers.add(index);
    } else {
      index = Random().nextInt(allQuestions.length);
      questionNumbers.add(index);
      index = questionNumbers[questionNumbers.length - 2];
    }
    if (error == true) {
      if (showAnswer == 1) {
        index = questionNumbers[questionNumbers.length - 2];
      } else {
        index = questionNumbers[questionNumbers.length - 3];
      }
    }

    print(allQuestions[index].quizTitle);
    return allQuestions[index];
  }
}
