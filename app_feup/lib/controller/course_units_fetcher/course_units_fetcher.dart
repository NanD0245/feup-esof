import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:uni/controller/parsers/parser_course_unit_materials.dart';
import 'package:uni/controller/parsers/parser_course_unit_sheet.dart';
import 'package:uni/model/entities/course_units/course_unit_classes.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/model/entities/course_units/course_unit_sheet.dart';

import '../../controller/networking/network_router.dart';
import '../../model/entities/course_units/course_unit.dart';
import '../../model/entities/session.dart';
import '../parsers/parser_course_unit_classes.dart';

class CourseUnitsFetcher {
  Future<List<CourseUnitSheet>> getCourseUnitsSheets(
      Session session, List<CourseUnit> userUcs) async {
    final List<CourseUnitSheet> courseUnitsSheets = [];
    for (CourseUnit courseUnit in userUcs) {
      final String url = NetworkRouter.getBaseUrl(session.faculty) +
          'ucurr_geral.ficha_uc_view?pv_ocorrencia_id=${courseUnit.occurrId}';
      final Future<Response> response =
          NetworkRouter.getWithCookies(url, {}, session);
      final CourseUnitSheet courseUnitSheet = await response
          .then((response) => parseCourseUnitSheet(courseUnit, response));
      courseUnitsSheets.add(courseUnitSheet);
    }
    return courseUnitsSheets;
  }

  Future<List<CourseUnitClasses>> getCourseUnitsClasses(
      Session session, List<CourseUnit> userUcs) async {
    final List<CourseUnitClasses> courseUnitsClasses = [];
    for (CourseUnit courseUnit in userUcs) {
      final String courseChoiceUrl = NetworkRouter.getBaseUrl(session.faculty) +
          'it_listagem.lista_cursos_disciplina' +
          '?pv_ocorrencia_id=${courseUnit.occurrId}';
      final Response courseChoiceResponse =
          await NetworkRouter.getWithCookies(courseChoiceUrl, {}, session);
      final courseChoiceDocument = parse(courseChoiceResponse.body);
      final urls = courseChoiceDocument
          .querySelectorAll('a')
          .where((element) =>
              element.attributes['href'] != null &&
              element.attributes['href']
                  .contains('it_listagem.lista_turma_disciplina'))
          .map((e) {
        var url = e.attributes['href'];
        if (!url.contains('sigarra.up.pt')) {
          url = NetworkRouter.getBaseUrl(session.faculty) + url;
        }
        return url;
      }).toList();

      for (final url in urls) {
        final Future<Response> response =
            NetworkRouter.getWithCookies(url, {}, session);
        final CourseUnitClasses courseUnitClasses = await response
            .then((response) => parseCourseUnitClasses(courseUnit, response));
        if (courseUnitsClasses.isNotEmpty &&
            courseUnitsClasses.last.courseName ==
                courseUnitClasses.courseName) {
          courseUnitsClasses.last.classes.addAll(courseUnitClasses.classes);
        } else {
          courseUnitsClasses.add(courseUnitClasses);
        }
      }
    }
    return courseUnitsClasses;
  }

  Future<List<CourseUnitMaterials>> getCourseUnitsMaterials(
      Session session, List<CourseUnit> userUcs) async {
    final List<CourseUnitMaterials> courseUnitsMaterials = [];
    for (CourseUnit courseUnit in userUcs) {
      final String url = NetworkRouter.getBaseUrl(session.faculty) +
          'conteudos_geral.ver?pct_pag_id=249640' +
          '&pct_parametros=pv_ocorrencia_id=${courseUnit.occurrId}';
      final Future<Response> response =
          NetworkRouter.getWithCookies(url, {}, session);
      final CourseUnitMaterials courseUnitMaterials = await response
          .then((response) => parseCourseUnitMaterials(courseUnit, response));
      courseUnitsMaterials.add(courseUnitMaterials);
    }
    return courseUnitsMaterials;
  }
}
