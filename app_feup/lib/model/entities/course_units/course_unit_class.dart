import 'package:uni/model/entities/course_units/course_unit_student.dart';

class CourseUnitClass {
  final String name;
  List<CourseUnitStudent> students;

  CourseUnitClass(this.name, this.students);
}
