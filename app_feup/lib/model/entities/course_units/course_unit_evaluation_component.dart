class CourseUnitEvaluationComponent {
  String designation;
  String weight;

  CourseUnitEvaluationComponent(this.designation, this.weight);

  Map<String, dynamic> toMap(int ucOccurId) {
    return {
      'designation': designation,
      'weight': weight,
      'uc_occur_id': ucOccurId
    };
  }

  static CourseUnitEvaluationComponent fromMap(dynamic data) {
    return CourseUnitEvaluationComponent(data['designation'], data['weight']);
  }
}
