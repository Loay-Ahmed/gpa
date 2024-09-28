import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CourseProvider extends ChangeNotifier {
  List<Course> courses = [];

  Future<void> addCourse(Course course) async {
    courses.add(course);
    await updatePreferences();
    notifyListeners();
  }

  Future<void> readCourses() async {
    // final prefs = await SharedPreferences.getInstance();
    // var data = await prefs.getString('alarms');
    // var decodedData = jsonDecode(data ?? "{}") as Map<String, dynamic>;
    // List<Alarm> alarmsPrefs = [];
    // for (Map<String, dynamic> alarmJson in decodedData.values) {
    //   alarmsPrefs.add(Alarm.fromJSON(alarmJson));
    // }
    // for (var item in alarms) {
    //   if (!alarmsPrefs.contains(item)) {
    //     alarms.clear();
    //     alarms = alarmsPrefs;
    //     notifyListeners();
    //     break;
    //   }
    // }
    final prefs = await SharedPreferences.getInstance();
    var jsonData =  prefs.getString('courses');
    var json = jsonDecode(jsonData ?? "{}") as Map<String, dynamic>;
    List<Course> prefsData = [];

    for (Map<String, dynamic> item in json.values) {
      prefsData.add(Course.fromJSON(json: item));
    }
    for (var item in prefsData) {
      if (!courses.contains(item) || prefsData.length != courses.length) {
        courses.clear();
        courses = prefsData;
        notifyListeners();
        break;
      }
    }
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
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {};
    for (int i = 0; i < courses.length; i++) {
      map['$i'] = courses[i].courseToJSON();
    }
    await prefs.setString('courses', jsonEncode(map));
  }
}
