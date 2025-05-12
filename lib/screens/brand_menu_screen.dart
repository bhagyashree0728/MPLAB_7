import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import '../models/food_item_model.dart';
import '../services/cart_service.dart';
import 'food_details_screen.dart';

class BrandMenuScreen extends StatelessWidget {
  final String brandName;
  final String brandImage;
  final double rating;
  final String deliveryTime;

  final List<Map<String, dynamic>> menuItems;
  final String category;

  const BrandMenuScreen({
    Key? key,
    required this.brandName,
    required this.brandImage,
    required this.rating,
    required this.deliveryTime,
    required this.menuItems,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          // Brand Header
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    brandImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.surfaceDark,
                        child: const Icon(
                          Icons.image_not_supported,
                          color: AppTheme.goldenYellow,
                          size: 48,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                brandName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Category Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.goldenYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.white, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              deliveryTime,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Menu Items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = menuItems[index];
                return GestureDetector(
                  onTap: () {
                    // Convert menu item to FoodItem and navigate to details
                    final foodItem = FoodItem(
                      id: '$index',
                      name: item['name'],
                      description: item['description'],
                      price: item['price'],
                      imageUrl: item['imageUrl'],
                      rating: item['rating'],
                      category: category,
                      ingredients: [], // Add ingredients if available
                      isAvailable: true,
                    );
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodDetailsScreen(
                          foodItem: foodItem,
                          brandName: brandName,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
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
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(16),
                          ),
                          child: Image.network(
                            item['imageUrl'],
                            width: 120,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 120,
                                height: 120,
                                color: AppTheme.surfaceDark,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: AppTheme.goldenYellow,
                                ),
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['description'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '\$${item['price'].toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: AppTheme.goldenYellow,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Consumer<CartService>(
                                      builder: (context, cartService, child) {
                                        final isInCart = cartService.isItemInCart('$index');
                                        return Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: isInCart 
                                                ? AppTheme.goldenYellow.withOpacity(0.2)
                                                : AppTheme.goldenYellow,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Icon(
                                            isInCart ? Icons.check : Icons.add_shopping_cart,
                                            color: isInCart ? AppTheme.goldenYellow : Colors.white,
                                            size: 20,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate(
                  delay: Duration(milliseconds: index * 100),
                  effects: const [
                    FadeEffect(duration: Duration(milliseconds: 400)),
                    SlideEffect(
                      begin: Offset(0.2, 0),
                      end: Offset(0, 0),
                      duration: Duration(milliseconds: 400),
                    ),
                  ],
                );
              },
              childCount: menuItems.length,
            ),
          ),
        ],
      ),
    );
  }
} 
