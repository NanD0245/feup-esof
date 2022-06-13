import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/view/Widgets/course_units/course_unit_material_card.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';

import '../../../model/app_state.dart';
import '../../../model/entities/session.dart';

class CourseUnitsMaterialsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsMaterialsViewState();
}

class _CourseUnitsMaterialsViewState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,
            Tuple3<List<CourseUnitMaterials>, RequestStatus, Session>>(
        builder: (context, courseUnitsMaterialsData) {
          final List<CourseUnitMaterials> courseUnitsMaterials =
              courseUnitsMaterialsData.item1;
          final RequestStatus courseUnitsMaterialsStatus =
              courseUnitsMaterialsData.item2;
          final Session session = courseUnitsMaterialsData.item3;
          return RequestDependentWidgetBuilder(
              alwaysShowCircularProgressWhileBusy: true,
              context: context,
              status: courseUnitsMaterialsStatus,
              contentGenerator: (_, BuildContext context) {
                final List<Widget> activeCourseCards = [];
                final List<Widget> pastCourseCards = [];
                courseUnitsMaterials.forEach((courseUnitMaterials) {
                  if (courseUnitMaterials.active) {
                    activeCourseCards.add(
                        CourseUnitMaterialCard(courseUnitMaterials, session));
                  } else {
                    pastCourseCards.add(
                        CourseUnitMaterialCard(courseUnitMaterials, session));
                  }
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
              content: courseUnitsMaterials,
              contentChecker: courseUnitsMaterials?.isNotEmpty ?? false,
              onNullContent:
                  Center(child: Text('Não existem materiais para apresentar')));
        },
        converter: (store) => Tuple3(
            store.state.content['ucsMaterials'],
            store.state.content['ucsMaterialsStatus'],
            store.state.content['session']));
  }
}
