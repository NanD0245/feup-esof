import 'package:flutter/material.dart';
import 'package:uni/view/Pages/Courses/courses_page_view.dart';
import 'package:uni/view/Pages/secondary_page_view.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key key}) : super(key: key);

  @override
  CoursesPageState createState() => CoursesPageState();
}

class CoursesPageState extends SecondaryPageViewState
    with SingleTickerProviderStateMixin {
  TabController tabController;

  final List<String> coursesTabs = [
    'Fichas',
    'Turmas',
    'Materiais',
    'Resultados',
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: coursesTabs.length);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget getBody(BuildContext context) {
    return CoursesPageView(
        tabController: tabController, coursesTabs: coursesTabs);
  }
}
