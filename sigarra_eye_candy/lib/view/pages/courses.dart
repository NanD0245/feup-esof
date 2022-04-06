import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigarra_eye_candy/model/course.dart';

class CoursesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesPageState();
  }
}

class _CoursesPageState extends State<CoursesPage> {
  var _expanded = List.filled(5, false);
  final _courses = [
    Course("Software Engineering", "Learn software lifecycle and management."),
    Course("Artificial Intelligence",
        "Solve problems with optimization and machine learning."),
    Course("Parallel and Distributed Computing",
        "Build parallel and distributed systems."),
    Course(
        "Compilers", "An holistic class on compiler assembling and analysis."),
    Course("Capstone Project", "An aggregation project.")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ExpansionPanelList(
          animationDuration: Duration(milliseconds: 100),
          expansionCallback: (index, isExpanded) {
            setState(() {
              _expanded[index] = !_expanded[index];
            });
          },
          children: _courses
              .asMap()
              .entries
              .map((entry) => ExpansionPanel(
                  body: ListTile(title: Text(entry.value.description)),
                  isExpanded: _expanded[entry.key],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(title: Text(entry.value.title));
                  }))
              .toList())
    ]);
  }
}
