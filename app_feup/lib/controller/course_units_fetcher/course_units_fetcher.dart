import 'package:http/http.dart';
import 'package:uni/controller/parsers/parser_course_unit_sheet.dart';
import 'package:uni/model/entities/course_units/course_unit_sheet.dart';

import '../../controller/networking/network_router.dart';
import '../../model/entities/course_units/course_unit.dart';
import '../../model/entities/session.dart';

class CourseUnitsFetcher {
  Future<List<CourseUnitSheet>> getCourseUnitsSheets(
      Session session, List<CourseUnit> userUcs) async {
    final List<CourseUnitSheet> courseUnitSheets = [];
    for (CourseUnit courseUnit in userUcs) {
      final String url = NetworkRouter.getBaseUrl(session.faculty) +
          'ucurr_geral.ficha_uc_view?pv_ocorrencia_id=${courseUnit.occurrId}';
      final Future<Response> response =
          NetworkRouter.getWithCookies(url, {}, session);
      final CourseUnitSheet courseUnitSheet = await response
          .then((response) => parseCourseUnitSheet(courseUnit, response));
      courseUnitSheets.add(courseUnitSheet);
    }
    return courseUnitSheets;
  }
}
