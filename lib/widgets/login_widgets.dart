import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/user_api.dart';
import 'package:soru_makinesi/models/user.dart';

class LoginWidgets extends StatefulWidget {
  @override
  _LoginWidgetsState createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<LoginWidgets> {
  // controllers
  TextEditingController _usernameController;
  TextEditingController _passwordController;
  String message = "";




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          // birinci satır
          buildUserNameField(),
          // aralarda boşluk kalsın diye sizedbox yerleştirelim
          SizedBox(
            height: 10,
            width: 100,
          ),
          // ikinci satır
          buildPasswordField(),
          SizedBox(
            height: 10,
            width: 100,
          ),
          // üçüncü satır
          buildButtons(),
          SizedBox(
            height: 10,
          ),
          Text(message),
          SizedBox(height: 10,),

        ],
      ),
    );
  }

  Widget buildUserNameField() {
    // birinci satır
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _usernameController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Kullanıcı Adı',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPasswordField() {
    // ikinci satır
    return Row(
      children: <Widget>[
        // ikinci satır
        Expanded(
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Parola",
            ),
          ),
        )
      ],
    );
  }

  Widget buildButtons() {
    // üçüncü satır
    return Row(
      children: <Widget>[
        // loginButton
        FlatButton(
          onPressed: () {
            _userLogin();
          },
          child: Text("Giriş Yap"),
          color: Colors.green.shade800,
          textColor: Colors.white,
        ),
        // boşluk verebilmek için sizedbox
        SizedBox(
          width: 10,
        ),
        // registerButton
        FlatButton(
          onPressed: () {
            _goToUserRegister();
          },
          child: Text("Kayıt Ol"),
          color: Colors.pink,
          textColor: Colors.white,
        ),
        SizedBox(
          width: 9,
        ),
        FlatButton(
          onPressed: () {
            _goToUserForgotPassword();
          },
          child: Text("Şifremi Unuttum"),
          color: Colors.purpleAccent.shade700,
          textColor: Colors.white,
        ),

      ],
    );
  }



  void _userLogin() async {
   //debugPrint("Giriş yapa basıldı");
    var user = User.withLogin(_usernameController.text,_passwordController.text);
   var response = await UserApi.userLogin(user);
   // response map formatında json döndürüyor - response["message"] && response["tf"] gibi
    // mesajı yazdıralım
     setState(() {
       message = response["message"];
       if(response["tf"] == true) {
         Navigator.pop(context);
         Navigator.pushNamed(context, "/question");
       }
        else{
          // bilgiler yanlışsa yönlendirme yapma
       }
     });
  }

  void _goToUserRegister() {
    Navigator.pushNamed(context, "/register");
  }

  void _goToUserForgotPassword() {
    debugPrint("Şifremi unuttuma basıldı");
  }






} // class sonu
