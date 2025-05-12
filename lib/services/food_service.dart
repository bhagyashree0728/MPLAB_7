import 'package:flutter/material.dart';
import '../models/food_item_model.dart';

class FoodService extends ChangeNotifier {
  List<FoodItem> _foodItems = [];
  bool _isLoading = false;
  String? _error;

  List<FoodItem> get foodItems => _foodItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FoodService() {
    _loadFoodItems();
  }

  Future<void> _loadFoodItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      
      _foodItems = [
        FoodItem(
          id: '1',
          name: 'Margherita Pizza',
          description: 'Classic pizza with tomato sauce, mozzarella, and basil',
          price: 12.99,
          imageUrl: 'assets/images/foods/pizza.jpg',
          rating: 4.5,
          category: 'Pizza',
          ingredients: ['Tomato sauce', 'Mozzarella', 'Basil', 'Olive oil'],
        ),
        FoodItem(
          id: '2',
          name: 'Chicken Burger',
          description: 'Juicy chicken patty with lettuce, tomato, and special sauce',
          price: 9.99,
          imageUrl: 'assets/images/foods/burger.jpg',
          rating: 4.2,
          category: 'Burger',
          ingredients: ['Chicken patty', 'Lettuce', 'Tomato', 'Special sauce', 'Bun'],
        ),
        FoodItem(
          id: '3',
          name: 'Caesar Salad',
          description: 'Fresh romaine lettuce with Caesar dressing, croutons, and parmesan',
          price: 8.99,
          imageUrl: 'assets/images/foods/salad.jpg',
          rating: 4.0,
          category: 'Salad',
          ingredients: ['Romaine lettuce', 'Caesar dressing', 'Croutons', 'Parmesan'],
        ),
        FoodItem(
          id: '4',
          name: 'Chocolate Cake',
          description: 'Rich chocolate cake with chocolate ganache',
          price: 6.99,
          imageUrl: 'assets/images/foods/cake.jpg',
          rating: 4.8,
          category: 'Dessert',
          ingredients: ['Chocolate', 'Flour', 'Sugar', 'Eggs', 'Butter'],
        ),
        FoodItem(
          id: '5',
          name: 'Sushi Roll',
          description: 'Fresh salmon and avocado roll with rice and nori',
          price: 14.99,
          imageUrl: 'assets/images/foods/sushi.jpg',
          rating: 4.6,
          category: 'Sushi',
          ingredients: ['Salmon', 'Avocado', 'Rice', 'Nori', 'Wasabi'],
        ),
        FoodItem(
          id: '6',
          name: 'Pasta Carbonara',
          description: 'Creamy pasta with pancetta, egg, and parmesan',
          price: 11.99,
          imageUrl: 'assets/images/foods/pasta.jpg',
          rating: 4.4,
          category: 'Pasta',
          ingredients: ['Spaghetti', 'Pancetta', 'Egg', 'Parmesan', 'Black pepper'],
        ),
        FoodItem(
          id: '7',
          name: 'Vegetable Stir Fry',
          description: 'Fresh vegetables stir-fried in a savory sauce',
          price: 10.99,
          imageUrl: 'assets/images/foods/stirfry.jpg',
          rating: 4.1,
          category: 'Asian',
          ingredients: ['Broccoli', 'Carrots', 'Bell peppers', 'Soy sauce', 'Ginger'],
        ),
        FoodItem(
          id: '8',
          name: 'Ice Cream Sundae',
          description: 'Vanilla ice cream with chocolate sauce, whipped cream, and cherry',
          price: 5.99,
          imageUrl: 'assets/images/foods/icecream.jpg',
          rating: 4.7,
          category: 'Dessert',
          ingredients: ['Vanilla ice cream', 'Chocolate sauce', 'Whipped cream', 'Cherry'],
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

  List<FoodItem> getFoodItems() {
    return _foodItems;
  }

  List<FoodItem> getFoodItemsByCategory(String category) {
    return _foodItems.where((item) => item.category == category).toList();
  }

  List<String> getCategories() {
    final categories = _foodItems.map((item) => item.category).toSet().toList();
    return categories;
  }

  FoodItem? getFoodItemById(String id) {
    try {
      return _foodItems.firstWhere((item) => item.id == id);
    } catch (e) {
      return null;
    }
  }

  List<FoodItem> searchFoodItems(String query) {
    if (query.isEmpty) return _foodItems;
    
    final lowercaseQuery = query.toLowerCase();
    return _foodItems.where((item) {
      return item.name.toLowerCase().contains(lowercaseQuery) ||
             item.description.toLowerCase().contains(lowercaseQuery) ||
             item.category.toLowerCase().contains(lowercaseQuery) ||
             item.ingredients.any((ingredient) => ingredient.toLowerCase().contains(lowercaseQuery));
    }).toList();
  }
} 