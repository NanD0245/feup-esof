import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/view/Widgets/course_units/course_unit_material_card.dart';

import '../../../model/app_state.dart';
import '../../../model/entities/session.dart';

class CourseUnitMaterialsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsMaterialsViewState();
}

class _CourseUnitsMaterialsViewState extends State<StatefulWidget> {
  List<CourseUnitMaterials> activeCourses = [
    CourseUnitMaterials(
        'Engenharia de Software', 'https://www.google.com', true),
    CourseUnitMaterials(
        'Laboratório de Computadores',
        'https://sigarra.up.pt/feup/pt/conteudos_geral.download_todos_conteudos?pct_pag_id=249640&pct_parametros=pv_ocorrencia_id=484430',
        true),
    CourseUnitMaterials('Inteligência Artificial', 'www.pplware.sapo.pt', true)
  ];
  List<CourseUnitMaterials> pastCourses = [
    CourseUnitMaterials('Fundamentos de Segurança Informática', '', false),
    CourseUnitMaterials(
        'Linguagens e Tecnologias Web', 'www.amazon.com', false),
  ];

  List<Widget> activeCourseCards = [];
  List<Widget> pastCourseCards = [];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Session>(
        builder: (context, courseUnitsClassesData) {
          final Session session = courseUnitsClassesData;
          activeCourses.forEach((course) {
            activeCourseCards.add(CourseUnitMaterialCard(course, session));
          });
          pastCourses.forEach((course) {
            pastCourseCards.add(CourseUnitMaterialCard(course, session));
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
        },
        converter: (store) => store.state.content['session']);
  }
}
