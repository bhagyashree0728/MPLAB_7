import 'package:flutter/foundation.dart';
import '../models/food_item_model.dart';

class CartService extends ChangeNotifier {
  final List<FoodItem> _items = [];
  final Map<String, int> _quantities = {};
  double _total = 0.0;

  List<FoodItem> get items => _items;
  double get total => _total;

  bool isItemInCart(String itemId) {
    return _items.any((cartItem) => cartItem.id == itemId);
  }

  int getItemQuantity(String itemId) {
    return _quantities[itemId] ?? 0;
  }

  void addItem(FoodItem item) {
    if (!isItemInCart(item.id)) {
      _items.add(item);
      _quantities[item.id] = 1;
    }
    _calculateTotal();
    notifyListeners();
  }

  void addToCart(FoodItem item) {
    if (!isItemInCart(item.id)) {
      _items.add(item);
      notifyListeners();
    }
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeItem(itemId);
      return;
    }
    
    _quantities[itemId] = quantity;
    _calculateTotal();
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    _quantities.remove(itemId);
    _calculateTotal();
    notifyListeners();
  }

  void removeFromCart(String itemId) {
    _items.removeWhere((item) => item.id == itemId);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _quantities.clear();
    _total = 0.0;
    notifyListeners();
  }

  void _calculateTotal() {
    _total = _items.fold(0.0, (sum, item) => sum + (item.price * (_quantities[item.id] ?? 1)));
  }

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + item.price);
  }
} 