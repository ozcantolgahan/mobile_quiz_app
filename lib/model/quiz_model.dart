class QuizModel {
  String quizId;
  String quizTitle;
  List quizOptions;
  int quizCorrectAnswer;
  String quizCategory;

  QuizModel(
      {this.quizId,
      this.quizTitle,
      this.quizOptions,
      this.quizCorrectAnswer,
      this.quizCategory});

  QuizModel.fromMap(Map<dynamic, dynamic> map) {
    this.quizId = map["quizId"];
    this.quizTitle = map["quizTitle"];
    this.quizOptions = map["quizOptions"];
    this.quizCorrectAnswer = map["quizCorrectAnswer"];
    this.quizCategory = map["quizCategory"];
  }
}
