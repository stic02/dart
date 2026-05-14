import 'identity.dart';

class Client implements Identity {
  @override
  final int? id;
  final String name;
  final String phone;
  final String? email;

  const Client({
    this.id,
    required this.name,
    required this.phone,
    this.email,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
    };
  }

  static Client fromMap(Map<String, Object?> map) {
    return Client(
      id: map['id'] as int?,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String?,
    );
  }

  @override
  String toString() => '$name (тел: $phone)';
}