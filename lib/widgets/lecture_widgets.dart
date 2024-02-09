import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/lecture_api.dart';

class LectureWidgets extends StatefulWidget {
  @override
  _LectureWidgetsState createState() => _LectureWidgetsState();
}

class _LectureWidgetsState extends State<LectureWidgets> {

  // controllers
  TextEditingController _lectureNameController;
  TextEditingController _lectureCodeController;

  // messages
  String _lectureAddMessage = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          buildThirtRowWidget(),
          buildFourthRowWidget(),
        ],
      ),
    );
  }

  buildFirstRowWidget() {
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

  buildSecondRowWidget() {
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

  buildThirtRowWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Text("Ekle"),
            color: Colors.pink,
            textColor: Colors.white,
            onPressed: _lectureAddClicked,
          ),
        ],
      ),
    );
  }

  buildFourthRowWidget(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text(_lectureAddMessage,style: customTextStyle(),),
        ],
      ),
    );
  }

  bool _textFieldControl(){
    if(_lectureNameController.text!="" && _lectureCodeController!=""){
      return true;
    }else{
      return false;
    }
  }

  void _lectureAddClicked() {
    //debugPrint("Ders Ekleme butonuna basıldı");
    if(_textFieldControl()){
      LectureApi.lectureAdd(_lectureNameController.text, _lectureCodeController.text).then((response) {
         setState(() {
           var message = jsonDecode(response.body);
           _lectureAddMessage = message["message"];
         });
      });
    }
  }

  customTextStyle() {
    return TextStyle(
      color: Colors.pink,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }
}
