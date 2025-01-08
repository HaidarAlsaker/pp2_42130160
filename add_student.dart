import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/database_helper.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _rollController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final student = Student(
        name: _nameController.text,
        rollNumber: _rollController.text,
        email: _emailController.text,
      );
      await _dbHelper.addStudent(student);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              TextFormField(
                controller: _rollController,
                decoration: const InputDecoration(labelText: 'Roll Number'),
                validator: (value) => value!.isEmpty ? 'Please enter roll number' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
