import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course_units/course_unit_classes.dart';
import 'package:uni/view/Widgets/request_dependent_widget_builder.dart';

import '../../Widgets/course_units/course_unit_class_card.dart';

class CourseUnitsClassesView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsClassesViewState();
}

class _CourseUnitsClassesViewState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState,
            Tuple2<List<CourseUnitClasses>, RequestStatus>>(
        builder: (context, courseUnitsClassesData) {
          final courseUnitsClasses = courseUnitsClassesData.item1;
          final courseUnitsClassesStatus = courseUnitsClassesData.item2;
          return RequestDependentWidgetBuilder(
            alwaysShowCircularProgressWhileBusy: true,
            context: context,
            onNullContent:
                Center(child: Text('Não existem turmas para apresentar')),
            status: courseUnitsClassesStatus,
            content: courseUnitsClasses,
            contentChecker: courseUnitsClasses?.isNotEmpty ?? false,
            contentGenerator: (_, BuildContext context) {
              final List<Widget> activeCourseCards = [];
              final List<Widget> pastCourseCards = [];
              courseUnitsClasses.forEach((course) {
                if (course.active) {
                  activeCourseCards.add(CourseUnitClassCard(course));
                } else {
                  pastCourseCards.add(CourseUnitClassCard(course));
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
          );
        },
        converter: (store) => Tuple2(store.state.content['ucsClasses'],
            store.state.content['ucsClassesStatus']));
  }
}
