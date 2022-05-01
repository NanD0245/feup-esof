import 'package:uni/model/entities/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';

class CourseUnitSheet {
  // expand upon this
  String courseName;
  String goals;
  String program;
  bool active;
  List<CourseUnitTeacher> teachers;
  List<CourseUnitEvaluationComponent> evaluationComponents;

  CourseUnitSheet(this.courseName, this.goals, this.program,
      this.evaluationComponents, this.teachers, this.active);

  List<CourseUnitTeacher> getTeachers(bool theoretical) {
    final List<CourseUnitTeacher> t = [];
    for (CourseUnitTeacher teacher in teachers) {
      if (teacher.lecturesTheoretical == theoretical) t.add(teacher);
    }
    return t;
  }
}
