import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:sigarra_eye_candy/view/pages/classes.dart';
import 'package:sigarra_eye_candy/view/pages/courses.dart';
import 'package:sigarra_eye_candy/view/pages/grades.dart';
import 'package:sigarra_eye_candy/view/pages/materials.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Sigarra Eye Candy', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final pages = [
    const CoursesPage(),
    const MaterialsPage(),
    const GradesPage(),
    const ClassesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      appBar: AppBar(
        title: Text('Sigarra Eye Candy'),
      ),
      extendBody: true,
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget bottomNavigationBar() {
    return Container(
        margin: EdgeInsets.all(10),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: BottomNavigationBar(
              onTap: (value) => {setState(() => _pageIndex = value)},
              iconSize: 30,
              type: BottomNavigationBarType.fixed,
              currentIndex: _pageIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.book), label: "Materials"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.school), label: "Grades"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.people), label: "Classes")
              ],
            )));
  }
}
