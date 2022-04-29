import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_evaluation_component.dart';
import 'package:uni/model/entities/course_sheets.dart';
import 'package:uni/model/entities/course_teacher.dart';

import 'course_sheet_card.dart';

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
          '''INTRODUÇÃO: desafios do desenvolvimento de software em larga escala; objetivos e âmbito da engenharia de software; história da engenharia de software.\nPROCESSO DE SOFTWARE: noção de processo de software; atividades do processo; modelos de processos; exemplos de processos (RUP, XP, Scrum, etc.).\nGESTÃO DE PROJETOS DE SOFTWARE: planeamento, monitorização e controlo de projeto; estimação de software; gestão ágil e gestão clássica de projetos.\nREQUISITOS DE SOFTWARE: conceito de requisito de software; tipos de requisitos; identificação, análise, especificação e validação de requisitos; modelação de requisitos com UML; prototipagem de interfaces.\nDESENHO DE SOFTWARE: desenho de arquitetura; modelação de arquitetura com UML; reutilização de software; desenho detalhado.\nCONSTRUÇÃO E EVOLUÇÂO DE SOFTWARE: ambientes de desenvolvimento; integração contínua; gestão de versões e alterações; desenvolvimento ágil com XP; evolução e manutenção de software.\nVERIFICAÇÃO E VALIDAÇÃO DE SOFTWARE: conceitos básicos; testes unitários, de integração, de sistema e de aceitação; revisões e inspeções de software; registo de defeitos; análise estática de código.''',
          this._esofComponents,
          this._esofTeachers,
          true),
      CourseSheet(
          'Artificial Intelligence',
          'Solve problems with optimization and machine learning.',
          '',
          [],
          [],
          true),
      CourseSheet('Parallel and Distributed Computing',
          'Build parallel and distributed systems.', '', [], [], false),
      CourseSheet(
          'Compilers',
          'An holistic class on compiler assembling and analysis.',
          '',
          [],
          [],
          true),
      CourseSheet(
          'Capstone Project', 'An aggregation project.', '', [], [], false)
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> activeCourseCards = [];
    final List<Widget> pastCourseCards = [];
    _courses.forEach((courseSheet) {
      if (courseSheet.active) {
        activeCourseCards.add(CourseSheetCard(courseSheet));
      } else {
        pastCourseCards.add(CourseSheetCard(courseSheet));
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
