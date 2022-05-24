import 'package:sqflite/sqflite.dart';
import 'package:uni/controller/local_storage/app_database.dart';
import 'package:uni/model/entities/course_units/course_unit_student.dart';

import '../../../model/entities/course_units/course_unit.dart';
import '../../../model/entities/course_units/course_unit_class.dart';
import '../../../model/entities/course_units/course_unit_classes.dart';

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
        '''
        ]);

  Future<void> saveCourseUnits(List<CourseUnit> courseUnits) async {
    final Database database = await this.getDatabase();
    await database.transaction((txn) async {
      await _deleteUcs(txn);
      courseUnits.forEach((restaurant) {
        _insertCourseUnit(txn, restaurant);
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
    await database.transaction((txn) async {
      final ucsMap = await txn.query('ucs');
      ucsMap.forEach((entry) {
        courseUnits.add(CourseUnit.fromMap(entry));
      });
    });
    return courseUnits;
  }

  Future<void> saveCourseUnitsClasses(List<CourseUnit> courseUnits,
      List<CourseUnitClasses> courseUnitsClasses) async {
    final Database database = await this.getDatabase();
    await database.transaction((txn) async {
      await _deleteUcsClasses(txn);
      courseUnitsClasses.forEach((courseUnitClasses) async {
        final courseUnit = courseUnits.firstWhere(
            (element) => element.name == courseUnitClasses.courseName,
            orElse: null);
        if (courseUnit == null) {
          return;
        }
        await _insertCourseUnitClasses(txn, courseUnit, courseUnitClasses);
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
    final Map<String, CourseUnitClasses> courseUnitsClasses = {};
    await database.transaction((txn) async {
      final ucsClassesMap = await txn.query('uc_classes');
      for (final ucClassesMap in ucsClassesMap) {
        final uc = (await txn.query('ucs',
            where: 'occur_id = ?',
            whereArgs: [ucClassesMap['uc_occur_id']]))[0];
        final className = ucClassesMap['name'];
        final int classId = ucClassesMap['id'];
        final classStudents = await txn.query('uc_students',
            where: 'uc_class_id = ?', whereArgs: [classId]);
        final List<CourseUnitStudent> students = [];
        for (final studentMap in classStudents) {
          students.add(CourseUnitStudent.fromMap(studentMap));
        }

        final courseUnitClass = CourseUnitClass(className, students);
        if (courseUnitsClasses.containsKey(uc['occur_id'])) {
          courseUnitsClasses[uc['occur_id']].classes.add(courseUnitClass);
        } else {
          courseUnitsClasses[uc['occur_id']] = CourseUnitClasses(
              uc['occur_id'], [courseUnitClass], uc['result'] != 'A');
        }
      }
    });
    return courseUnitsClasses.values.toList();
  }

  Future<void> deleteAll(Transaction transaction) async {
    await _deleteUcs(transaction);
    await _deleteUcsClasses(transaction);
  }

  Future<void> _deleteUcs(Transaction transaction) async {
    await transaction.delete('ucs');
  }

  Future<void> _deleteUcsClasses(Transaction transaction) async {
    await transaction.delete('uc_classes');
    await transaction.delete('uc_students');
  }
}
