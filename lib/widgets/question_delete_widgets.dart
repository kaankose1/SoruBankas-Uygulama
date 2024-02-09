import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/data/api/question_api.dart';
import 'package:soru_makinesi/models/lecture.dart';
import 'package:soru_makinesi/models/question.dart';

class QuestionDeleteWidgets extends StatefulWidget {
  @override
  _QuestionDeleteWidgetsState createState() => _QuestionDeleteWidgetsState();
}

class _QuestionDeleteWidgetsState extends State<QuestionDeleteWidgets> {

  // consts
  double sizedBoxWidthSpace = 20;
  double sizedBoxHeightSpace = 5;

  // states
  bool _questionMenuState = false;
  bool _deleteButtonState = false;

  // lectures
  List<Lecture> _lectureList = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<
      DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // questions
  List<Question> _questionList = List<Question>();
  List<DropdownMenuItem<Question>> _questionItems = List<
      DropdownMenuItem<Question>>();
  Question _selectedQuestion;

  // messages
  String _deletedMessage = "";

  @override
  void initState() {
    super.initState();
    // lecture init
    getLecturesFromApi();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          buildFirstRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          _questionMenuState == true ? buildSecondRowWidget() : Container(),
          SizedBox(height: sizedBoxHeightSpace,),
          _deleteButtonState == true ? buildThirthRowWidget() : Container(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildFourthRowWidget(),
        ],
      ),
    );
  }

  buildFirstRowWidget() {
    return Row(
      children: <Widget>[
        Text("Hangi Ders",style: customTextStyle(),),
        SizedBox(width: sizedBoxWidthSpace,),
        buildLectureDropdown(),
      ],
    );
  }

  buildLectureDropdown() {
    return DropdownButton(
      items: _lectureItems,
      value: _selectedLecture,
      onChanged: (Lecture selected) => onChangedLecture(selected),
    );
  }

  void getLecturesFromApi() {
    LectureApi.getLectures().then((response) {
      setState(() {
        Iterable lectureList = jsonDecode(response.body);
        this._lectureList = lectureList.map((lecture) => Lecture.fromJson(lecture)).toList();
        _selectedLecture = _lectureList[0];
        getLectureWidgets();
      });
    });
  }

  List<DropdownMenuItem<Lecture>> getLectureWidgets() {
    for(Lecture lecture in _lectureList){
      _lectureItems.add(getLectureWidget(lecture));
    }
    return _lectureItems;
  }

  DropdownMenuItem<Lecture> getLectureWidget(Lecture lecture) {
    return DropdownMenuItem(
      child: Text(lecture.lecture_name),
      value: lecture,
    );
  }

  onChangedLecture(Lecture selected) {
    setState(() {
      _selectedLecture = selected;
      _questionItems.clear();
      getQuestionsFromApi();
      _questionMenuState = true;
    });
  }

  customTextStyle(){
   return TextStyle(
     color: Colors.pink,
     fontWeight: FontWeight.bold,
     fontSize: 20.0,
   );
  }


  void getQuestionsFromApi() {
    QuestionApi.getQuestionsAll(_selectedLecture).then((response) {
     setState(() {
       Iterable questionList = jsonDecode(response.body);
       this._questionList = questionList.map((question) => Question.fromJson(question)).toList();
       _selectedQuestion = _questionList[0];
       getQuestionWidgets();
     });
    });
  }

  DropdownMenuItem<Question> getQuestionWidgets() {
    for(Question question in _questionList){
      _questionItems.add(getQuestionWidget(question));
    }
  }

  DropdownMenuItem<Question> getQuestionWidget(Question question) {
    return DropdownMenuItem(
      value: question,
      child: Text(question.question_question),
    );
  }

  buildQuestionDropdown(){
    return DropdownButton(
      items: _questionItems,
      value: _selectedQuestion,
      onChanged: (Question selected) => onChangedQuestion(selected),
    );
  }

  onChangedQuestion(Question selected) {
    setState(() {
      _selectedQuestion = selected;
      _deleteButtonState = true;
    });
  }

  buildSecondRowWidget() {
    return Row(
      children: <Widget>[
        Text("Hangi Soru",style: customTextStyle(),),
        SizedBox(width: sizedBoxWidthSpace,),
        buildQuestionDropdown(),
      ],
    );
  }

  buildThirthRowWidget() {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text("Sil"),
          color: Colors.pink,
          textColor: Colors.white,
          onPressed: _deleteQuestionClicked,
        )
      ],
    );
  }



  void _deleteQuestionClicked() {
    QuestionApi.deleteQuestion(_selectedQuestion.question_id).then((response) {
      setState(() {
        var message = jsonDecode(response.body);
        _deletedMessage = message["message"];
      });
    });
  }

  buildFourthRowWidget() {
    return Row(
      children: <Widget>[
        Text(_deletedMessage),
      ],
    );
  }
}







