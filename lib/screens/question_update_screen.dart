import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_update_widgets.dart';

class QuestionUpdateScreen extends StatefulWidget {
  @override
  _QuestionUpdateScreenState createState() => _QuestionUpdateScreenState();
}

class _QuestionUpdateScreenState extends State<QuestionUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Güncelleme Sayfası"),
      ),
      body: QuestionUpdateWidgets(),
    );
  }
}
