import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderService extends ChangeNotifier {
  List<Order> _orders = [];
  bool _isLoading = false;
  String? _error;

  List<Order> get orders => List.unmodifiable(_orders);
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Order> get activeOrders => _orders
      .where((order) =>
          order.status != OrderStatus.delivered &&
          order.status != OrderStatus.cancelled)
      .toList();

  List<Order> get pastOrders => _orders
      .where((order) =>
          order.status == OrderStatus.delivered ||
          order.status == OrderStatus.cancelled)
      .toList();

  OrderService() {
    _loadOrdersFromPrefs();
  }

  Future<void> _loadOrdersFromPrefs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getString('orders');
      if (ordersJson != null) {
        final List<dynamic> ordersData = json.decode(ordersJson);
        _orders = ordersData.map((order) => Order.fromJson(order)).toList();
      }
    } catch (e) {
      _error = 'Failed to load orders: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveOrdersToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersData = _orders.map((order) => order.toJson()).toList();
      await prefs.setString('orders', json.encode(ordersData));
    } catch (e) {
      _error = 'Failed to save orders: $e';
      notifyListeners();
    }
  }

  void addOrder(Order order) {
    _orders.add(order);
    _saveOrdersToPrefs();
    notifyListeners();
  }

  List<Order> getOrdersByUser(String userId) {
    return _orders.where((order) => order.userId == userId).toList();
  }

  Future<bool> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      final index = _orders.indexWhere((order) => order.id == orderId);
      if (index != -1) {
        final updatedOrder = Order(
          id: _orders[index].id,
          userId: _orders[index].userId,
          items: _orders[index].items,
          totalAmount: _orders[index].totalAmount,
          status: status,
          date: _orders[index].date,
        );
        _orders[index] = updatedOrder;
        await _saveOrdersToPrefs();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _error = 'Failed to update order status: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> placeOrder({
    required String userId,
    required List<CartItem> items,
    required double totalAmount,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // In a real app, you would make an API call to place the order
      // For this example, we'll simulate a successful order placement
      await Future.delayed(const Duration(seconds: 1));
      
      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        items: items,
        totalAmount: totalAmount,
        status: OrderStatus.pending,
        date: DateTime.now(),
      );
      
      _orders.add(order);
      await _saveOrdersToPrefs();
      
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Order? getOrderById(String orderId) {
    try {
      return _orders.firstWhere((order) => order.id == orderId);
    } catch (e) {
      return null;
    }
  }
} 