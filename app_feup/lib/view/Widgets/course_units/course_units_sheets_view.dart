import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';

import 'course_unit_sheet_card.dart';

class CourseUnitsSheetsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsSheetsViewState();
}

class _CourseUnitsSheetsViewState extends State<StatefulWidget> {
  final List<CourseUnitSheet> _courses = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> activeCourseCards = [];
    final List<Widget> pastCourseCards = [];
    _courses.forEach((courseSheet) {
      if (courseSheet.active) {
        activeCourseCards.add(CourseUnitSheetCard(courseSheet));
      } else {
        pastCourseCards.add(CourseUnitSheetCard(courseSheet));
      }
    });
    return ListView(
        children: [
      Container(
          padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
          child: Text(
            'Semestre Atual',
            textScaleFactor: 0.8,
          )),
    ]
          ..addAll(activeCourseCards)
          ..addAll([
            Container(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
                child: Text(
                  'Semestres Anteriores',
                  textScaleFactor: 0.8,
                )),
          ])
          ..addAll(pastCourseCards));
  }
}
