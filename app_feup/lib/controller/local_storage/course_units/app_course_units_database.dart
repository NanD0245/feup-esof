import 'package:sqflite/sqflite.dart';
import 'package:uni/controller/local_storage/app_database.dart';

import '../../../model/entities/course_units/course_unit.dart';

class AppCourseUnitsDatabase extends AppDatabase {
  AppCourseUnitsDatabase()
      : super('ucs.db', [
          '''CREATE TABLE ucs(
            occur_id INTEGER PRIMARY KEY,
            id INTEGER,
            code TEXT,
            abbreviation TEXT,
            name TEXT NOT NULL,
            curricular_year INT,
            semester_code TEXT,
            semester_name TEXT,
            type TEXT,
            status TEXT,
            ects_grade TEXT,
            ects TEXT,
            grade INTEGER
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
    database.transaction((txn) async {
      await deleteAll(txn);
      courseUnits.forEach((restaurant) {
        insertCourseUnit(txn, restaurant);
      });
    });
  }

  Future<void> insertCourseUnit(
      Transaction transaction, CourseUnit courseUnit) async {
    await transaction.insert('ucs', courseUnit.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CourseUnit>> getCourseUnits() async {
    final Database database = await this.getDatabase();
    final List<CourseUnit> courseUnits = [];
    await database.transaction((txn) async {
      final ucsMap = await database.query('ucs');
      ucsMap.forEach((entry) {
        courseUnits.add(CourseUnit.fromMap(entry));
      });
    });
    return courseUnits;
  }

  Future<void> deleteAll(Transaction transaction) async {
    await transaction.delete('ucs');
    await transaction.delete('ucs_classes');
    await transaction.delete('uc_students');
  }
}
