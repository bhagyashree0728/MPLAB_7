import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../constants/theme.dart';
import '../models/food_item_model.dart';

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final bool isInCart;
  final int quantity;
  final VoidCallback onAddToCart;
  final VoidCallback onIncrementQuantity;
  final VoidCallback onDecrementQuantity;

  const FoodCard({
    super.key,
    required this.foodItem,
    required this.isInCart,
    required this.quantity,
    required this.onAddToCart,
    required this.onIncrementQuantity,
    required this.onDecrementQuantity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show food details
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => _buildFoodDetails(context),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceDark,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.asset(
                    foodItem.imageUrl,
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 120,
                        color: AppTheme.lightBlue,
                        child: const Icon(Icons.error),
                      );
                    },
                  ),
                  if (!foodItem.isAvailable)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: Text(
                          'Out of Stock',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foodItem.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: foodItem.rating,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppTheme.goldenYellow,
                        ),
                        itemCount: 5,
                        itemSize: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        foodItem.rating.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${foodItem.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.goldenYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (foodItem.isAvailable)
                        isInCart
                            ? _buildQuantityControls()
                            : _buildAddButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
      onPressed: onAddToCart,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: const Text('Add'),
    );
  }

  Widget _buildQuantityControls() {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 16),
            onPressed: onDecrementQuantity,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              quantity.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 16),
            onPressed: onIncrementQuantity,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            iconSize: 16,
          ),
        ],
      ),
    );
  }

  Widget _buildFoodDetails(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceDark,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppTheme.textSecondary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          foodItem.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: AppTheme.lightBlue,
                              child: const Icon(Icons.error),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              foodItem.name,
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          Text(
                            '\$${foodItem.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: AppTheme.goldenYellow,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: foodItem.rating,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: AppTheme.goldenYellow,
                            ),
                            itemCount: 5,
                            itemSize: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            foodItem.rating.toString(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '(${foodItem.category})',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Description',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        foodItem.description,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Ingredients',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: foodItem.ingredients.map((ingredient) {
                          return Chip(
                            label: Text(ingredient),
                            backgroundColor: AppTheme.lightBlue,
                            labelStyle: TextStyle(
                              color: AppTheme.darkPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                      if (foodItem.isAvailable)
                        isInCart
                            ? Row(
                                children: [
                                  Expanded(
                                    child: _buildQuantityControls(),
                                  ),
                                  const SizedBox(width: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.goldenYellow,
                                      foregroundColor: AppTheme.darkPurple,
                                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Done',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  onAddToCart();
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.goldenYellow,
                                  foregroundColor: AppTheme.darkPurple,
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 