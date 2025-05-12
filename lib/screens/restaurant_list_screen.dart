import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/theme.dart';
import 'restaurant_screen.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  static final List<Map<String, dynamic>> restaurants = [
    {
      'name': 'Le Petit Bistro',
      'cuisine': 'French',
      'imageUrl': 'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c',
      'rating': 4.8,
      'deliveryTime': '30-45 min',
      'deliveryFee': 5.99,
      'minOrder': 20.00,
      'distance': '1.2 km',
    },
    {
      'name': 'Sakura Japanese',
      'cuisine': 'Japanese',
      'imageUrl': 'https://images.unsplash.com/photo-1580442151529-343f2f6e0e27',
      'rating': 4.7,
      'deliveryTime': '25-40 min',
      'deliveryFee': 4.99,
      'minOrder': 15.00,
      'distance': '0.8 km',
    },
    {
      'name': 'Tuscany Trattoria',
      'cuisine': 'Italian',
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4',
      'rating': 4.9,
      'deliveryTime': '35-50 min',
      'deliveryFee': 6.99,
      'minOrder': 25.00,
      'distance': '1.5 km',
    },
    {
      'name': 'The Grill House',
      'cuisine': 'Steakhouse',
      'imageUrl': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b',
      'rating': 4.8,
      'deliveryTime': '40-55 min',
      'deliveryFee': 7.99,
      'minOrder': 30.00,
      'distance': '2.5 km',
    },
    // Add more restaurants here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: const Text('Popular Restaurants'),
        centerTitle: true,
        backgroundColor: AppTheme.surfaceDark,
        elevation: 0,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return GestureDetector(
            onTap: () {
              // Navigate to restaurant details
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RestaurantScreen(
                    restaurant: {
                      'name': restaurant['name'] as String,
                      'cuisine': restaurant['cuisine'] as String,
                      'image': restaurant['imageUrl'] as String,
                      'rating': restaurant['rating'].toString(),
                    },
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppTheme.surfaceDark,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                        Image.network(
                          restaurant['imageUrl'] as String,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: AppTheme.goldenYellow,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  restaurant['rating'].toString(),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          restaurant['name'] as String,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          restaurant['cuisine'] as String,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.white.withOpacity(0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant['deliveryTime'] as String,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
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
            ),
          );
        },
      ),
    );
  }
} 