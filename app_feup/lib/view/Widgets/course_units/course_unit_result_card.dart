import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uni/model/entities/course_unit.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';

class CourseUnitResultCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnit courseUnit;

  CourseUnitResultCard(this.courseUnit);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ListTile(
          title: Text(
            this.courseUnit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          trailing: Text(
            this.courseUnit.grade,
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(255, 0x75, 0x17, 0x1e)),
          ),
        ));
  }
}
