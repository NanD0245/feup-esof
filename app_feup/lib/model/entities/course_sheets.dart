import 'package:uni/model/entities/course_evaluation_component.dart';
import 'package:uni/model/entities/course_teacher.dart';

class CourseSheet {
  // expand upon this
  String courseName;
  String goals;
  List<CourseTeacher> teachers;
  List<CourseEvaluationComponent> evaluationComponents;

  CourseSheet(
      this.courseName, this.goals, this.evaluationComponents, this.teachers);

  List<CourseTeacher> getTeachers(bool theorical) {
    final List<CourseTeacher> t = [];
    for (CourseTeacher teacher in teachers) {
      if (teacher.lectureTheoretical == theorical) t.add(teacher);
    }
    return t;
  }
}
