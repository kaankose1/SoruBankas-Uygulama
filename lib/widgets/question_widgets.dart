import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/data/api/question_api.dart';
import 'package:soru_makinesi/models/lecture.dart';
import 'package:soru_makinesi/models/question.dart';

class QuestionWidgets extends StatefulWidget {
  @override
  _QuestionWidgetsState createState() => _QuestionWidgetsState();
}

class _QuestionWidgetsState extends State<QuestionWidgets> {
  // ddMenu
  List<Lecture> _lectures = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems =
      List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // consts
  final double sizedBoxSpaceWith = 10;
  final Color flatButtonTextColor = Colors.white;
  final Color flatButtonColor = Colors.pink;

  // Controllers
  TextEditingController _questionQuantityController;
  TextEditingController _questionsController;

  // Question lists
  List<Question> _questions = List<Question>();

  // Strings
  String _getQuestionTextsAll = "";

  // states
  bool _questionsFieldState = false;

  @override
  void initState() {
    super.initState();
    _questionQuantityController = TextEditingController();
    _questionsController = TextEditingController();
    getLecturesFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: buildMainColumnWidget(),
    );
  }

  buildMainColumnWidget() {
    return Column(
      children: <Widget>[
        buildFirstRowWidget(),
        buildSecondRowWidget(),
        buildThirthRowWidget(),
        _questionsFieldState == true ? builFourthRowWidget() : Container(),
      ],
    );
  }

  buildFirstRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            child: Text("Ders:", style: customTextStyle()),
          ),
          SizedBox(
            width: sizedBoxSpaceWith,
          ),
          builDropDownButton(),
        ],
      ),
    );
  }

  buildSecondRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 50,
            child: Text(
              "Soru Sayısı",
              style: customTextStyle(),
            ),
          ),
          SizedBox(
            width: sizedBoxSpaceWith,
          ),
          Container(
            width: 100,
            height: 50,
            child: TextField(
              controller: _questionQuantityController,
              decoration: InputDecoration(
                labelText: "Soru Adeti",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // butonlar
        ],
      ),
    );
  }

  buildThirthRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            child: Text(
              "Getir",
              style: customTextStyle(),
            ),
          ),
          SizedBox(
            width: sizedBoxSpaceWith,
          ),
          Container(
            height: 50,
            width: 100,
            child: FlatButton(
              child: Text("SIRALI"),
              onPressed: _getOrdinal,
              color: flatButtonColor,
              textColor: flatButtonTextColor,
            ),
          ),
          SizedBox(
            width: sizedBoxSpaceWith,
          ),
          Expanded(
            child: Container(
              height: 50,
              width: 100,
              child: FlatButton(
                child: Text("RASTGELE"),
                onPressed: getQuestionRandom,
                color: flatButtonColor,
                textColor: flatButtonTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _getQuestion() {
    // debugPrint("sıralı getire basıldı");
    if (_selectedLecture != null && _questionQuantityController.text != "") {
      // question getiren fonksiyon yazılacak
      QuestionApi.getQuestions(
              _selectedLecture.lecture_id, _questionQuantityController.text)
          .then((response) {
        setState(() {
          Iterable questionList = jsonDecode(response.body);
          this._questions = questionList
              .map((question) => Question.fromJson(question))
              .toList();
          _getQuestionTextsAll = _buildQuestionTexts();
          _questionsController.text = _getQuestionTextsAll;
          _questionsFieldState = true;
          _questionDialog();
        });
      });
    }
  }

  void getQuestionRandom() {
    // debugPrint("rastgele getire basıldı");
    QuestionApi.randQuestions(
            _selectedLecture, _questionQuantityController.text)
        .then((response) {
      setState(() {
        Iterable questionList = jsonDecode(response.body);
        this._questions = questionList
            .map((question) => Question.fromJson(question))
            .toList();
        _getQuestionTextsAll = _buildQuestionTexts();
        _questionsController.text = _getQuestionTextsAll;
        _questionsFieldState = true;
        _questionDialog();
      });
    });
  }

  void sendWithEmail() {
    debugPrint("eposta ile göndere basıldı");
  }

  customTextStyle() {
    return TextStyle(
      fontSize: 20,
      fontStyle: FontStyle.normal,
      color: Colors.red,
    );
  }

  Future<void> _questionDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sorular Getirildi'),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: <Widget>[
                Text('${_getQuestionTextsAll}'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Kapat'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _getOrdinal() {
    _getQuestion();
  }

  void getLecturesFromApi() {
    LectureApi.getLectures().then((response) {
      setState(() {
        Iterable lectureList = jsonDecode(response.body);
        this._lectures =
            lectureList.map((lecture) => Lecture.fromJson(lecture)).toList();
        _selectedLecture = _lectures[0];
        getLectureWidgets();
      });
    });
  }

  List<DropdownMenuItem<Lecture>> getLectureWidgets() {
    for (Lecture lecture in _lectures) {
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

  builDropDownButton() {
    return DropdownButton(
      items: _lectureItems,
      value: _selectedLecture,
      onChanged: (Lecture selected) => onChangedLecture(selected),
    );
  }

  onChangedLecture(Lecture selected) {
    setState(() {
      _selectedLecture = selected;
    });
  }

  void goLectures() {
    debugPrint("Dersler sayfasına git'e tıklandı");
  }

  String _buildQuestionTexts() {
    // _questions
    String buildedQuestionAllData = "";
    int i = 1;
    for (Question question in _questions) {
      buildedQuestionAllData += "Soru $i: " +
          question.question_question +
          "\n" +
          "Cevaplar $i: " +
          question.question_answers +
          "\n" +
          "Doğru Cevap $i: " +
          question.question_validate_answer +
          "\n\n";
      i++;
    }
    return buildedQuestionAllData;
  }

  builFourthRowWidget() {
    // _getQuestionTextsAll
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
          child: TextField(
            controller: _questionsController,
            maxLines: 10,
            decoration: InputDecoration(
              labelText: "Getirilen Sorular",
              border: OutlineInputBorder(),
            ),
      )),
    );
  }
} // class sonu
