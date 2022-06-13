import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:uni/model/entities/course_units/course_unit_class.dart';
import 'package:uni/model/entities/course_units/course_unit_classes.dart';
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
          key: Key('${this.courseUnit.courseName} - Turmas'),
          childrenPadding: EdgeInsets.only(bottom: 12, right: 16, left: 16),
          textColor: color,
          iconColor: color,
          title: Text(
            this.courseUnit.courseName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
          ),
          children: (courseUnit.classes.isEmpty)
              ? [Text('Cadeira sem turmas atribuídas')]
              : getClasses(color, this.courseUnit.courseName),
        ));
  }

  List<Widget> getClasses(Color color, String courseName) {
    final List<Widget> classes = [];

    courseUnit.classes.forEach((courseClass) {
      classes.add(ExpansionTile(
        key: Key('${courseClass.name} - ${courseName}'),
        textColor: color,
        iconColor: color,
        title: Text(
          courseClass.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
        ),
        children: (courseClass.students.isEmpty)
            ? [Text('Turma sem estudantes atribuídos')]
            : getStudents(courseClass, color, '${courseClass.name} - '
            '${courseName}'),
      ));
    });
    return classes;
  }

  List<Widget> getStudents(CourseUnitClass courseUnitClass, Color color,
      String fullClassName) {
    final List<Widget> students = [];
    var counter = 1;
    courseUnitClass.students.forEach((student) {
      students.add(ListTile(
          key: Key('${fullClassName} - Student ${counter}'),
          dense: true,
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
      counter++;
    });
    return students;
  }
}
