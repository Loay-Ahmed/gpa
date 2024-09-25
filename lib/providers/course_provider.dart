import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:gpa/widgets/course_options.dart';

class CourseProvider extends ChangeNotifier {
  final List<CourseOptionsCard> courses = [];

  void addCourse(Course course, int index) {
    if (course.grade.isNotEmpty) {
      courses[index] = CourseOptionsCard(
        courseData: course,
        index: index,
      );
    }
  }
}
