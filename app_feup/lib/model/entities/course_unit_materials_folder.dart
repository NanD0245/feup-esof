import 'course_unit_material_file.dart';

class CourseUnitMaterialsFolder {
  final String name;
  List<CourseUnitMaterialsFolder> folders;
  List<CourseUnitMaterialsFile> files;

  CourseUnitMaterialsFolder(this.name, this.folders, this.files);
}
