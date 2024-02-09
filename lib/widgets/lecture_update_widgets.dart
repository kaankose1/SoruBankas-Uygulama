import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';
import 'package:soru_makinesi/models/lecture.dart';

class LectureUpdateWidgets extends StatefulWidget {
  @override
  _LectureUpdateWidgetsState createState() => _LectureUpdateWidgetsState();
}

class _LectureUpdateWidgetsState extends State<LectureUpdateWidgets> {

  // consts
  double sizedBoxWithSpace = 20;
  double sizedBoxHeightSpace = 10;
  Color flatButtonColor = Colors.pink;
  Color flatButtonTextColor = Colors.white;

  // Lecture List
  List<Lecture> _lectureList = List<Lecture>();
  List<DropdownMenuItem<Lecture>> _lectureItems = List<DropdownMenuItem<Lecture>>();
  Lecture _selectedLecture;

  // controllers
  TextEditingController _lectureNameController;
  TextEditingController _lectureCodeController;

  // messages
  String _updateMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLecturesFromApi();
    _lectureNameController = TextEditingController();
    _lectureCodeController = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          buildFirstRowWidget(),
          buildSecondRowWidget(),
          buildThirthRowWidget(),
          buildFourthRowWidget(),
          buildFifthRowWidget(),
        ],
      ),
    );
  }

  buildFirstRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text("Hangi Ders",style: customTextStyle(),),
          SizedBox(width: sizedBoxWithSpace,),
          buildLectureDropdown(),
          SizedBox(width: sizedBoxWithSpace,),
         // buildDeleteButton(),
        ],
      ),
    );
  }

  buildSecondRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _lectureNameController,
              decoration: InputDecoration(
                labelText: "Ders Adı",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildThirthRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _lectureCodeController,
              decoration: InputDecoration(
                labelText: "Ders Kodu",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildFourthRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
            FlatButton(
              child: Text("Güncelle"),
              color: flatButtonColor,
              textColor: flatButtonTextColor,
              onPressed: _updateLectureClicked,
            ),
        ],
      ),
    );
  }

  buildFifthRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(_updateMessage,style: customTextStyle(),),
        ],
      ),
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
    });
    //debugPrint(_selectedLecture.lecture_name); // çalışıyor
  }

  customTextStyle() {
    return TextStyle(
      fontSize: 20.0,
      color: Colors.pink,
      fontWeight: FontWeight.bold,
    );
  }

  bool textFieldController(){
    if(_lectureNameController.text!="" && _lectureCodeController.text!=""){
      return true;
    }
    else{
      return false;
    }
  }

  void _updateLectureClicked() {
      if(textFieldController()){
        LectureApi.lectureUpdate(_selectedLecture,_lectureNameController.text,_lectureCodeController.text).then((response) {
          setState(() {
            Map messageMap = jsonDecode(response.body);
            _updateMessage = messageMap["message"];
          });
        });
      } else{
        setState(() {
          _updateMessage = "Alanlar boş geçilemez";
        });
      }
  }

  buildDeleteButton() {
    return FlatButton(
      child: Text("Sil"),
      color: flatButtonColor,
      textColor: flatButtonTextColor,
      onPressed: _deleteLectureClicked,
    );
  }

  void _deleteLectureClicked() {
      LectureApi.lectureDelete(_selectedLecture).then((response) {
        setState(() {
          var message = jsonDecode(response.body);
          _updateMessage = message["message"];
        });
      });
    }
}
