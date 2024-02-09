import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_widgets.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  @override
  Widget build(BuildContext context) {

    final Color iconButtonColor = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Makinesi"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add),onPressed: _questionAddClicked ,color: iconButtonColor,),
          IconButton(icon: Icon(Icons.update),onPressed: _questionUpdateClicked, color: iconButtonColor,),
          IconButton(icon: Icon(Icons.delete),onPressed: _questionDeleteClicked, color: iconButtonColor,),
          IconButton(icon: Icon(Icons.airplay),onPressed: _goLectureClicked, color: iconButtonColor,),
          IconButton(icon: Icon(Icons.close),onPressed: _logOutClicked, color: iconButtonColor,),
        ],
      ),
      body: QuestionWidgets(),
    );
  }

  void _questionAddClicked() {
    Navigator.pushNamed(context, "/questionAdd");
  }

  void _questionUpdateClicked() {
    Navigator.pushNamed(context, "/questionUpdate");
  }

  void _questionDeleteClicked() {
    Navigator.pushNamed(context, "/questionDelete");
  }

  void _goLectureClicked() {
    Navigator.pushNamed(context, "/lecture");
  }

  void _logOutClicked() {
    Navigator.pop(context);
    Navigator.pushNamed(context,"/");
  }
}
