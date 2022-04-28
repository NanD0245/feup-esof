import 'package:uni/model/entities/course_teacher.dart';

class CourseSheet {
  // expand upon this
  final List<String> section = [
    'Professores',
    'Objetivos',
    'Programa',
    'Avaliação'
  ];
  String courseName;
  String description;
  List<CourseTeacher> teachers;

  CourseSheet(this.courseName, this.description, this.teachers);

  List<CourseTeacher> getTeachers(bool theorical) {
    final List<CourseTeacher> t = [];
    for (CourseTeacher teacher in teachers) {
      if (teacher.lectureTheoretical == theorical) t.add(teacher);
    }
    return t;
  }
}
