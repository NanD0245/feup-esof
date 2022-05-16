import 'package:flutter/cupertino.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/view/Widgets/course_units/course_unit_material_card.dart';

class CourseUnitMaterialsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsMaterialsViewState();
}

class _CourseUnitsMaterialsViewState extends State<StatefulWidget> {
  List<CourseUnitMaterials> activeCourses = [
    CourseUnitMaterials('Engenharia de Software', 'www.google.com', true),
    CourseUnitMaterials('Laboratório de Computadores', 'www.amazon.com', true),
    CourseUnitMaterials('Inteligência Artificial', 'www.pplware.sapo.pt', true)
  ];
  List<CourseUnitMaterials> pastCourses = [
    CourseUnitMaterials(
        'Fundamentos de Segurança Informática', 'www.google.com', false),
    CourseUnitMaterials(
        'Linguagens e Tecnologias Web', 'www.amazon.com', false),
  ];

  List<Widget> activeCourseCards = [];
  List<Widget> pastCourseCards = [];

  @override
  Widget build(BuildContext context) {
    activeCourses.forEach((course) {
      activeCourseCards.add(CourseUnitMaterialCard(course));
    });
    pastCourses.forEach((course) {
      pastCourseCards.add(CourseUnitMaterialCard(course));
    });
    return ListView(
        children: [
      Container(
          padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
          child: Text(
            'Por concluir',
            textScaleFactor: 0.8,
          )),
    ]
          ..addAll(activeCourseCards)
          ..addAll([
            Container(
                padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
                child: Text(
                  'Concluídas',
                  textScaleFactor: 0.8,
                )),
          ])
          ..addAll(pastCourseCards)
          ..addAll([
            Container(
              padding: EdgeInsets.fromLTRB(30, 20, 0, 5),
            )
          ]));
  }
}
