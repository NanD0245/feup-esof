import 'package:flutter/material.dart';

class CourseUnitsClassesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsClassesViewState();
}

class _CourseUnitsClassesViewState extends State<StatefulWidget> {
  List<Widget> activeCourseCards = [];
  List<Widget> pastCourseCards = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
      Container(
          padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
          child: Text(
            'Por concluir',
            textScaleFactor: 0.8,
          )),
    ]
          ..addAll(activeCourseCards)
          ..addAll([
            Container(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
                child: Text(
                  'Concluídas',
                  textScaleFactor: 0.8,
                )),
          ])
          ..addAll(pastCourseCards)
          ..addAll([
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
            )
          ]));
  }
}
