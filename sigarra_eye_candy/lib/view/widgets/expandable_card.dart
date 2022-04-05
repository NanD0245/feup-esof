import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

class ExpandableCard extends StatelessWidget {
  final List<Widget> _children;
  final Widget _header;

  ExpandableCard(Widget header, List<Widget> children)
      : _children = children,
        _header = header;

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: _header,
      collapsed: null,
      expanded: Column(children: _children),
    );
  }
}
