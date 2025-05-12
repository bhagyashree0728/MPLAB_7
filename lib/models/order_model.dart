import 'cart_item_model.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  delivered,
  cancelled
}

class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final OrderStatus status;
  final DateTime date;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.date,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      items: (json['items'] as List?)
              ?.map((item) => CartItem.fromJson(item))
              .toList() ??
          [],
      totalAmount: (json['totalAmount'] ?? 0.0).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.toString() == 'OrderStatus.${json['status']}',
        orElse: () => OrderStatus.pending,
      ),
      date: DateTime.parse(json['date'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'status': status.toString().split('.').last,
      'date': date.toIso8601String(),
    };
  }
} 