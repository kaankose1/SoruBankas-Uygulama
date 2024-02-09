import 'package:flutter/material.dart';
import 'package:soru_makinesi/data/api/user_api.dart';
import 'package:soru_makinesi/models/user.dart';

class RegisterWidgets extends StatefulWidget {
  @override
  _RegisterWidgetsState createState() => _RegisterWidgetsState();
}

class _RegisterWidgetsState extends State<RegisterWidgets> {
  // controllers
  TextEditingController _usernameController;
  TextEditingController _lastnameController;
  TextEditingController _passwordController;
  TextEditingController _emailController;
  String message = "";




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameController = TextEditingController();
    _lastnameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          buildUserNameField(),
          SizedBox(
            height: 10,
            width: 100,
          ),

          buildUserLastNameField(),
          SizedBox(
            height: 10,
            width: 100,
          ),


          buildPasswordField(),
          SizedBox(
            height: 10,
            width: 100,
          ),

          buildUserEmailField(),
          SizedBox(
            height: 10,
            width: 100,
          ),



          buildButtons(),
          SizedBox(
            height: 10,
            width: 100,
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
              labelText: "Parolanız",
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

        // registerButton
        FlatButton(
          onPressed: () {
            _userRegister();
          },
          child: Text("Kayıt Ol"),
          color: Colors.pink,
          textColor: Colors.white,
        ),



      ],
    );
  }

  Widget buildUserLastNameField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _lastnameController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Soyadınız',
            ),
          ),
        ),
      ],
    );
  }

  Widget buildUserEmailField() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            controller: _emailController,
            obscureText: false,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Epostanız',
            ),
          ),
        ),
      ],
    );
  }

  void _userRegister() async {
    var user = User.withRegister(_usernameController.text, _lastnameController.text, _emailController.text, _passwordController.text);
    var response = await UserApi.userRegister(user);
    setState(() {
      message = response["message"];
    });
  }



}
