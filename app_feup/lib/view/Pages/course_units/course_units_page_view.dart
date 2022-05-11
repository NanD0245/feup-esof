import 'package:flutter/material.dart';
import 'package:uni/view/Pages/course_units/course_units_classes_view.dart';
import 'package:uni/view/Pages/course_units/course_units_results_view.dart';
import 'package:uni/view/Pages/course_units/course_units_sheets_view.dart';
import 'package:uni/view/Widgets/page_title.dart';

class CourseUnitsPageView extends StatelessWidget {
  final TabController tabController;
  final List<String> coursesTabs;

  CourseUnitsPageView(
      {Key key, @required this.tabController, @required this.coursesTabs});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);
    return Column(children: <Widget>[
      ListView(
        key: const Key('courses'),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          PageTitle(name: 'Cadeiras'),
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
      Center(child: Text('In progress...')),
      CourseUnitsResultsView()
    ];
  }
}
