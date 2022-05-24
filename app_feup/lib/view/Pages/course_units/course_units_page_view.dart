import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:uni/view/Pages/course_units/course_units_materials_view.dart';
import 'package:uni/view/Pages/course_units/course_units_classes_view.dart';
import 'package:uni/view/Pages/course_units/course_units_results_view.dart';
import 'package:uni/view/Pages/course_units/course_units_sheets_view.dart';
import 'package:uni/view/Widgets/page_title.dart';
import 'package:uni/model/app_state.dart';
import 'package:redux/redux.dart';

import '../../../controller/local_storage/app_shared_preferences.dart';
import '../../../redux/action_creators.dart';

class CourseUnitsPageView extends StatelessWidget {
  final TabController tabController;
  final List<String> coursesTabs;

  CourseUnitsPageView(
      {Key key, @required this.tabController, @required this.coursesTabs});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return StoreConnector<AppState, Store<AppState>>(
        builder: (context, store) {
          return Column(children: <Widget>[
            ListView(
              key: const Key('courses'),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PageTitle(name: 'Cadeiras'),
                    Row(
                      children: [
                        Container(
                            child: TextButton(
                          child: Text('Atualizar tudo',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .color)),
                          onPressed: () async {
                            final Tuple2<String, String> userInfo =
                                await AppSharedPreferences
                                    .getPersistentUserInfo();
                            final Completer<Null> courseUnitsSheets =
                                    Completer(),
                                courseUnitsClasses = Completer(),
                                courseUnitsMaterials = Completer();
                            store.dispatch(getCourseUnitsSheetsFromFetcher(
                                courseUnitsSheets));
                            store.dispatch(getCourseUnitsClassesFromFetcher(
                                courseUnitsClasses, userInfo));
                            store.dispatch(getCourseUnitsMaterialsFromFetcher(
                                courseUnitsMaterials));
                            Future.wait([
                              courseUnitsSheets.future,
                              courseUnitsClasses.future,
                              courseUnitsMaterials.future
                            ]);
                          },
                        )),
                        IconButton(
                            padding: EdgeInsets.only(right: 10),
                            icon: Icon(Icons.info),
                            color: Theme.of(context).textTheme.headline6.color,
                            onPressed: () {
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text(
                                            'Atualização dos conteúdos'),
                                        content: const Text(
                                            '''Os conteúdos das cadeiras, por não mudarem frequentemente, '''
                                            '''são atualizados automaticamente apenas uma vez por semana, '''
                                            '''caso a sua sessão seja persistente.\n\n'''
                                            '''Para refrescar manualmente todos os dados, toque no botão.'''),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'OK'),
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      ));
                            })
                      ],
                    )
                  ],
                ),
                TabBar(
                  indicatorColor: Theme.of(context).colorScheme.secondary,
                  controller: tabController,
                  isScrollable: true,
                  tabs: createTabs(queryData, context),
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: tabController,
              children: createCourses(context),
            ))
          ]);
        },
        converter: (store) => store);
  }

  /// Returns a list of widgets empty with tabs for each day of the week.
  List<Widget> createTabs(queryData, BuildContext context) {
    final List<Widget> tabs = <Widget>[];
    for (var i = 0; i < coursesTabs.length; i++) {
      tabs.add(Container(
        color: Theme.of(context).backgroundColor,
        width: queryData.size.width * 1 / 4,
        child: Tab(key: Key(coursesTabs[i]), text: coursesTabs[i]),
      ));
    }
    return tabs;
  }

  List<Widget> createCourses(BuildContext context) {
    return [
      CourseUnitsSheetsView(),
      CourseUnitsClassesView(),
      CourseUnitsMaterialsView(),
      CourseUnitsResultsView()
    ];
  }
}
