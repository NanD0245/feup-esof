import 'package:html/parser.dart';
import 'package:uni/controller/networking/network_router.dart';

import '../../model/entities/course_units/course_unit.dart';
import 'package:http/http.dart' as http;
import '../../model/entities/course_units/course_unit_materials.dart';

CourseUnitMaterials parseCourseUnitMaterials(
    CourseUnit courseUnit, http.Response materialsPageResponse) {
  final document = parse(materialsPageResponse.body);
  String zipUrl = '';

  if (document.getElementById('erro') == null) {
    zipUrl = document
        .querySelectorAll('#conteudoinner a')
        .where((element) =>
            element.attributes['href'] != null &&
            element.attributes['href']
                .contains('conteudos_geral.download_todos_conteudos'))
        .toList()[0]
        .attributes['href'];
    if (!zipUrl.contains('sigarra.up.pt')) {
      zipUrl = NetworkRouter.getBaseUrl('feup') + zipUrl;
    }
  }

  return CourseUnitMaterials(courseUnit.name, zipUrl, courseUnit.result != 'A');
}
