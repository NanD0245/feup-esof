import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_description.dart';

import 'general_page_view.dart';

class CoursesPageView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CoursesPageViewState();
}

class CoursesPageViewState extends GeneralPageViewState {
  final _expanded = List.filled(5, false);
  final _courses = [
    CourseDescription(
        'Software Engineering', 'Learn software lifecycle and management.'),
    CourseDescription('Artificial Intelligence',
        'Solve problems with optimization and machine learning.'),
    CourseDescription('Parallel and Distributed Computing',
        'Build parallel and distributed systems.'),
    CourseDescription(
        'Compilers', 'An holistic class on compiler assembling and analysis.'),
    CourseDescription('Capstone Project', 'An aggregation project.')
  ];

  @override
  Widget getBody(BuildContext context) {
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
