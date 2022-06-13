import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/model/entities/course_units/course_unit.dart';
import 'package:uni/view/Widgets/course_units/course_unit_result_card.dart';

import '../../../model/app_state.dart';
import '../../Widgets/request_dependent_widget_builder.dart';

class CourseUnitsResultsView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CourseUnitsResultsViewState();
}

class _CourseUnitsResultsViewState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Tuple2<List<CourseUnit>, RequestStatus>>(
        builder: (context, courseUnitsResultData) {
          final courseUnitsResults = courseUnitsResultData.item1;
          final courseUnitsResultsStatus = courseUnitsResultData.item2;
          return RequestDependentWidgetBuilder(
            alwaysShowCircularProgressWhileBusy: true,
            context: context,
            onNullContent:
                Center(child: Text('Não existem resultados para apresentar')),
            status: courseUnitsResultsStatus,
            content: courseUnitsResults,
            contentChecker: courseUnitsResults?.isNotEmpty ?? false,
            contentGenerator: (dynamic courseUnitResult, BuildContext context) {
              final List<Widget> activeCourseCards = [];
              final List<Widget> pastCourseCards = [];
              courseUnitsResults.forEach((courseUnit) {
                if (courseUnit.result != 'A') {
                  activeCourseCards.add(CourseUnitResultCard(courseUnit));
                } else {
                  pastCourseCards.add(CourseUnitResultCard(courseUnit));
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
        converter: (store) => Tuple2(store.state.content['currUcs'],
            store.state.content['profileStatus']));
  }
}
