import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/student.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  DatabaseHelper._internal();

  static DatabaseHelper? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<DatabaseHelper> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'students.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            rollNumber TEXT,
            email TEXT
          )
        ''');
      },
    );
  }

  Future<int> addStudent(Student student) async {
    final db = await database;
    return await db.insert('students', student.toMap());
  }

  Future<List<Student>> fetchStudents() async {
    final db = await database;
    final result = await db.query('students');
    return result.map((map) => Student.fromMap(map)).toList();
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return await db.delete('students', where: 'id = ?', whereArgs: [id]);
  }
}

getDatabasesPath() {
}

openDatabase(String path, {required int version, required Future<Null>
Function(dynamic db, dynamic version) onCreate}) {
}
