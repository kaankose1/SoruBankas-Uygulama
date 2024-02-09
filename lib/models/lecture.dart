class Lecture{
  String lecture_id;
  String lecture_name;
  String lecture_code;

  // constructor
  Lecture(this.lecture_id,this.lecture_name,this.lecture_code);
  Lecture.withNoId(this.lecture_name,this.lecture_code);
  Lecture.withEmpty();

  Lecture.fromJson(Map<String, dynamic> json) {
      lecture_id = json['lecture_id'];
      lecture_name = json['lecture_name'];
      lecture_code = json['lecture_code'];
  }

  }








