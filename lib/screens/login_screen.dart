import 'package:flutter/material.dart';
import 'package:soru_makinesi/widgets/login_widgets.dart';
import 'package:soru_makinesi/widgets/question_widgets.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Girişi"),
        actions: <Widget>[
          IconButton(iconSize: 24,icon: Icon(Icons.add),onPressed: (){},),
        ],
      ),
      body: LoginWidgets(),
    );
  }
}
