import 'package:http/http.dart' as http;
import 'package:soru_makinesi/models/lecture.dart';

class LectureApi{

  //static String base_url = "http://10.0.3.2/PSWS"; // localhost
  static String base_url = "https://berkayismus.site/soru_makinesi"; // remote server

  static Future getLectures() async {
    var response = await http.get("$base_url/lecture/all");
    return response;
  }

  static Future lectureAdd(String lecture_name,String lecture_code) async {
    Map data = {
      "lecture_name":lecture_name,
      "lecture_code":lecture_code,
    };
    var response = await http.post("$base_url/lecture/add/index.php",body: data);
    if(response.statusCode == 200) {
      return response;
    } else{
      throw("Ders Eklerken hata");
    }
  }

  static Future lectureUpdate(Lecture selectedLecture,String newLectureName,String newLectureCode) async {
    Map data = {
      "lecture_id":selectedLecture.lecture_id,
      "lecture_name":newLectureName,
      "lecture_code":newLectureCode,
    };
    var response = await http.post("$base_url/lecture/update/index.php",body: data);
    if(response.statusCode == 200) {
      return response;
    } else{
      throw("Ders Güncellenirken hata");
    }
  }

  static Future lectureDelete(Lecture selectedLecture) async {
    http://localhost/lecture/delete/?lecture_id=1
    var response = await http.get("$base_url/lecture/delete/?lecture_id=${selectedLecture.lecture_id}");
    if(response.statusCode == 200){
      return response;
    } else{
      throw("Ders silinirken hata");
    }
  }

}