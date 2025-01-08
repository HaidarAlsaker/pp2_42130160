import 'package:flutter/material.dart';
import 'screens/dashboard.dart';

void main() {
  runApp(const StudentManagementSystem());
}

class StudentManagementSystem extends StatelessWidget {
  const StudentManagementSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}
