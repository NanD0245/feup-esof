class CourseUnitTeacher {
  final String name;
  final String hours;
  final String lecturesType;

  CourseUnitTeacher(this.name, this.lecturesType, this.hours);

  Map<String, dynamic> toMap(int ucOccurId) {
    return {
      'name': name,
      'hours': hours,
      'lectures_type': lecturesType,
      'uc_occur_id': ucOccurId
    };
  }

  static CourseUnitTeacher fromMap(dynamic data) {
    return CourseUnitTeacher(
        data['name'], data['lectures_type'], data['hours']);
  }
}
