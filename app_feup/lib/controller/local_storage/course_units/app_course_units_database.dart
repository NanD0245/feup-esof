import 'package:sqflite/sqflite.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/course_units/course_unit_evaluation_component.dart';
import 'package:uni/model/entities/course_units/course_unit_materials.dart';
import 'package:uni/model/entities/course_units/course_unit_sheet.dart';
import 'package:uni/model/entities/course_units/course_unit_student.dart';

import '../../../model/entities/course_units/course_unit.dart';
import '../../../model/entities/course_units/course_unit_class.dart';
import '../../../model/entities/course_units/course_unit_classes.dart';
import '../../../model/entities/course_units/course_unit_teacher.dart';

class AppCourseUnitsDatabase extends AppDatabase {
  AppCourseUnitsDatabase()
      : super('ucs.db', [
          '''CREATE TABLE ucs(
            occur_id INTEGER PRIMARY KEY,
            id INTEGER,
            code TEXT,
            abbreviation TEXT,
            name TEXT NOT NULL UNIQUE,
            curricular_year INTEGER,
            semester_code TEXT,
            semester_name TEXT,
            type TEXT,
            status TEXT,
            ects_grade TEXT,
            ects INTEGER,
            grade TEXT,
            result TEXT
            )
        ''',
          '''CREATE TABLE uc_classes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uc_occur_id INTEGER,
            name TEXT NOT NULL,
            FOREIGN KEY(uc_occur_id) REFERENCES ucs(occur_id)
            )
        ''',
          '''CREATE TABLE uc_students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uc_class_id INTEGER,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            up_code TEXT NOT NULL,
            FOREIGN KEY(uc_class_id) REFERENCES uc_classes(id)
            )
        ''',
          '''CREATE TABLE uc_materials(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          uc_occur_id INTEGER,
          zip_url TEXT NOT NULL,
          FOREIGN KEY(uc_occur_id) REFERENCES ucs(occur_id)
          )
        ''',
          '''CREATE TABLE uc_teachers(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uc_occur_id INTEGER,
            name TEXT NOT NULL,
            hours TEXT,
            lectures_type TEXT,
            FOREIGN KEY(uc_occur_id) REFERENCES ucs(occur_id)
            )
         ''',
          '''CREATE TABLE uc_evaluation_components(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uc_occur_id INTEGER,
            designation TEXT,
            weight TEXT,
            FOREIGN KEY(uc_occur_id) REFERENCES ucs(occur_id)
            )
         ''',
          '''CREATE TABLE uc_sheets(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uc_occur_id INTEGER,
            goals TEXT,
            program TEXT,
            FOREIGN KEY(uc_occur_id) REFERENCES ucs(occur_id)
            )
         '''
        ]);

  Future<void> saveCourseUnits(List<CourseUnit> courseUnits) async {
    final Database database = await this.getDatabase();
    await database.transaction((transaction) async {
      await _deleteUcs(transaction);
      courseUnits.forEach((courseUnit) {
        _insertCourseUnit(transaction, courseUnit);
      });
    });
  }

