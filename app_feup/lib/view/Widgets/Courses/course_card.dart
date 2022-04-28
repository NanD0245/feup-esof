import 'package:flutter/material.dart';
import 'package:uni/model/entities/course_sheets.dart';
import 'package:uni/model/entities/course_teacher.dart';
import 'package:uni/view/Widgets/Courses/course_generic_card.dart';

class CourseCard extends CourseGenericCard {
  final double padding = 12.0;
  final CourseSheet courseSheet;

  CourseCard(this.courseSheet);

  @override
  Widget buildCardContent(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            title: Text(
              this.courseSheet.courseName,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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
    return Column(children: [
      sectionTitle('Docência (Teóricas)'),
      Table(
          columnWidths: {1: FractionColumnWidth(.4)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: getTeachersTable(courseSheet.getTeachers(true))),
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      ),
      sectionTitle('Docência (Práticas)'),
      Table(
          columnWidths: {1: FractionColumnWidth(.4)},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: getTeachersTable(courseSheet.getTeachers(false)))
    ]);
  }

  List<TableRow> getTeachersTable(List<CourseTeacher> teachers) {
    final List<TableRow> teachersTableLines = [];
    for (CourseTeacher teacher in teachers) {
      teachersTableLines.add(TableRow(children: [
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, left: 5.0),
          child: Text(teacher.name, overflow: TextOverflow.ellipsis),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5.0, bottom: 8.0, right: 5.0),
          child: Align(
              alignment: Alignment.centerRight, child: Text(teacher.hours)),
        )
      ]));
    }
    return [
          TableRow(children: [
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 8.0, left: 5.0),
              child: Text('Docente'),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0, bottom: 8.0, right: 5.0),
              child:
                  Align(alignment: Alignment.centerRight, child: Text('Horas')),
            )
          ])
        ] +
        teachersTableLines;
  }

  Widget courseObjectiveWidget() {
    return Column(children: [
      sectionTitle('Objetivos'),
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      )
    ]);
  }

  Widget courseProgramWidget() {
    return Column(children: [
      sectionTitle('Programa'),
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      )
    ]);
  }

  Widget courseEvaluationWidget() {
    return Column(children: [
      sectionTitle('Avaliação'),
      Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      )
    ]);
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
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ));
  }
}
