import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme.dart';
import '../services/cart_service.dart';
import '../models/food_item_model.dart';
import 'food_details_screen.dart';

class PopularItemsScreen extends StatelessWidget {
  const PopularItemsScreen({super.key});

  // Sample popular items data
  static final List<FoodItem> popularItems = [
    FoodItem(
      id: '1',
      name: 'Truffle Burger',
      description: 'Premium beef patty with truffle mayo, caramelized onions, and aged cheddar',
      price: 18.99,
      imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90',
      rating: 4.8,
      category: 'Burgers',
      ingredients: ['Premium beef', 'Truffle mayo', 'Caramelized onions', 'Aged cheddar', 'Brioche bun'],
      isAvailable: true,
    ),
    FoodItem(
      id: '2',
      name: 'Dragon Sushi Roll',
      description: 'Fresh salmon, avocado, and cucumber topped with unagi sauce',
      price: 16.99,
      imageUrl: 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351',
      rating: 4.7,
      category: 'Japanese',
      ingredients: ['Salmon', 'Avocado', 'Cucumber', 'Unagi sauce', 'Sushi rice', 'Nori'],
      isAvailable: true,
    ),
    FoodItem(
      id: '3',
      name: 'Truffle Pizza',
      description: 'Black truffle, mushrooms, mozzarella, and arugula',
      price: 24.99,
      imageUrl: 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca',
      rating: 4.9,
      category: 'Pizza',
      ingredients: ['Black truffle', 'Mushrooms', 'Mozzarella', 'Arugula', 'Pizza dough'],
      isAvailable: true,
    ),
    FoodItem(
      id: '4',
      name: 'Wagyu Steak',
      description: 'Premium Japanese A5 wagyu beef with truffle butter',
      price: 89.99,
      imageUrl: 'https://images.unsplash.com/photo-1546241072-48010ad2862c',
      rating: 4.9,
      category: 'Steak',
      ingredients: ['A5 Wagyu beef', 'Truffle butter', 'Sea salt', 'Black pepper'],
      isAvailable: true,
    ),
    FoodItem(
      id: '5',
      name: 'Lobster Pasta',
      description: 'Fresh lobster with homemade pasta in a creamy sauce',
      price: 32.99,
      imageUrl: 'https://images.unsplash.com/photo-1595295333158-4742f28fbd85',
      rating: 4.8,
      category: 'Pasta',
      ingredients: ['Fresh lobster', 'Homemade pasta', 'Cream sauce', 'Parmesan', 'Herbs'],
      isAvailable: true,
    ),
    FoodItem(
      id: '6',
      name: 'Matcha Tiramisu',
      description: 'Japanese-inspired tiramisu with matcha green tea',
      price: 9.99,
      imageUrl: 'https://images.unsplash.com/photo-1565117661210-fd54898de423?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      rating: 4.7,
      category: 'Dessert',
      ingredients: ['Matcha powder', 'Mascarpone', 'Ladyfingers', 'Coffee', 'Cream'],
      isAvailable: true,
    ),
    FoodItem(
      id: '7',
      name: 'Poke Bowl',
      description: 'Fresh tuna, salmon, avocado with sushi rice',
      price: 17.99,
      imageUrl: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c',
      rating: 4.6,
      category: 'Seafood',
      ingredients: ['Tuna', 'Salmon', 'Avocado', 'Sushi rice', 'Seaweed'],
      isAvailable: true,
    ),
    FoodItem(
      id: '8',
      name: 'BBQ Ribs',
      description: 'Slow-cooked BBQ ribs with special sauce',
      price: 26.99,
      imageUrl: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      rating: 4.8,
      category: 'BBQ',
      ingredients: ['Pork ribs', 'BBQ sauce', 'Spices', 'Herbs'],
      isAvailable: true,
    ),
    FoodItem(
      id: '9',
      name: 'Seafood Paella',
      description: 'Traditional Spanish paella with mixed seafood',
      price: 29.99,
      imageUrl: 'https://images.unsplash.com/photo-1534080564583-6be75777b70a',
      rating: 4.7,
      category: 'Spanish',
      ingredients: ['Mixed seafood', 'Saffron rice', 'Bell peppers', 'Peas', 'Spices'],
      isAvailable: true,
    ),
    FoodItem(
      id: '10',
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with molten center',
      price: 8.99,
      imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb',
      rating: 4.9,
      category: 'Dessert',
      ingredients: ['Dark chocolate', 'Butter', 'Eggs', 'Sugar', 'Flour'],
      isAvailable: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text(
          'Popular Items',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.background,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: popularItems.length,
        itemBuilder: (context, index) {
          final item = popularItems[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoodDetailsScreen(foodItem: item),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image and Rating
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                        child: Image.network(
                          item.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppTheme.goldenYellow,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.star, color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                item.rating.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          item.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${item.price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: AppTheme.goldenYellow,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Consumer<CartService>(
                              builder: (context, cartService, child) {
                                final isInCart = cartService.isItemInCart(item.id);
                                return ElevatedButton(
                                  onPressed: () {
                                    if (!isInCart) {
                                      cartService.addToCart(item);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('${item.name} added to cart'),
                                          backgroundColor: AppTheme.goldenYellow,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: isInCart 
                                        ? AppTheme.goldenYellow.withOpacity(0.2)
                                        : AppTheme.goldenYellow,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Text(
                                    isInCart ? 'Added to Cart' : 'Add to Cart',
                                    style: TextStyle(
                                      color: isInCart 
                                          ? AppTheme.goldenYellow
                                          : Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} 