enum QuestionCategory {Interest, Ability }
enum QuestionType {Text,Image }

class QuestionModel {
  QuestionModel({this.question, this.category, this.correctAnswer, this.incorrectAnswers});

  factory QuestionModel.fromJson(Map<String, dynamic> json)
    => QuestionModel(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: (json['incorrect_answers'] as List)
            .map((answer) => answer.toString())
            .toList(),
        category: json['category']
    );
  String question;
  String category;
  String correctAnswer;
  List<String> incorrectAnswers;
}

class Question {
  Question({this.question, this.category, this.answers, this.correctAnswerIndex});
  factory Question.fromQuestionModel(QuestionModel model) {
    final List<String> answers = []
      ..add(model.correctAnswer)
      ..addAll(model.incorrectAnswers)
      ..shuffle();

    final index = answers.indexOf(model.correctAnswer);

    return Question(
        question: model.question,
        category: model.category,
        answers: answers,
        correctAnswerIndex: index,
    );
  }

  String question;
  String category;
  List<String> answers;
  int correctAnswerIndex;
  int chosenAnswerIndex;

  bool isCorrect(String answer)
    => answers.indexOf(answer) == correctAnswerIndex;

  bool isChosen(String answer)
    => answers.indexOf(answer) == chosenAnswerIndex;
}
