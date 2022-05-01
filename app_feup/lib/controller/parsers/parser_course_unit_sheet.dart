import 'dart:collection';

import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

Future<Map<String, String>> parseAcademicPathWayCourseUnits(
    http.Response response) async {
  final document = parse(response.body);

  final Map<String, String> coursesStates = HashMap();

  final courses = document.querySelectorAll('#tabelapercurso > tr');

  for (int i = 0; i < courses.length; i++) {
    final div = courses[i];
    final course = div.querySelector('.estudante-lista-curso-nome > a').text;
    final state = div.querySelectorAll('.formulario td')[3].text;

    coursesStates.putIfAbsent(course, () => state);
  }

  return coursesStates;
}
