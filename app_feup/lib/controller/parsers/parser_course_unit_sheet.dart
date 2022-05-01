import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:uni/model/entities/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';

import '../../model/entities/course_unit.dart';

Future<CourseUnitSheet> parseCourseUnitSheet(
    CourseUnit courseUnit, http.Response sheetPageResponse) async {
  final document = parse(sheetPageResponse.body);

  String goals = '';
  String program = '';
  List<CourseUnitTeacher> teachers = [];
  List<CourseUnitEvaluationComponent> evaluationComponents;

  final titles = document.querySelectorAll('#conteudoinner h3');

  for (int i = 0; i < titles.length; i++) {
    final title = titles[i];
    switch (title.text) {
      case 'Docência - Horas':
        teachers = [CourseUnitTeacher('JAS', true, '4')];
        break;
      case 'Objetivos':
        goals = _parseGeneralDescription(title, titles);
        break;
      case 'Programa':
        program = _parseGeneralDescription(title, titles);
        break;
      case 'Componentes de Avaliação':
        evaluationComponents = _parseEvaluationComponents(title);
        break;
      default:
        break;
    }
  }

  return CourseUnitSheet(courseUnit.name, goals, program, evaluationComponents,
      teachers, courseUnit.result != 'A');
}

String _parseGeneralDescription(Element titleElement, List<Element> allTitles) {
  String description = '';
  var currElement = titleElement;
  for (;;) {
    currElement = currElement.nextElementSibling;
    if (currElement == null || allTitles.contains(currElement)) {
      break;
    }
    description += currElement.text + '\n\n';
  }
  return description;
}

List<CourseUnitEvaluationComponent> _parseEvaluationComponents(
    Element titleElement) {
  final List<CourseUnitEvaluationComponent> evaluationComponents = [];
  final table = titleElement.nextElementSibling;
  for (var row in table.querySelectorAll('tr.d')) {
    evaluationComponents.add(CourseUnitEvaluationComponent(
        row.children[0].text, row.children[1].text));
  }
  return evaluationComponents;
}
