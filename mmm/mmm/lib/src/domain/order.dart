import 'identity.dart';

class Order implements Identity {
  @override
  final int? id;
  final int clientId;
  final int employeeId;
  final int serviceId;
  final DateTime orderDate;
  final String? status;
  final double? finalPrice;

  const Order({
    this.id,
    required this.clientId,
    required this.employeeId,
    required this.serviceId,
    required this.orderDate,
    this.status,
    this.finalPrice,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'client_id': clientId,
      'employee_id': employeeId,
      'service_id': serviceId,
      'order_date': orderDate.toIso8601String(),
      'status': status,
      'final_price': finalPrice,
    };
  }

  static Order fromMap(Map<String, Object?> map) {
    return Order(
      id: map['id'] as int?,
      clientId: map['client_id'] as int,
      employeeId: map['employee_id'] as int,
      serviceId: map['service_id'] as int,
      orderDate: DateTime.parse(map['order_date'] as String),
      status: map['status'] as String?,
      finalPrice: map['final_price'] as double?,
    );
  }

  @override
  String toString() => 'заказ #$id от ${orderDate.toLocal()}';
}