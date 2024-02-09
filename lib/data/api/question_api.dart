import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soru_makinesi/models/lecture.dart';
import 'package:soru_makinesi/models/question.dart';

class QuestionApi{

  //static String base_url = "http://10.0.3.2/PSWS"; // localhost
  static String base_url = "https://berkayismus.site/soru_makinesi"; // remote server

  static Future getQuestions(String lecture_id,String question_limit) async {
    var response = await http.get("$base_url/question/all/?lecture_id=$lecture_id&limit=$question_limit");
    return response;
  }

  static Future getQuestionsAll(Lecture lecture) async {
    String lecture_id = lecture.lecture_id;
    var response = await http.get("$base_url/question/all/all.php?lecture_id=$lecture_id");
    if(response.statusCode==200){
      if(response!=null){
        return response;
      }
      return null;
    } else{
      throw("İstek atılırken hata");
    }
  }

  // rastgele soru çekme
  static Future randQuestions(Lecture lecture,String question_limit) async {
    String lecture_id = lecture.lecture_id;
    var response = await http.get("$base_url/question/all/random.php?lecture_id=$lecture_id&limit=$question_limit");
    if(response.statusCode==200){
      return response;
    } else{
      throw("Rastgele soru getirirken hata");
    }
  }

  static Future addQuestion(String question_question,String answers,String validate_answer,Lecture lecture) async {
    var data = {
      "question_question":question_question,
      "question_answers":answers,
      "question_validate_answer":validate_answer,
      "lecture_id":lecture.lecture_id,
    };
    var response = await http.post("$base_url/question/add/index.php",body: data);
    if(response.statusCode == 200){
      return response;
    } else{
      throw("İstek yapılırken hata");
    }
  }

  static Future updateQuestion(Lecture lecture,Question oldQuestion,String newQuestion,String newAnswers,String newValidateAnswer) async {
    Map data = {
      "lecture_id":lecture.lecture_id,
      "question_id":oldQuestion.question_id,
      "question_question":newQuestion,
      "question_answers":newAnswers,
      "question_validate_answer":newValidateAnswer,
    };
    var response = await http.post(
      "$base_url/question/update/index.php",
      body: data,
    );
    if(response.statusCode==200){
      return response;
    }else{
      throw("İstek yapılırken hata");
    }
  }
  
  static Future deleteQuestion(String question_id) async {
    var response = await http.get("$base_url/question/delete/index.php?question_id=$question_id");
    if(response.statusCode == 200){
      return response;
    } else{
      throw("İstek yapılırken hata");
    }
  }

}