  Future<void> _insertCourseUnit(
      Transaction transaction, CourseUnit courseUnit) async {
    await transaction.insert('ucs', courseUnit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CourseUnit>> getCourseUnits() async {
    final Database database = await this.getDatabase();
    final List<CourseUnit> courseUnits = [];
    await database.transaction((transaction) async {
      final ucsMap = await transaction.query('ucs');
      ucsMap.forEach((entry) {
        courseUnits.add(CourseUnit.fromMap(entry));
      });
    });
    return courseUnits;
  }

  Future<void> saveCourseUnitsClasses(List<CourseUnit> courseUnits,
      List<CourseUnitClasses> courseUnitsClasses) async {
    final Database database = await this.getDatabase();
    await database.transaction((transaction) async {
      await _deleteUcsClasses(transaction);
      courseUnitsClasses.forEach((courseUnitClasses) async {
        final courseUnit = courseUnits.firstWhere(
            (element) => element.name == courseUnitClasses.courseName,
            orElse: null);
        if (courseUnit == null) {
          return;
        }
        await _insertCourseUnitClasses(
            transaction, courseUnit, courseUnitClasses);
      });
    });
  }

  Future<void> _insertCourseUnitClasses(Transaction transaction,
      CourseUnit courseUnit, CourseUnitClasses courseUnitClasses) async {
    for (CourseUnitClass c in courseUnitClasses.classes) {
      final int ucClassId =
          await transaction.insert('uc_classes', c.toMap(courseUnit.occurrId));
      for (CourseUnitStudent student in c.students) {
        await transaction.insert('uc_students', student.toMap(ucClassId));
      }
    }
  }

  Future<List<CourseUnitClasses>> getCourseUnitsClasses() async {
    final Database database = await this.getDatabase();
    final Map<int, CourseUnitClasses> courseUnitsClasses = {};
    await database.transaction((transaction) async {
      final ucsClasses = await transaction.query('uc_classes');
      for (final ucClasses in ucsClasses) {
        final uc = (await transaction.query('ucs',
            where: 'occur_id = ?', whereArgs: [ucClasses['uc_occur_id']]))[0];
        final className = ucClasses['name'];
        final int classId = ucClasses['id'];
        final classStudents = await transaction.query('uc_students',
            where: 'uc_class_id = ?', whereArgs: [classId]);
        final List<CourseUnitStudent> students = [];
        for (final student in classStudents) {
          students.add(CourseUnitStudent.fromMap(student));
        }

        final courseUnitClass = CourseUnitClass(className, students);
        if (courseUnitsClasses.containsKey(uc['occur_id'])) {
          courseUnitsClasses[uc['occur_id']].classes.add(courseUnitClass);
        } else {
          courseUnitsClasses[uc['occur_id']] = CourseUnitClasses(
              uc['name'], [courseUnitClass], uc['result'] != 'A');
        }
      }
    });
    return courseUnitsClasses.values.toList();
  }

  Future<void> saveCourseUnitsMaterials(List<CourseUnit> courseUnits,
      List<CourseUnitMaterials> courseUnitsMaterials) async {
    final Database database = await this.getDatabase();
    await database.transaction((transaction) async {
      await _deleteUcsMaterials(transaction);
      courseUnitsMaterials.forEach((courseUnitMaterials) async {
        final courseUnit = courseUnits.firstWhere(
            (element) => element.name == courseUnitMaterials.courseName,
            orElse: null);
        if (courseUnit == null) {
          return;
        }
        await _insertCourseUnitMaterials(
            transaction, courseUnit, courseUnitMaterials);
      });
    });
  }

  Future<void> _insertCourseUnitMaterials(Transaction transaction,
      CourseUnit courseUnit, CourseUnitMaterials courseUnitMaterials) async {
    await transaction.insert('uc_materials', {
      'uc_occur_id': courseUnit.occurrId,
      'zip_url': courseUnitMaterials.zipUrl
    });
  }

  Future<List<CourseUnitMaterials>> getCourseUnitsMaterials() async {
    final Database database = await this.getDatabase();
    final List<CourseUnitMaterials> courseUnitsMaterials = [];
    await database.transaction((transaction) async {
      final ucsMaterials = await transaction.query('uc_materials');
      for (final ucMaterials in ucsMaterials) {
        final uc = (await transaction.query('ucs',
            where: 'occur_id = ?', whereArgs: [ucMaterials['uc_occur_id']]))[0];
        final String zipUrl = ucMaterials['zip_url'];
        courseUnitsMaterials
            .add(CourseUnitMaterials(uc['name'], zipUrl, uc['result'] != 'A'));
      }
    });
    return courseUnitsMaterials;
  }

  Future<void> saveCourseUnitsSheets(List<CourseUnit> courseUnits,
      List<CourseUnitSheet> courseUnitsSheets) async {
    final Database database = await this.getDatabase();
    await database.transaction((transaction) async {
      await _deleteUcsSheets(transaction);
      courseUnitsSheets.forEach((courseUnitSheets) async {
        final courseUnit = courseUnits.firstWhere(
            (element) => element.name == courseUnitSheets.courseName,
            orElse: null);
        if (courseUnit == null) {
          return;
        }
        await _insertCourseUnitSheet(transaction, courseUnit, courseUnitSheets);
      });
    });
  }

  Future<void> _insertCourseUnitSheet(Transaction transaction,
      CourseUnit courseUnit, CourseUnitSheet courseUnitSheet) async {
    await transaction.insert(
        'uc_sheets', courseUnitSheet.toMap(courseUnit.occurrId));
    for (final evalComponent in courseUnitSheet.evaluationComponents) {
      await transaction.insert(
          'uc_evaluation_components', evalComponent.toMap(courseUnit.occurrId));
    }
    for (final teacher in courseUnitSheet.teachers) {
      await transaction.insert(
          'uc_teachers', teacher.toMap(courseUnit.occurrId));
    }
  }

  Future<List<CourseUnitSheet>> getCourseUnitsSheets() async {
    final Database database = await this.getDatabase();
    final List<CourseUnitSheet> courseUnitsSheets = [];
    await database.transaction((transaction) async {
      final ucsSheets = await transaction.query('uc_sheets');
      for (final ucSheet in ucsSheets) {
        final classTeachers = await transaction.query('uc_teachers',
            where: 'uc_occur_id = ?', whereArgs: [ucSheet['uc_occur_id']]);
        final List<CourseUnitTeacher> teachers = [];
        for (final teacher in classTeachers) {
          teachers.add(CourseUnitTeacher.fromMap(teacher));
        }

        final classEvalComponents = await transaction.query(
            'uc_evaluation_components',
            where: 'uc_occur_id = ?',
            whereArgs: [ucSheet['uc_occur_id']]);
        final List<CourseUnitEvaluationComponent> evalComponents = [];
        for (final evalComponent in classEvalComponents) {
          evalComponents
              .add(CourseUnitEvaluationComponent.fromMap(evalComponent));
        }

        final uc = (await transaction.query('ucs',
            where: 'occur_id = ?', whereArgs: [ucSheet['uc_occur_id']]))[0];
        courseUnitsSheets.add(CourseUnitSheet(uc['name'], ucSheet['goals'],
            ucSheet['program'], evalComponents, teachers, uc['result'] != 'A'));
      }
    });

    return courseUnitsSheets;
  }

  Future<void> deleteAll(Transaction transaction) async {
    await _deleteUcsClasses(transaction);
    await _deleteUcsMaterials(transaction);
    await _deleteUcsSheets(transaction);
    await _deleteUcs(transaction);
  }

  Future<void> _deleteUcs(Transaction transaction) async {
    await transaction.delete('ucs');
  }

  Future<void> _deleteUcsClasses(Transaction transaction) async {
    await transaction.delete('uc_students');
    await transaction.delete('uc_classes');
  }

  Future<void> _deleteUcsMaterials(Transaction transaction) async {
    await transaction.delete('uc_materials');
  }

  Future<void> _deleteUcsSheets(Transaction transaction) async {
    await transaction.delete('uc_teachers');
    await transaction.delete('uc_evaluation_components');
    await transaction.delete('uc_sheets');
  }
}
