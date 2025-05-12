import 'package:flutter/material.dart';
import '../models/restaurant_model.dart';

class RestaurantService extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  bool _isLoading = false;
  String? _error;

  List<Restaurant> get restaurants => _restaurants;
  bool get isLoading => _isLoading;
  String? get error => _error;

  RestaurantService() {
    _loadRestaurants();
  }

  Future<void> _loadRestaurants() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _restaurants = [
        Restaurant(
          id: '1',
          name: 'The Modern Kitchen',
          description: 'Contemporary cuisine with a focus on local ingredients',
          imageUrl: 'assets/images/restaurants/restaurant1.jpg',
          rating: 4.5,
          cuisine: 'Modern',
          deliveryTime: '30-40 min',
          deliveryFee: 2.99,
          minimumOrder: 15.00,
        ),
        Restaurant(
          id: '2',
          name: 'Cozy Corner',
          description: 'Comfort food in a warm, inviting atmosphere',
          imageUrl: 'assets/images/restaurants/restaurant2.jpg',
          rating: 4.3,
          cuisine: 'American',
          deliveryTime: '25-35 min',
          deliveryFee: 1.99,
          minimumOrder: 12.00,
        ),
        Restaurant(
          id: '3',
          name: 'Sunset Bistro',
          description: 'Mediterranean flavors with a view',
          imageUrl: 'assets/images/restaurants/restaurant3.jpg',
          rating: 4.7,
          cuisine: 'Mediterranean',
          deliveryTime: '35-45 min',
          deliveryFee: 3.99,
          minimumOrder: 18.00,
        ),
        Restaurant(
          id: '4',
          name: 'The Local Pub',
          description: 'Classic pub fare and craft beers',
          imageUrl: 'assets/images/restaurants/restaurant4.jpg',
          rating: 4.2,
          cuisine: 'Pub',
          deliveryTime: '20-30 min',
          deliveryFee: 2.49,
          minimumOrder: 10.00,
        ),
        Restaurant(
          id: '5',
          name: 'Chef\'s Table',
          description: 'Fine dining experience with seasonal menu',
          imageUrl: 'assets/images/restaurants/restaurant5.jpg',
          rating: 4.8,
          cuisine: 'Fine Dining',
          deliveryTime: '40-50 min',
          deliveryFee: 4.99,
          minimumOrder: 25.00,
        ),
      ];
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
} 