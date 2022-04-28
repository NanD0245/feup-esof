import 'package:flutter/material.dart';
import 'package:uni/view/Widgets/Courses/course_generic_card.dart';

class CourseCard extends CourseGenericCard {
  final double padding = 12.0;
  final String courseName;
  final Widget extension;

  CourseCard(this.courseName, this.extension);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: Text(
              courseName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            children: [extension],
            childrenPadding: EdgeInsets.only(bottom: padding)));
  }
}
