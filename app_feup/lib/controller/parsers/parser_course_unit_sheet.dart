import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:uni/model/entities/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';

import '../../model/entities/course_unit.dart';

Future<CourseUnitSheet> parseCourseUnitSheet(
    CourseUnit courseUnit, http.Response sheetPageResponse) async {
  final document = parse(sheetPageResponse.body);

  String goals;
  String program;
  List<CourseUnitTeacher> teachers = [];
  List<CourseUnitEvaluationComponent> evaluationComponents;

  final titles = document.querySelectorAll('#conteudoinner h3');

  for (int i = 0; i < titles.length; i++) {
    final title = titles[i];
    final description = title.nextElementSibling.text;
    switch (title.text) {
      case 'Docência - Horas':
        teachers = [CourseUnitTeacher('JAS', true, '4')];
        break;
      case 'Objetivos':
        goals = description;
        break;
      case 'Programa':
        program = description;
        break;
      case 'Componentes de Avaliação':
        evaluationComponents = [CourseUnitEvaluationComponent('ola', '20')];
        break;
      default:
        break;
    }
  }

  return CourseUnitSheet(courseUnit.name, goals, program, evaluationComponents,
      teachers, courseUnit.status == 'V');
}
