import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:gpa/providers/course_provider.dart';
import 'package:gpa/widgets/course_options.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void addCourseCard(CourseProvider courseProvider) {
    int index = courseProvider.courses.length;
    print(index);
    setState(() {
      courseProvider.courses.add(
        CourseOptionsCard(
          index: index,
        ),
      );
    });
  }

  void removeCourseCard(CourseProvider courseProvider, int index) {
    setState(
      () {
        courseProvider.courses.removeAt(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final courseProvider = Provider.of<CourseProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "GPA",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "3.29",
              style: TextStyle(fontSize: 30),
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
                    return courseProvider.courses[index];
                  }
                  return SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Course? last = courseProvider
                            .courses[courseProvider.courses.length - 1]
                            .courseData;
                        if (last != null &&
                            last.hours != 0 &&
                            last.grade != "") {
                          addCourseCard(courseProvider);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Fill all fields",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              backgroundColor: const Color(0xff191c20),
                              width: MediaQuery.sizeOf(context).width - 100,
                              elevation: 1,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 100,
                                vertical: 15,
                              ),
                            ),
                          );
                        }
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