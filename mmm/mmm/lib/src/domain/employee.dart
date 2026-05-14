import 'identity.dart';

class Employee implements Identity {
  @override
  final int? id;
  final String name;
  final String phone;
  final int positionId;
  final double salary;

  const Employee({
    this.id,
    required this.name,
    required this.phone,
    required this.positionId,
    required this.salary,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'position_id': positionId,
      'salary': salary,
    };
  }

  static Employee fromMap(Map<String, Object?> map) {
    return Employee(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      positionId: map['position_id'] as int,
      salary: (map['salary'] as num).toDouble(),
    );
  }

  @override
  String toString() => '$name (тел: $phone)';
}