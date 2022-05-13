import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni/model/entities/course_unit_class.dart';
import 'package:uni/model/entities/course_unit_classes.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseUnitClassCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnitClasses courseUnit;

  CourseUnitClassCard(this.courseUnit);

  @override
  Widget buildCardContent(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondary;
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          childrenPadding: EdgeInsets.only(bottom: 12, right: 16, left: 16),
          textColor: color,
          iconColor: color,
          title: Text(
            this.courseUnit.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          children: getClasses(color),
        ));
  }

  List<Widget> getClasses(Color color) {
    final List<Widget> classes = [];

    courseUnit.classes.forEach((courseClass) {
      classes.add(ExpansionTile(
        textColor: color,
        iconColor: color,
        title: Text(
          courseClass.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        children: getStudents(courseClass, color),
      ));
    });
    return classes;
  }

  List<Widget> getStudents(CourseUnitClass courseUnitClass, Color color) {
    final List<Widget> students = [];

    courseUnitClass.students.forEach((student) {
      students.add(ListTile(
          dense: true,
          //textColor: color,
          iconColor: color,
          title: Text(
            student.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            student.codUp,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
          trailing: GestureDetector(
            child: Icon(IconData(0xe22a, fontFamily: 'MaterialIcons')),
            onTap: () async {
              final url = 'mailto:' + student.email;
              try {
                await launchUrl(Uri.parse(url));
              } catch (e) {
                Logger().e(e.toString());
              }
            },
          )));
    });
    return students;
  }
}
