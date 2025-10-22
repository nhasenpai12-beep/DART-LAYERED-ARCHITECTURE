import 'package:uuid/uuid.dart';

class Question {
  final String id;
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int point;

  Question(
      {String? id,
      required this.title,
      required this.choices,
      required this.goodChoice,
      required this.point})
      : id = Uuid().v4();

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      choices: List<String>.from(json['choices'] as List<dynamic>),
      goodChoice: json['goodChoice'] as String,
      point: json['point'] as int,
    );
  }
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice.toLowerCase() == question.goodChoice.toLowerCase();
  }
}

class Quiz {
  final List<Question> questions;
  final List<Answer> answers = [];

  Quiz({required this.questions});

  void addAnswer(Answer answer) {
    this.answers.add(answer);
  }

  int getScoreInPercentage() {
    int totalSCore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalSCore++;
      }
    }
    return ((totalSCore / questions.length) * 100).toInt();
  }

  int getTotalPoint() {
    int totalPoint = 0;
    for (int i = 0; i < answers.length; i++) {
      if (answers[i].isGood()) {
        totalPoint += questions[i].point;
      }
    }
    return totalPoint;
  }
}
