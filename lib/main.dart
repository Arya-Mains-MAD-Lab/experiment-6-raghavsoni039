import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
void main() => runApp(const MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DBPage(),
    );
  }
}
class DBPage extends StatefulWidget {
  const DBPage({super.key});
  @override
  State<DBPage> createState() => _DBPageState();
}
class _DBPageState extends State<DBPage> {
  late Database db;
  Future<void> initDB() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'student.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE student(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );

  }
  @override
  void initState() {
    super.initState();
    initDB();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Demo')),
      body: const Center(
        child: Text('Database Created Successfully'),
      ),
    );
  }
}

class Student {
  final int id;
  final String name;
  Student({required this.id,required this.name});
  Map<String , Object?> tomap(){
    return {'id' :id ,'name' : name};
  }
  @override
  String toString() {
    // TODO: implement toString
    return 'Student{id: $id ,name: $name}';
  }
  Future<void> insertStudent(Student student) async {
    final db = await db;
    await db.insert(
      'Student' , student.tomap(),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
  var raghav = Student(id: 101, name: 'raghav');
  await insertStudent
}
