import 'package:flutter/material.dart';
import 'package:gpa/models/course.dart';
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

  // final void Function(CourseProvider, int) homeDeleteFunction;

  @override
  State<CourseOptionsCard> createState() => _CourseOptionsCardState();
}

class _CourseOptionsCardState extends State<CourseOptionsCard> {
  final controller1 = TextEditingController();

  // The list and the option chosen for the grade drop down
  Map<String, double> grades = {
    'A+': 4,
    'A': 3.7,
    'B+': 3.3,
    'B': 3,
    'C+': 2.7,
    'C': 2.4,
    'D+': 2.2,
    'D': 2,
    'F': 0,
  };
  String? selectedGrade;

  // The list and the option chosen for the hours drop down
  List<int> hours = [0, 1, 2, 3];
  String? selectedHours;

  void deleteCard(CourseProvider courseProvider) {
    // widget.homeDeleteFunction(courseProvider, widget.index);
  }

  @override
  Widget build(BuildContext context) {
    controller1.text = widget.courseData != null ? widget.courseData!.name : "";
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
                  controller: controller1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  cursorColor: Colors.white,
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
                  deleteCard(courseProvider);
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
                  value: selectedGrade,
                  hint: const Text('Grade'),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGrade = newValue;
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
