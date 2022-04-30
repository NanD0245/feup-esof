import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CourseGenericCard extends StatefulWidget {
  CourseGenericCard({Key key})
      : editingMode = false,
        onDelete = null,
        super(key: key);

  final bool editingMode;
  final Function onDelete;

  @override
  State<StatefulWidget> createState() {
    return CourseGenericCardState();
  }

  Widget buildCardContent(BuildContext context);
}

class CourseGenericCardState extends State<CourseGenericCard> {
  final double borderRadius = 10.0;
  final double padding = 3.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Card(
            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
            color: Color.fromARGB(0, 0, 0, 0),
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(this.borderRadius)),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(0x1c, 0, 0, 0),
                        blurRadius: 5.0,
                        offset: Offset(0.0, 1.0))
                  ],
                  color: Theme.of(context).dividerColor,
                  borderRadius:
                      BorderRadius.all(Radius.circular(this.borderRadius))),
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.all(Radius.circular(this.borderRadius))),
                width: (double.infinity),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: this.padding, right: this.padding),
                      child: widget.buildCardContent(context),
                    )
                  ],
                ),
              ),
            )));
  }
}
