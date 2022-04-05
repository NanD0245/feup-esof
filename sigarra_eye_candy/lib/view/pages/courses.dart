import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sigarra_eye_candy/view/widgets/expandable_card.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            children: [
          ExpandableCard(
              Text("Software Engineering"), [Text("A course at FEUP.")]),
          ExpandableCard(
              Text("Artificial Intelligence"), [Text("A course at FEUP.")]),
          ExpandableCard(Text("Parallel and Distributed Computing"),
              [Text("A course at FEUP.")]),
          ExpandableCard(Text("Compilers"), [Text("A course at FEUP.")]),
          ExpandableCard(Text("Capstone Project"), [Text("A course at FEUP.")])
        ]
                .map((e) =>
                    Container(padding: EdgeInsets.only(bottom: 30), child: e))
                .toList()));
  }
}
