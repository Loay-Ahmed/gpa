import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:gpa/models/gpa_calculator.dart';
import 'package:gpa/models/grades.dart';
import 'package:gpa/providers/course_provider.dart';
import 'package:gpa/widgets/course_options.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> loadCourses(CourseProvider courseProvider) async {
    await courseProvider.readCourses();
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    loadCourses(courseProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "GPA",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              GPACalculator(courseProvider: courseProvider)
                  .calculate()
                  .toStringAsFixed(2),
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
        shape: const LinearBorder(
          side: BorderSide(width: 2, color: Colors.white),
          bottom: LinearBorderEdge(size: 0.65),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: courseProvider.courses.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < courseProvider.courses.length) {
                    return CourseOptionsCard(
                      index: index,
                      courseData: courseProvider.courses[index],
                    );
                  }
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        courseProvider.addCourse(Course(grade: Grade.notSelected, hours: 0));
                        CourseOptionsCard(
                          index: index,
                          courseData: courseProvider.courses.last,
                        );
                        setState((){});
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 35,
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index < courseProvider.courses.length) {
                    return const SizedBox(
                      height: 20,
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
