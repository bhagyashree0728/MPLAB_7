import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item_model.dart';
import '../services/cart_service.dart';
import '../constants/theme.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FoodDetailsScreen extends StatelessWidget {
  final FoodItem foodItem;
  final String? brandName;

  const FoodDetailsScreen({
    Key? key,
    required this.foodItem,
    this.brandName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppTheme.background,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    foodItem.imageUrl,
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
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (brandName != null) ...[
                    Text(
                      brandName!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    foodItem.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.goldenYellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              foodItem.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppTheme.goldenYellow,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    foodItem.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  if (foodItem.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    Text(
                      'Ingredients',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: foodItem.ingredients.map((ingredient) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceDark,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            ingredient,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Consumer<CartService>(
          builder: (context, cartService, child) {
            final isInCart = cartService.isItemInCart(foodItem.id);
            return ElevatedButton(
              onPressed: () {
                if (isInCart) {
                  cartService.removeFromCart(foodItem.id);
                } else {
                  cartService.addToCart(foodItem);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isInCart 
                    ? AppTheme.goldenYellow.withOpacity(0.2)
                    : AppTheme.goldenYellow,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isInCart ? Icons.remove_shopping_cart : Icons.add_shopping_cart,
                    color: isInCart ? AppTheme.goldenYellow : Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isInCart ? 'Remove from Cart' : 'Add to Cart - \$${foodItem.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: isInCart ? AppTheme.goldenYellow : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ).animate(
              effects: [
                SlideEffect(
                  begin: const Offset(0, 1),
                  end: const Offset(0, 0),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOut,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
} 