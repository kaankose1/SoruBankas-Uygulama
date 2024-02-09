import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/question_delete_widgets.dart';

class QuestionDeleteScreen extends StatefulWidget {
  @override
  _QuestionDeleteScreenState createState() => _QuestionDeleteScreenState();
}

class _QuestionDeleteScreenState extends State<QuestionDeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Silme Sayfası"),
      ),
      body: QuestionDeleteWidgets(),
    );
  }
}
