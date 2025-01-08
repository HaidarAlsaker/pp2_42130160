class Student {
  int? id; // Optional for auto-increment
  String name;
  String rollNumber;
  String email;

  Student({
    this.id,
    required this.name,
    required this.rollNumber,
    required this.email,
  });

  // Convert Student to Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'rollNumber': rollNumber,
      'email': email,
    };
  }

  // Convert Map to Student for SQLite
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      rollNumber: map['rollNumber'],
      email: map['email'],
    );
  }
}
