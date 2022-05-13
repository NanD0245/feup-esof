import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_unit_class.dart';
import 'package:uni/model/entities/course_unit_classes.dart';
import 'package:uni/model/entities/course_unit_student.dart';
import 'package:uni/view/Widgets/course_units/course_unit_class_card.dart';

class CourseUnitsClassesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsClassesViewState();
}

class _CourseUnitsClassesViewState extends State<StatefulWidget> {
  List<CourseUnitClasses> activeCourses = [
    CourseUnitClasses('Laboratório de Computadores', [
      CourseUnitClass('2LEIC01', [
        CourseUnitStudent('Fernando Luis Santos Rego', 'up201905951',
            'up201905951@edu.fe.up.pt'),
        CourseUnitStudent('Bruno Mendes', 'upgay', 'upgay@edu.fe.up.pt')
      ]),
      CourseUnitClass('2LEIC02', [
        CourseUnitStudent(
            'Olá pessoa', 'up201902351', 'up201902351@edu.fe.up.pt')
      ]),
    ]),
    CourseUnitClasses('Compiladores', [
      CourseUnitClass('2LEIC01', [
        CourseUnitStudent('Fernando Luis Santos Rego', 'up201905951',
            'up201905951@edu.fe.up.pt'),
        CourseUnitStudent('Bruno Mendes', 'upgay', 'upgay@edu.fe.up.pt')
      ]),
    ])
  ];
  List<CourseUnitClasses> pastCourses = [
    CourseUnitClasses('Progamação Funcional e Lógica', [
      CourseUnitClass('3LEIC04', [
        CourseUnitStudent('David Preda', 'upghost', 'upghost@edu.fe.up.pt'),
        CourseUnitStudent('Bruno Mendes', 'upgay', 'upgay@edu.fe.up.pt')
      ]),
      CourseUnitClass('3LEIC07', [
        CourseUnitStudent('Fernando Luis Santos Rego', 'up201905951',
            'up201905951@edu.fe.up.pt')
      ]),
    ])
  ];
  List<Widget> activeCourseCards = [];
  List<Widget> pastCourseCards = [];
  @override
  Widget build(BuildContext context) {
    activeCourses.forEach((course) {
      activeCourseCards.add(CourseUnitClassCard(course));
    });
    pastCourses.forEach((course) {
      pastCourseCards.add(CourseUnitClassCard(course));
    });
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
