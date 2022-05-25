import 'dart:collection';

import 'package:uni/model/entities/course_units/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_units/course_unit_teacher.dart';

class CourseUnitSheet {
  String courseName;
  String goals;
  String program;
  bool active;
  List<CourseUnitTeacher> teachers;
  List<CourseUnitEvaluationComponent> evaluationComponents;

  CourseUnitSheet(this.courseName, this.goals, this.program,
      this.evaluationComponents, this.teachers, this.active);

  SplayTreeMap<String, List<CourseUnitTeacher>> getTeachers() {
    final SplayTreeMap<String, List<CourseUnitTeacher>> map =
        SplayTreeMap<String, List<CourseUnitTeacher>>();
    for (CourseUnitTeacher teacher in teachers) {
      if (map.containsKey(teacher.lecturesType)) {
        map[teacher.lecturesType].add(teacher);
      } else {
        map[teacher.lecturesType] = [teacher];
      }
    }
    return map;
  }
}
