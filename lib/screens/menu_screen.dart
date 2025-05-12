import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';
import '../models/food_item_model.dart';
import '../services/food_service.dart';
import '../services/cart_service.dart';
import '../widgets/food_card.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Consumer2<FoodService, CartService>(
      builder: (context, foodService, cartService, child) {
        final foodItems = foodService.getFoodItems();
        final categories = foodService.getCategories();

        // Filter items based on search query and selected category
        final filteredItems = foodItems.where((item) {
          final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.description.toLowerCase().contains(_searchQuery.toLowerCase());
          final matchesCategory = _selectedCategory == null || item.category == _selectedCategory;
          return matchesSearch && matchesCategory;
        }).toList();

        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                _buildSearchBar(),
                _buildCategoryFilter(categories),
                Expanded(
                  child: foodService.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : filteredItems.isEmpty
                          ? _buildEmptyState()
                          : _buildFoodGrid(filteredItems, cartService),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'Search food...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(List<String> categories) {
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          FilterChip(
            label: const Text('All'),
            selected: _selectedCategory == null,
            onSelected: (selected) {
              setState(() => _selectedCategory = null);
            },
          ),
          const SizedBox(width: 8),
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(category),
                selected: _selectedCategory == category,
                onSelected: (selected) {
                  setState(() => _selectedCategory = selected ? category : null);
                },
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No food items found',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodGrid(List<FoodItem> foodItems, CartService cartService) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        final foodItem = foodItems[index];
        final isInCart = cartService.isItemInCart(foodItem.id);
        final quantity = isInCart ? cartService.getItemQuantity(foodItem.id) : 0;

        return FoodCard(
          foodItem: foodItem,
          isInCart: isInCart,
          quantity: quantity,
          onAddToCart: () {
            cartService.addItem(foodItem);
            _showSnackBar('${foodItem.name} added to cart');
          },
          onIncrementQuantity: () {
            cartService.updateQuantity(foodItem.id, quantity + 1);
          },
          onDecrementQuantity: () {
            if (quantity > 1) {
              cartService.updateQuantity(foodItem.id, quantity - 1);
            } else {
              cartService.removeItem(foodItem.id);
              _showSnackBar('${foodItem.name} removed from cart');
            }
          },
        );
      },
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
} 