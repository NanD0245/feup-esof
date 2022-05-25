import 'package:uni/model/entities/course_units/course_unit_student.dart';

class CourseUnitClass {
  final String name;
  List<CourseUnitStudent> students;

  CourseUnitClass(this.name, this.students);

  Map<String, dynamic> toMap(int occurId) {
    return {'uc_occur_id': occurId, 'name': name};
  }
}
