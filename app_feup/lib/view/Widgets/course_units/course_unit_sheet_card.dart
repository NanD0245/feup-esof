import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';
import 'package:uni/view/Widgets/course_units/course_unit_generic_card.dart';

import 'course_unit_generic_card.dart';

class CourseUnitSheetCard extends CourseUnitGenericCard {
  final double padding = 12.0;
  final CourseUnitSheet courseSheet;

  CourseUnitSheetCard(this.courseSheet);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: Text(
              this.courseSheet.courseName,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            children: [courseSheetWidget()],
            childrenPadding: EdgeInsets.only(bottom: padding)));
  }

  Widget courseSheetWidget() {
    final List<Widget> sections = [
      courseObjectiveWidget(),
      courseProgramWidget(),
      courseEvaluationWidget(),
      courseTeachersWidget()
    ];
    return Align(
        alignment: Alignment.centerLeft,
        child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(children: sections)) //ListView(children: sections)),
        );
  }

  Widget courseTeachersWidget() {
    return ExpansionTile(
        title: sectionTitle('Docência'),
        tilePadding: EdgeInsets.only(right: 20),
        children: [Column(children: getTeachers(courseSheet.getTeachers()))]);
  }

  List<Widget> getTeachers(Map<String, List<CourseUnitTeacher>> teachers) {
    final List<Widget> widgets = [];
    for (String type in teachers.keys) {
      widgets.add(sectionTitle(type));
      widgets.add(Table(
          columnWidths: {1: FractionColumnWidth(.2)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: getTeachersTable(teachers[type])));
      widgets.add(Container(
        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
      ));
    }
    widgets.removeLast();
    return widgets;
  }

  List<TableRow> getTeachersTable(List<CourseUnitTeacher> teachers) {
    final List<TableRow> teachersTableLines = [];
    for (CourseUnitTeacher teacher in teachers) {
      teachersTableLines.add(TableRow(children: [
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, left: 5.0),
          child: Text(
            teacher.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, right: 5.0),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(teacher.hours, style: TextStyle(fontSize: 14))),
        )
      ]));
    }
    return [
          TableRow(children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 5.0),
              child: Text(
                'Docente',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, right: 5.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Horas',
                    style: TextStyle(fontSize: 14),
                  )),
            )
          ])
        ] +
        teachersTableLines;
  }

  Widget courseObjectiveWidget() {
    return ExpansionTile(
        title: sectionTitle('Objetivos'),
        tilePadding: EdgeInsets.only(right: 20),
        children: [
          Container(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  courseSheet.goals,
                  style: TextStyle(fontWeight: FontWeight.w400),
                )),
          ),
        ]);
  }

  Widget courseProgramWidget() {
    return ExpansionTile(
        title: sectionTitle('Programa'),
        tilePadding: EdgeInsets.only(right: 20),
        children: [
          Container(
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  courseSheet.program,
                  style: TextStyle(fontWeight: FontWeight.w400),
                )),
          ),
        ]);
  }

  Widget courseEvaluationWidget() {
    return ExpansionTile(
        title: sectionTitle('Avaliação'),
        tilePadding: EdgeInsets.only(right: 20),
        children: [
          Column(children: [
            Table(
                columnWidths: {1: FractionColumnWidth(.3)},
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: getEvaluationTable()),
          ])
        ]);
  }

  List<TableRow> getEvaluationTable() {
    final List<TableRow> evaluationTableLines = [];
    for (CourseUnitEvaluationComponent component
        in courseSheet.evaluationComponents) {
      evaluationTableLines.add(TableRow(children: [
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, left: 5.0),
          child: Text(
            component.designation,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, right: 5.0),
          child: Align(
              alignment: Alignment.centerRight,
              child: Text(component.weight, style: TextStyle(fontSize: 14))),
        )
      ]));
    }
    return [
          TableRow(children: [
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 5.0),
              child: Text(
                'Designação',
                style: TextStyle(fontSize: 14),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0, bottom: 8.0, right: 5.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Peso (%)',
                    style: TextStyle(fontSize: 14),
                  )),
            )
          ])
        ] +
        evaluationTableLines;
  }

  Widget sectionTitle(String title) {
    return Container(
        padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Color.fromRGBO(50, 50, 50, 100),
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
