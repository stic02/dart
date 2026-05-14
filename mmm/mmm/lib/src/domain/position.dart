import 'identity.dart';

class Position implements Identity {
  @override
  final int? id;
  final String title;
  final String? description;

  const Position({
    this.id,
    required this.title,
    this.description,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  static Position fromMap(Map<String, Object?> map) {
    return Position(
      id: map['id'] as int?,
      title: map['title'] as String,
      description: map['description'] as String?,
    );
  }

  @override
  String toString() => title;
}