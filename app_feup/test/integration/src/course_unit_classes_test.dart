import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uni/controller/middleware.dart';
import 'package:uni/controller/networking/network_router.dart';
import 'package:uni/controller/parsers/parser_course_unit_classes.dart';
import 'package:uni/model/app_state.dart';
import 'package:uni/model/entities/course_units/course_unit.dart';
import 'package:uni/model/entities/course_units/course_unit_class.dart';
import 'package:uni/model/entities/course_units/course_unit_student.dart';
import 'package:uni/model/entities/session.dart';
import 'package:uni/redux/reducers.dart';
import 'package:uni/view/Pages/course_units/course_units_classes_view.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';

import '../../testable_redux_widget.dart';

class MockClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class UriMatcher extends CustomMatcher {
  UriMatcher(matcher) : super('Uri that has', 'string', matcher);

  @override
  Object featureValueOf(actual) => (actual as Uri).toString();
}

void main() {
  group('Classes Page Integration Tests', () {
    final mockClient = MockClient();
    final mockResponse = MockResponse();

    final compCourseUnit = CourseUnit(abbreviation: 'COMP',
        name: 'Compiladores');

    testWidgets('All UC classes are present', (WidgetTester tester) async {
      NetworkRouter.httpClient = mockClient;
      final mockHtml = File('test/integration/resources/course_unit_classes_example.html')
          .readAsStringSync();
      when(mockResponse.body).thenReturn(mockHtml);
      when(mockResponse.statusCode).thenReturn(200);
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final ucsClasses = parseCourseUnitClasses(compCourseUnit, mockResponse);

      final store = Store<AppState>(appReducers,
          initialState: AppState({
            'session': Session(authenticated: true),
            'ucsClasses': [ucsClasses],
          }),
          middleware: [generalMiddleware]);

      final page = testableReduxWidget(child: CourseUnitsClassesView(),
          store: store);

      await tester.pumpWidget(page);

      expect(find.byKey(Key(compCourseUnit.name + ' - Turmas')),
          findsOneWidget);
    });

    testWidgets('All Classes are present', (WidgetTester tester) async {
      NetworkRouter.httpClient = mockClient;
      final mockHtml = File('test/integration/resources/course_unit_classes_example.html')
          .readAsStringSync();
      when(mockResponse.body).thenReturn(mockHtml);
      when(mockResponse.statusCode).thenReturn(200);
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final ucsClasses = parseCourseUnitClasses(compCourseUnit, mockResponse);

      final store = Store<AppState>(appReducers,
          initialState: AppState({
            'session': Session(authenticated: true),
            'ucsClasses': [ucsClasses],
          }),
          middleware: [generalMiddleware]);

      final page = testableReduxWidget(child: CourseUnitsClassesView(),
          store: store);

      await tester.pumpWidget(page);

      expect(find.byKey(Key(compCourseUnit.name + ' - Turmas')),
          findsOneWidget);

      for (CourseUnitClass courseUnitClass in ucsClasses.classes) {
        expect(find.byKey(Key(courseUnitClass.name + ' - '
            + compCourseUnit.name)), findsNothing);
      }

      await tester.tap(find.byKey(Key(compCourseUnit.name + ' - Turmas')));
      await tester.pumpAndSettle();

      for (CourseUnitClass courseUnitClass in ucsClasses.classes) {
        expect(find.byKey(Key(courseUnitClass.name + ' - '
            + compCourseUnit.name)), findsOneWidget);
      }
    });

    testWidgets('All Students are present', (WidgetTester tester) async {
      NetworkRouter.httpClient = mockClient;
      final mockHtml = File('test/integration/resources/course_unit_classes_example.html')
          .readAsStringSync();
      when(mockResponse.body).thenReturn(mockHtml);
      when(mockResponse.statusCode).thenReturn(200);
      when(mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => mockResponse);

      final ucsClasses = parseCourseUnitClasses(compCourseUnit, mockResponse);

      final store = Store<AppState>(appReducers,
          initialState: AppState({
            'session': Session(authenticated: true),
            'ucsClasses': [ucsClasses],
          }),
          middleware: [generalMiddleware]);

      final page = testableReduxWidget(child: CourseUnitsClassesView(),
          store: store);

      await tester.pumpWidget(page);

      expect(find.byKey(Key(compCourseUnit.name + ' - Turmas')),
          findsOneWidget);

      await tester.tap(find.byKey(Key(compCourseUnit.name + ' - Turmas')));
      await tester.pumpAndSettle();

      for (CourseUnitClass courseUnitClass in ucsClasses.classes) {
        expect(find.byKey(Key(courseUnitClass.name + ' - '
            + compCourseUnit.name)), findsOneWidget);

        var counter = 1;
        for (CourseUnitStudent _ in courseUnitClass.students) {
          expect(find.byKey(Key(courseUnitClass.name + ' - '
              + compCourseUnit.name + ' - Student ${counter}')),
              findsNothing);
          counter++;
        }

        await tester.pumpAndSettle();
        await tester.tap(find.byKey(Key(courseUnitClass.name + ' - '
            + compCourseUnit.name)));
        await tester.pumpAndSettle();

        counter = 1;
        for (CourseUnitStudent _ in courseUnitClass.students) {
          await tester.scrollUntilVisible(find.byKey(Key(courseUnitClass.name
              + ' - ' + compCourseUnit.name + ' - Student ${counter}')), 500);
          await tester.pumpAndSettle();

          expect(find.byKey(Key(courseUnitClass.name + ' - '
              + compCourseUnit.name + ' - Student ${counter}')),
              findsOneWidget);
          counter++;
        }
      }
    });
  });
}