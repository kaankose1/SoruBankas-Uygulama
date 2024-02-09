import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/lecture_update_widgets.dart';

class LectureUpdateScreen extends StatefulWidget {
  @override
  _LectureUpdateScreenState createState() => _LectureUpdateScreenState();
}

class _LectureUpdateScreenState extends State<LectureUpdateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Güncelleme Sayfası"),
      ),
      body: LectureUpdateWidgets(),
    );
  }
}
