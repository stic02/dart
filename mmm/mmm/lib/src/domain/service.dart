import 'identity.dart';

class Service implements Identity {
  @override
  final int? id;
  final String name;
  final double price;
  final int durationMinutes;
  final int tattooTypeId;

  const Service({
    this.id,
    required this.name,
    required this.price,
    required this.durationMinutes,
    required this.tattooTypeId,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'duration_minutes': durationMinutes,
      'tattoo_type_id': tattooTypeId,
    };
  }

  static Service fromMap(Map<String, Object?> map) {
    return Service(
      id: map['id'] as int?,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      durationMinutes: map['duration_minutes'] as int,
      tattooTypeId: map['tattoo_type_id'] as int,
    );
  }

  @override
  String toString() => '$name - ${price} руб. (${durationMinutes} мин)';
}