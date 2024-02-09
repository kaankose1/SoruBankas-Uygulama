
class User {
  String user_id;
  String user_name;
  String user_lastname;
  String user_password;
  String user_email;
  String user_status;
  String user_validate_code;

  // constructor - 2 tane
  User(this.user_id,this.user_name,this.user_lastname,this.user_password,this.user_email,this.user_status,this.user_validate_code);
  User.withLogin(this.user_name,this.user_password);
  User.withRegister(this.user_name,this.user_lastname,this.user_email,this.user_password);

  // json to object convert
  User.fromJson(Map json){
    user_id = json["user_id"];
    user_name = json["user_name"];
    user_lastname = json["user_lastname"];
    user_password = json["user_password"];
    user_email = json["user_email"];
    user_status = json["status"];
    user_validate_code = json["user_validate_code"];
  }
}
