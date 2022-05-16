import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:uni/model/entities/course_units/course_unit_class.dart';
import 'package:uni/model/entities/course_units/course_unit_student.dart';

import '../../model/entities/course_units/course_unit.dart';
import '../../model/entities/course_units/course_unit_classes.dart';

Future<CourseUnitClasses> parseCourseUnitClasses(
    CourseUnit courseUnit, http.Response classesPageResponse) async {
  final document = parse(classesPageResponse.body);
  final List<CourseUnitClass> classes = [];

  final titles = document.querySelectorAll('#conteudoinner h3').sublist(1);
  for (final title in titles) {
    final className = title.innerHtml.substring(
        title.innerHtml.indexOf(' ') + 1, title.innerHtml.indexOf('&'));
    final table = title.nextElementSibling;
    final studentRows = table.querySelectorAll('tr').sublist(1);
    final List<CourseUnitStudent> students = [];
    for (final row in studentRows) {
      final columns = row.querySelectorAll('td.k.t');
      final studentName = columns[0].children[0].innerHtml;
      final studentNumber = 'up' + columns[1].innerHtml;
      final studentMail = columns[2].innerHtml;
      students.add(CourseUnitStudent(studentName, studentNumber, studentMail));
    }
    classes.add(CourseUnitClass(className, students));
  }

  return CourseUnitClasses(courseUnit.name, classes, courseUnit.result != 'A');
}
