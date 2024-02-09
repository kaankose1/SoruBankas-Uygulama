import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/data/api/question_api.dart';
import 'package:soru_makinesi/models/lecture.dart';

class QuestionAddWidgets extends StatefulWidget {
  @override
  _QuestionAddWidgetsState createState() => _QuestionAddWidgetsState();
}

class _QuestionAddWidgetsState extends State<QuestionAddWidgets> {

  // consts
  final double sizedBoxHeightSpace = 10.0;

  // controllers
  TextEditingController _questionQuestionController;
  TextEditingController _questionAnswersController;
  TextEditingController _questionValidateAnswerController;
  
  // ddMenu
  List<Lecture> _lectures = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // messages
  String _questionMessage= "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _questionQuestionController = TextEditingController();
    _questionAnswersController = TextEditingController();
    _questionValidateAnswerController = TextEditingController();
    getLecturesFromApi();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[

          buildFirstRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildSecondRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildThirthRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          SizedBox(width: 120,),
          buildFourthRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildFifthRowWidget(),
          SizedBox(height: sizedBoxHeightSpace,),
          buildSixthRowWidget(),

        ],
      ),
    );
  }

  buildFirstRowWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionQuestionController,
            decoration: InputDecoration(
              labelText: "Soru",
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }

  buildSecondRowWidget() {
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
        )
      ],
    );
  }

  buildThirthRowWidget() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _questionValidateAnswerController,
            decoration: InputDecoration(
              labelText: "Doğru cevap",
              hintText: "Cevaplar arasından doğru olanı yazın",
              border: OutlineInputBorder(),
            ),
          ),
        )
      ],
    );
  }

  buildFourthRowWidget() {
    return Row(
      children: <Widget>[
        Text("Ders",style: customTextStyle(),),
        SizedBox(width: 20,),
        ddMenu(),
      ],
    );
  }

  buildFifthRowWidget(){
    return Align(
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Ekle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _addButtonClicked,
          ),
        ],
      ),
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
    return _lectureItems;
  }

  DropdownMenuItem<Lecture> getLectureWidget(Lecture lecture) {
    return DropdownMenuItem(
      child: Text(lecture.lecture_name),
      value: lecture,
    );
  }

  void onChangedLecture(Lecture selectedLecture) {
    setState(() {
      _selectedLecture = selectedLecture;
      debugPrint(_selectedLecture.lecture_name);
    });
  }

  Widget ddMenu(){
    return DropdownButton(
      items: _lectureItems,
      value: _selectedLecture,
      onChanged: (Lecture selectedLecture){onChangedLecture(selectedLecture);},
    );
  }

  customTextStyle() {
    return TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.pink,
    );
  }

  void _addButtonClicked() {
    QuestionApi.addQuestion(_questionQuestionController.text, _questionAnswersController.text, _questionValidateAnswerController.text, _selectedLecture)
        .then((response) {
          setState(() {
            var message = jsonDecode(response.body);
            _questionMessage = message["message"];
          });
    });
  }

  buildSixthRowWidget() {
    return Row(
      children: <Widget>[
        Text(_questionMessage ,style: customTextStyle(),),
      ],
    );
  }
}
