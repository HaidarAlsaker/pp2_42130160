import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/database_helper.dart';
import 'add_student.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    final students = await _dbHelper.fetchStudents();
    setState(() {
      _students = students;
    });
  }

  void _deleteStudent(int id) async {
    await _dbHelper.deleteStudent(id);
    _fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Management'),
      ),
      body: ListView.builder(
        itemCount: _students.length,
        itemBuilder: (context, index) {
          final student = _students[index];
          return ListTile(
            title: Text(student.name),
            subtitle: Text(student.rollNumber),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteStudent(student.id!),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStudent()),
          ).then((_) => _fetchStudents());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
