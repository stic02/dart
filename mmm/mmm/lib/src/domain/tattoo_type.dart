import 'identity.dart';

class TattooType implements Identity {
  @override
  final int? id;
  final String name;
  final String? style;

  const TattooType({
    this.id,
    required this.name,
    this.style,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'style': style,
    };
  }

  static TattooType fromMap(Map<String, Object?> map) {
    return TattooType(
      id: map['id'] as int?,
      name: map['name'] as String,
      style: map['style'] as String?,
    );
  }

  @override
  String toString() => name;
}