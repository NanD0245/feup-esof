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
    final courseName = title.innerHtml.substring(
        title.innerHtml.indexOf(' ') + 1, title.innerHtml.indexOf('&'));
    final table = title.nextElementSibling;
    final studentRows = table.querySelectorAll('tr').sublist(1);
    List<CourseUnitStudent> students = [];
    for (var row in studentRows) {
      students.add(CourseUnitStudent('David', 'up', 'david@gmail.com'));
    }
    classes.add(CourseUnitClass(courseName, students));
  }

  return CourseUnitClasses(courseUnit.name, classes, courseUnit.result != 'A');
}
