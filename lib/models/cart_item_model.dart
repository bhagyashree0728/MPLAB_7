import 'food_item_model.dart';

class CartItem {
  final String id;
  final FoodItem foodItem;
  int quantity;

  CartItem({
    required this.id,
    required this.foodItem,
    this.quantity = 1,
  });

  double get totalPrice => foodItem.price * quantity;

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      foodItem: FoodItem.fromJson(json['foodItem'] ?? {}),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodItem': foodItem.toJson(),
      'quantity': quantity,
    };
  }
} 