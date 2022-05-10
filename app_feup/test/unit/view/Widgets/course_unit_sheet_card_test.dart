import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../testable_widget.dart';
import 'package:uni/view/Widgets/course_units/course_unit_sheet_card.dart';
import 'package:uni/model/entities/course_unit_sheet.dart';
import 'package:uni/model/entities/course_unit_teacher.dart';
import 'package:uni/model/entities/course_unit_evaluation_component.dart';

void main(){
  final String mockName = 'Name';
  final String mockGoals = 'Goals';
  final String mockProgram = 'Program';
  final bool mockActive = true;
  final List<CourseUnitTeacher> mockTeachers = [
    CourseUnitTeacher('Teacher1', 'LectureType1', 'Hours1'),
    CourseUnitTeacher('Teacher2', 'LectureType2', 'Hours2')
  ];
  final List<CourseUnitEvaluationComponent> evaluationComponents = [
      CourseUnitEvaluationComponent('Designation1', 'Weight1'),
      CourseUnitEvaluationComponent('Designation2', 'Weight2')
  ];

  final mockCourseUnitSheet = CourseUnitSheet(mockName, mockGoals, mockProgram,
      evaluationComponents, mockTeachers, mockActive);

  group('UnitSheets', () {
    testWidgets('When given a simple Unit Sheet', (WidgetTester tester) async {
      final widget = makeTestableWidget(
        child: CourseUnitSheetCard(mockCourseUnitSheet)
      );

      await tester.pumpWidget(widget);

      final textName = find.text('Name');
      expect(textName, findsOneWidget);
    });

    testWidgets('When on a UnitSheet, I press the \'Objetivos\' button',
                (WidgetTester tester) async {
      final widget = makeTestableWidget(
        child: CourseUnitSheetCard(mockCourseUnitSheet)
      );

      await tester.pumpWidget(widget);

      final unit = find.byType(ExpansionTile);

      await tester.tap(unit, warnIfMissed : true);
      await tester.pump();

      final objectiveTest = find.text('Objetivos');
      final programaTest = find.text('Programa');
      final avaliacaoTest = find.text('Avaliação');
      final docenciaTest = find.text('Docência');
    
      expect(objectiveTest, findsOneWidget);
      expect(programaTest, findsOneWidget);
      expect(avaliacaoTest, findsOneWidget);
      expect(docenciaTest, findsOneWidget);
    });
  });
}