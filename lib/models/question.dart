class Question{
  String question_id;
  String question_question;
  String question_answers;
  String question_validate_answer;
  String lecture_id;

  // constructor
  Question(this.question_id,this.question_question,this.question_answers,this.question_validate_answer,this.lecture_id);
  Question.fromJson(Map json){
    question_id = json["question_id"];
    question_question = json["question_question"];
    question_answers = json["question_answers"];
    question_validate_answer = json["question_validate_answer"];
    lecture_id = json["lecture_id"];
  }









}