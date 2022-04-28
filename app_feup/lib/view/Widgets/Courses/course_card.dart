import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/Courses/course_generic_card.dart';

class CourseCard extends CourseGenericCard {
  final double padding = 12.0;
  final String courseName;
  final Widget extension;
  final ExpansionTile expansionTile;

  CourseCard(this.courseName, this.extension, {double padding = 12.0})
      : expansionTile = ExpansionTile(
            title: Text(courseName),
            children: [extension],
            childrenPadding: EdgeInsets.only(bottom: padding));

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: expansionTile);
  }

  String getTitle() {
    return courseName;
  }
}
