import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_units/course_unit.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';

class CourseUnitResultCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnit courseUnit;

  CourseUnitResultCard(this.courseUnit);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          textColor: Theme.of(context).colorScheme.secondary,
          iconColor: Theme.of(context).colorScheme.secondary,
          childrenPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          title: ListTile(
            dense: true,
            contentPadding: EdgeInsets.zero,
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
          ),
          children: [
            getCourseUnitInfos(courseUnit),
          ],
        ));
  }

  Widget getCourseUnitInfos(CourseUnit courseUnit) {
    return Table(
        columnWidths: {1: FractionColumnWidth(.2)},
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          getTableRowInfos('Créditos:', this.courseUnit.ects.toString()),
          getTableRowInfos('Ano:', this.courseUnit.curricularYear.toString()),
          getTableRowInfos('Semestre:', this.courseUnit.semesterCode),
          getTableRowInfos('Nota:',
              (this.courseUnit.grade.isEmpty) ? 'N/A' : this.courseUnit.grade),
        ]);
  }

  TableRow getTableRowInfos(String info, String value) {
    return TableRow(children: [
      Container(
        child: Text(
          info,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8),
      ),
      Container(
        child: Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        padding: EdgeInsets.only(top: 8, bottom: 8),
      ),
    ]);
  }
}
