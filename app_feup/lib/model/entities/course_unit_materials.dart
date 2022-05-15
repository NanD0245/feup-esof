import 'package:uni/model/entities/course_unit_material_file.dart';
import 'package:uni/model/entities/course_unit_materials_folder.dart';

class CourseUnitMaterials {
  final String name;
  List<CourseUnitMaterialsFolder> folders;
  List<CourseUnitMaterialsFile> files;

  CourseUnitMaterials(this.name, this.folders, this.files);
}
