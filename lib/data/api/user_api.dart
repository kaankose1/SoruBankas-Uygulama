import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:soru_makinesi/models/user.dart';

class UserApi {
  //static String base_url = "http://10.0.3.2/PSWS"; // localhost
  static String base_url = "https://berkayismus.site/soru_makinesi"; // remote server


  // çalışıyor
  static Future getUsers() {
    return http.get("$base_url/user/all");
  }

  static Future userLogin(User user) async {
    Map data = {
      "user_name" : user.user_name,
      "user_password" : user.user_password,
    };
    var response = await http.post(base_url+"/user/login/index.php", body: data);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else{
      throw("İstek yapılırken hata");
    }
  }

  static Future userRegister(User user) async {
    Map data = {
      "user_name" : user.user_name,
      "user_lastname" : user.user_lastname,
      "user_email" : user.user_email,
      "user_password" : user.user_password,
    };
    var response = await http.post(base_url+"/user/register/index.php",body: data);
    if(response.statusCode == 200){
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else{
      throw("İstek yapılırken hata");
    }
  }



} // class sonu
