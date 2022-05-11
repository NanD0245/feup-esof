import 'package:flutter/material.dart';
import 'package:uni/model/entities/CourseUnitClasses.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';

class CourseUnitClassCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnitClasses courseUnit;

  CourseUnitClassCard(this.courseUnit);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Text('ola'));
  }
}
