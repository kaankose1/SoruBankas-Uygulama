import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/data/api/question_api.dart';
import 'package:soru_makinesi/models/lecture.dart';
import 'package:soru_makinesi/models/question.dart';

class QuestionUpdateWidgets extends StatefulWidget {
  @override
  _QuestionUpdateWidgetsState createState() => _QuestionUpdateWidgetsState();
}

class _QuestionUpdateWidgetsState extends State<QuestionUpdateWidgets> {


  // ddMenu Lecture
  List<Lecture> _lectures = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // consts
  final double sizedBoxHeightSpace = 10.0;
  final double sizedBoxWithSpace = 20.0;

  // ddMenu Question
  List<Question> _questionAllList = List<Question>();
  List<DropdownMenuItem<Question>> _questionItems = List<DropdownMenuItem<Question>>();
  Question _selectedQuestion;
  bool _questionsMenuState = false;

  // controllers
  TextEditingController _questionQuestionController;
  TextEditingController _questionAnswersController;
  TextEditingController _questionValidateAnswerController;
  String _updatedMessage = "";

  @override
  void initState() {
    super.initState();
    getLecturesFromApi();
    _questionQuestionController = TextEditingController();
    _questionAnswersController = TextEditingController();
    _questionValidateAnswerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
         _questionsMenuState == true ? buildSecondRowWidget() : Container(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildThirthRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildFourthWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildFifthWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildSixthRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildSeventhRowWidget(),


        ],
      ),
    );
  }

  buildFirstRowWidget() {
    return Row(
      children: <Widget>[
    Container(
      width: 100,
    child: Text("Hangi Ders",style: customTextStyle(),),
    ),
        SizedBox(width: sizedBoxWithSpace,),

        DropdownButton(
          value: _selectedLecture,
          items: _lectureItems,
          onChanged: (Lecture selected)=> onChangedLecture(selected),
        ),
      ],
    );
  }

  void getLecturesFromApi() {
    LectureApi.getLectures().then((response) {
      setState(() {
        Iterable lectureList = jsonDecode(response.body);
        this._lectures = lectureList.map((lecture) => Lecture.fromJson(lecture)).toList();
        _selectedLecture = _lectures[0];
        getLectureWidgets();
      });
    });
  }

  List<DropdownMenuItem<Lecture>> getLectureWidgets() {
    for(Lecture lecture in _lectures){
      _lectureItems.add(getLectureWidget(lecture));
    }
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
      // soruları çekmeden önce daha önceki itemları temizleyelim
      _questionItems.clear();
      _questionsMenuState = true;
    });
    _getQuestionsFromApi(_selectedLecture);
  }

  void _getQuestionsFromApi(Lecture selectedLecture) {
      QuestionApi.getQuestionsAll(selectedLecture).then((response) {
        setState(() {
          Iterable questionList = jsonDecode(response.body);
          //debugPrint(questionList.toString());
          this._questionAllList = questionList.map((question) => Question.fromJson(question)).toList();
        this._selectedQuestion = _questionAllList[0];
        getQuestionWidgets();
        });
      });
  }

  customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }

  buildSecondRowWidget() {
    return Row(
      children: <Widget>[
          Text("Hangi Soru",style: customTextStyle(),),
          SizedBox(width: sizedBoxWithSpace,),

          DropdownButton(
            items: _questionItems,
            value: _selectedQuestion,
            onChanged: (Question selected)=>onChangedQuestion(selected),
          ),


      ],
    );
  }

  List<DropdownMenuItem<Question>> getQuestionWidgets() {
    for(Question question in _questionAllList){
      _questionItems.add(getQuestionWidget(question));
    }
    return _questionItems;
  }

  DropdownMenuItem<Question> getQuestionWidget(Question question) {
    return DropdownMenuItem(
      child: Text(question.question_question),
      value: question,
    );
  }

  onChangedQuestion(Question selected) {
    setState(() {
      _selectedQuestion = selected;
    });
  }

  buildThirthRowWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionQuestionController,
            decoration: InputDecoration(
              labelText: "Soru",
              hintText: "Yeni soruyu girin",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  buildFourthWidget(){
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionAnswersController,
            decoration: InputDecoration(
              labelText: "Cevaplar",
              hintText: "Cevapları virgülle ayırın",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  buildFifthWidget(){
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionValidateAnswerController,
            decoration: InputDecoration(
              labelText: "Cevap",
              hintText: "Doğru cevapı girin",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  buildSixthRowWidget(){
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text("Kaydet"),
          onPressed: _updateClicked,
          color: Colors.pink,
          textColor: Colors.white,
        ),
      ],
    );
  }

  _updateClicked() {
    QuestionApi.updateQuestion(_selectedLecture, _selectedQuestion, _questionQuestionController.text, _questionAnswersController.text, _questionValidateAnswerController.text)
        .then((response) {
          setState(() {
            var message = jsonDecode(response.body);
            _updatedMessage = message["message"];
          });
    });
  }

  buildSeventhRowWidget() {
    return Row(
      children: <Widget>[
        Text(_updatedMessage,style: customTextStyle(),),
      ],
    );
  }
}
