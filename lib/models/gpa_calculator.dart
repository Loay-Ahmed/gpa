import 'dart:math';

import 'package:gpa/models/grades.dart';
import 'package:gpa/providers/course_provider.dart';

class GPACalculator {
  CourseProvider courseProvider;

  GPACalculator({required this.courseProvider});

  double calculate() {
    double totalCreditHours = 0;
    double totalGradePoints = 0;
    for (var course in courseProvider.courses) {
      if (course.grade == Grade.notSelected) {
        continue;
      }
      totalCreditHours += course.hours;
      totalGradePoints += course.grade.points * course.hours;
    }
    return totalGradePoints / max(1, totalCreditHours);
  }
}