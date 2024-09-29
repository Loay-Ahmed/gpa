import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
import 'package:gpa/models/grades.dart';
import 'package:gpa/providers/course_provider.dart';
import 'package:provider/provider.dart';

class CourseOptionsCard extends StatefulWidget {
  const CourseOptionsCard({
    super.key,
    this.courseData,
    required this.index,
  });

  final Course? courseData;
  final int index;

  @override
  State<CourseOptionsCard> createState() => _CourseOptionsCardState();
}

class _CourseOptionsCardState extends State<CourseOptionsCard> {
  final controller = TextEditingController();

  // The list and the option chosen for the grade drop down
  Map<String, Grade> grades = {
    "A+": Grade.Ap,
    "A": Grade.A,
    "B+": Grade.Bp,
    "B": Grade.B,
    "C+": Grade.Cp,
    "C": Grade.C,
    "D+": Grade.Dp,
    "D": Grade.D,
    "F": Grade.F,
    "" : Grade.notSelected,
  };
  String? selectedGrade = "F";

  // The list and the option chosen for the hours drop down
  List<int> hours = [0, 1, 2, 3];
  String? selectedHours;

  void deleteCard(CourseProvider courseProvider) {
    courseProvider.deleteCourse(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.courseData?.name ?? "";
    selectedGrade = widget.courseData?.grade.name ?? Grade.notSelected.name;
    selectedHours = widget.courseData?.hours.toString() ?? "0";
    final courseProvider = Provider.of<CourseProvider>(context);
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
        color: Color(0xff0485cf),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 240,
                child: TextFormField(
                  controller: controller,
                  onChanged: (name) {
                    courseProvider.updateCourse(
                        Course(
                          name: name,
                          grade: widget.courseData?.grade ?? Grade.F,
                          hours: widget.courseData?.hours ?? 0,
                        ),
                        widget.index);
                  },
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  cursorColor: const Color.fromRGBO(255, 255, 255, 1),
                  decoration: const InputDecoration(
                    fillColor: Colors.black54,
                    focusedBorder: InputBorder.none,
                    hintText: "Course name",
                    border: InputBorder.none,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    deleteCard(courseProvider);
                  });
                },
                child: Container(
                  width: 50,
                  height: 40,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                    color: Colors.black87,
                  ),
                  child: const Icon(
                    Icons.delete,
                    applyTextScaling: true,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: selectedGrade ?? "",
                  hint: const Text('Grade'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGrade = newValue;
                      courseProvider.updateCourse(
                          Course(
                            grade: grades[selectedGrade ?? ""] ?? Grade.notSelected,
                            hours: widget.courseData?.hours ?? 0,
                          ),
                          widget.index);
                    });
                  },
                  items:
                      grades.keys.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: selectedHours,
                  hint: const Text('Hours'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedHours = newValue;
                      courseProvider.updateCourse(
                          Course(
                            grade: widget.courseData?.grade ?? Grade.notSelected,
                            hours: int.parse(selectedHours!),
                          ),
                          widget.index);
                    });
                  },
                  items: hours.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                      value: value.toString(),
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
