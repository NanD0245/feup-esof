import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';

class CourseUnitMaterialCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnitMaterials courseUnit;

  CourseUnitMaterialCard(this.courseUnit);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          textColor: Theme.of(context).colorScheme.secondary,
          iconColor: Theme.of(context).colorScheme.secondary,
          childrenPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          title: Text(
            this.courseUnit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          children: [],
        ));
  }
}
