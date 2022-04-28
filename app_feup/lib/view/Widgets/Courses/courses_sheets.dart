import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_evaluation_component.dart';
import 'package:uni/model/entities/course_sheets.dart';
import 'package:uni/model/entities/course_teacher.dart';

import 'course_card.dart';

class CoursesSheets extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CoursesSheetsState();
}

class _CoursesSheetsState extends State<StatefulWidget> {
  List<CourseTeacher> _esofTeachers;
  List<CourseEvaluationComponent> _esofComponents;
  List<CourseSheet> _courses;
  _CoursesSheetsState() {
    this._esofTeachers = [
      CourseTeacher('Ademar Manuel Teixeira de Aguiar', true, '3'),
      CourseTeacher('João Carlos Pascoal Faria', true, '3'),
      CourseTeacher('André Monteiro de Oliveira Restivo', false, '4'),
      CourseTeacher('Daniel Ribeiro de Pinho', false, '4'),
      CourseTeacher('José Carlos Medeiros de Campos', false, '8'),
      CourseTeacher('Bruno Miguel Carvalhido Lima', false, '4'),
      CourseTeacher('André Sousa Lago', false, '4'),
      CourseTeacher('João Carlos Pascoal Faria', false, '2'),
      CourseTeacher('Hugo José Sereno Lopes Ferreira	', false, '6'),
      CourseTeacher('Ademar Manuel Teixeira de Aguiar', false, '4'),
      CourseTeacher('Filipe Alexandre Pais de Figueiredo Correia', false, '4'),
    ];
    this._esofComponents = [
      CourseEvaluationComponent('Trabalho escrito', '25,00'),
      CourseEvaluationComponent('Trabalho prático ou de projeto	', '30,00'),
      CourseEvaluationComponent('Exame', '35,00'),
      CourseEvaluationComponent('Participação presencial', '10,00'),
    ];
    this._courses = [
      CourseSheet(
          'Software Engineering',
          'Familiarizar-se com os métodos de engenharia e gestão necessários ao desenvolvimento de sistemas de software complexos e/ou em larga escala, de forma economicamente eficaz e com elevada qualidade.',
          this._esofComponents,
          this._esofTeachers),
      CourseSheet('Artificial Intelligence',
          'Solve problems with optimization and machine learning.', [], []),
      CourseSheet('Parallel and Distributed Computing',
          'Build parallel and distributed systems.', [], []),
      CourseSheet('Compilers',
          'An holistic class on compiler assembling and analysis.', [], []),
      CourseSheet('Capstone Project', 'An aggregation project.', [], [])
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> courseCards = [];
    _courses.forEach((courseSheet) {
      courseCards.add(CourseCard(courseSheet));
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
}
