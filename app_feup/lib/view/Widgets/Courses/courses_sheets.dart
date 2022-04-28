import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_sheets.dart';

import 'course_card.dart';

class CoursesSheets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoursesSheetsState();
}

class _CoursesSheetsState extends State<StatefulWidget> {
  final _courses = [
    CourseSheet(
        'Software Engineering', 'Learn software lifecycle and management.'),
    CourseSheet('Artificial Intelligence',
        'Solve problems with optimization and machine learning.'),
    CourseSheet('Parallel and Distributed Computing',
        'Build parallel and distributed systems.'),
    CourseSheet(
        'Compilers', 'An holistic class on compiler assembling and analysis.'),
    CourseSheet('Capstone Project', 'An aggregation project.')
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> courseCards = [];
    _courses.forEach((courseSheet) {
      courseCards
          .add(CourseCard(courseSheet.title, courseInfoWidget(courseSheet)));
    });
    return ListView(
        children: [
      Container(
          padding: EdgeInsets.fromLTRB(30, 20, 0, 0),
          child: Text(
            'Semestre atual',
            textScaleFactor: 0.8,
          ))
    ]..addAll(courseCards));
  }

  Widget courseInfoWidget(CourseSheet courseSheet) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(courseSheet.description)),
    );
  }
}
