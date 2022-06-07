class CourseUnitStudent {
  final String name;
  final String codUp;
  final String email;

  CourseUnitStudent(this.name, this.codUp, this.email);

  Map<String, dynamic> toMap(classId) {
    return {
      'name': name,
      'uc_class_id': classId,
      'email': email,
      'up_code': codUp
    };
  }

  static CourseUnitStudent fromMap(Map<String, dynamic> data) {
    return CourseUnitStudent(data['name'], data['up_code'], data['email']);
  }
}
