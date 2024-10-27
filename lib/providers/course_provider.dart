import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/grades.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> courses = [Course(grade: Grade.notSelected, hours: 0)];

  Future<void> addCourse(Course course) async {
    courses.add(course);
    await updatePreferences();
    notifyListeners();
  }

  Future<void> readCourses() async {
    final sharedPref = await SharedPreferences.getInstance();
    var jsonData =  sharedPref.getString('courses');
    var json = jsonDecode(jsonData ?? "{}") as Map<String, dynamic>;
    List<Course> sharedPrefData = [];

    for (Map<String, dynamic> item in json.values) {
      sharedPrefData.add(Course.fromJSON(json: item));
    }
    for (var item in sharedPrefData) {
      if (!courses.contains(item) || sharedPrefData.length != courses.length) {
        courses.clear();
        courses = sharedPrefData;
        notifyListeners();
        break;
      }
    }
    courses.forEach((item) => print(
          item.grade,
        ));
  }

  Future<void> updateCourse(Course course, int index) async {
    courses[index] = course;
    await updatePreferences();
    notifyListeners();
  }

  Future<void> deleteCourse(int index) async {
    courses.removeAt(index);
    await updatePreferences();
    notifyListeners();
  }

  Future<void> updatePreferences() async {
    final sharedPref = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {};
    for (int i = 0; i < courses.length; i++) {
      map['$i'] = courses[i].courseToJSON();
    }
    await sharedPref.setString('courses', jsonEncode(map));
  }
}
