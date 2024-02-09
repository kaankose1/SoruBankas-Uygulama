import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/user_api.dart';
import 'package:soru_makinesi/screens/lecture_screen.dart';
import 'package:soru_makinesi/screens/lecture_update_screen.dart';
import 'package:soru_makinesi/screens/login_screen.dart';
import 'package:soru_makinesi/screens/question_add_screen.dart';
import 'package:soru_makinesi/screens/question_delete_screen.dart';
import 'package:soru_makinesi/screens/question_screen.dart';
import 'package:soru_makinesi/screens/question_update_screen.dart';
import 'package:soru_makinesi/screens/register_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // BU CLASSTA SADECE MATERİALAPP TANIMLANACAK

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Soru Makinesi",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => LoginScreen(),
        '/question' : (context) => QuestionScreen(),
        "/register" : (context) => RegisterScreen(),
        "/questionAdd": (context) => QuestionAddScreen(),
        "/questionUpdate": (context) => QuestionUpdateScreen(),
        "/questionDelete": (context) => QuestionDeleteScreen(),
        "/lecture": (context) => LectureScreen(),
        "/lectureUpdate": (context) => LectureUpdateScreen(),
      },
    );
  }


}


