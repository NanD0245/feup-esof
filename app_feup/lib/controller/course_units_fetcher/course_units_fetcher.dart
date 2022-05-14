import 'package:http/http.dart';
import 'package:uni/controller/parsers/parser_course_unit_sheet.dart';
import 'package:uni/model/entities/course_units/course_unit_classes.dart';
import 'package:uni/model/entities/course_units/course_unit_sheet.dart';

import '../../controller/networking/network_router.dart';
import '../../model/entities/course_units/course_unit.dart';
import '../../model/entities/course_units/course_unit_class.dart';
import '../../model/entities/course_units/course_unit_student.dart';
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

  Future<List<CourseUnitClasses>> getCourseUnitsClasses(
      Session session, List<CourseUnit> userUcs) async {
    final List<CourseUnitClasses> courseUnitClasses = [
      CourseUnitClasses(
          'Laboratório de Computadores',
          [
            CourseUnitClass('2LEIC01', [
              CourseUnitStudent('Fernando Luis Santos Rego', 'up201905951',
                  'up201905951@edu.fe.up.pt'),
              CourseUnitStudent(
                  'Bruno Mendes', 'up201906166', 'up201906166@edu.fe.up.pt')
            ]),
            CourseUnitClass('2LEIC02', [
              CourseUnitStudent(
                  'Olá pessoa', 'up201902351', 'up201902351@edu.fe.up.pt')
            ]),
          ],
          true),
      CourseUnitClasses(
          'Compiladores',
          [
            CourseUnitClass('2LEIC01', [
              CourseUnitStudent('Fernando Luis Santos Rego', 'up201905951',
                  'up201905951@edu.fe.up.pt'),
              CourseUnitStudent(
                  'Bruno Mendes', 'up201906166', 'up201906166@edu.fe.up.pt')
            ]),
          ],
          false)
    ];
    return courseUnitClasses;
  }
}
