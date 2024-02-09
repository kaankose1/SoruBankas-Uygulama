import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_add_widgets.dart';

class QuestionAddScreen extends StatefulWidget {
  @override
  _QuestionAddScreenState createState() => _QuestionAddScreenState();
}

class _QuestionAddScreenState extends State<QuestionAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Ekleme Sayfası"),
      ),
      body: QuestionAddWidgets(),
    );
  }
}
