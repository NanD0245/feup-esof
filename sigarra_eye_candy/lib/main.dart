import 'package:flutter/material.dart';
import 'package:sigarra_eye_candy/view/theme.dart';
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
    return MaterialApp(
        theme: appTheme, title: 'Sigarra Eye Candy', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;
  final _pages = [
    const CoursesPage(),
    const MaterialsPage(),
    const GradesPage(),
    const ClassesPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _pageIndex,
        children: _pages,
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          Container(
              margin: EdgeInsets.only(right: 10),
              child: Center(
                  child: Text("Peter White",
                      style: TextStyle(fontSize: 20, color: Colors.black))))
        ],
        title: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          padding: EdgeInsets.all(3),
          child: Icon(Icons.school, color: deepBlack),
        ),
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
              backgroundColor: lightBlue,
              selectedItemColor: brightYellow,
              unselectedItemColor: deepBlack,
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
