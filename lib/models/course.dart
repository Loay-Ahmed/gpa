class Course {
  String name = "";
  String grade = "";
  int hours = 0;

  Course({this.name = "", required this.grade, required this.hours});

  Course.fromJSON({required Map<String, dynamic> json}) {
    name = json['name'];
    grade = json['grade'];
    hours = json['hours'];
  }

  Map<String, dynamic> courseToJSON() {
    return {
      "name": name,
      "grade": grade,
      "hours": hours,
    };
  }
}
