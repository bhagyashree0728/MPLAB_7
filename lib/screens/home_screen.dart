import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/food_service.dart';
import '../services/cart_service.dart';
import '../services/restaurant_service.dart';
import '../widgets/food_card.dart';
import '../models/food_item_model.dart';
import '../models/restaurant_model.dart';
import '../constants/theme.dart';
import '../widgets/category_card.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/location_selector.dart';
import 'food_details_screen.dart';
import 'cart_screen.dart';
import 'popular_items_screen.dart';
import 'profile_screen.dart';
import 'brand_menu_screen.dart';
import 'restaurant_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  final ScrollController _scrollController = ScrollController();

  // Sample food items
  final List<FoodItem> _sampleFoodItems = [
    FoodItem(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic pizza with tomato sauce, mozzarella, and basil',
      price: 12.99,
      imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.5,
      category: 'Pizza',
      ingredients: ['Tomato sauce', 'Mozzarella cheese', 'Fresh basil', 'Olive oil'],
      isAvailable: true,
    ),
    FoodItem(
      id: '2',
      name: 'Spaghetti Carbonara',
      description: 'Classic Italian pasta with eggs, cheese, pancetta, and black pepper',
      price: 14.99,
      imageUrl: 'https://images.unsplash.com/photo-1551892374-ecfafc8f7c5a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.7,
      category: 'Pasta',
      ingredients: ['Spaghetti', 'Eggs', 'Parmesan cheese', 'Pancetta', 'Black pepper'],
      isAvailable: true,
    ),
    FoodItem(
      id: '3',
      name: 'Chicken Tikka Masala',
      description: 'Grilled chicken chunks in spiced curry sauce',
      price: 16.99,
      imageUrl: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.8,
      category: 'Indian',
      ingredients: ['Chicken', 'Yogurt', 'Spices', 'Cream', 'Tomatoes'],
      isAvailable: true,
    ),
    FoodItem(
      id: '4',
      name: 'California Roll',
      description: 'Sushi roll with crab, avocado, and cucumber',
      price: 11.99,
      imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.6,
      category: 'Sushi',
      ingredients: ['Crab', 'Avocado', 'Cucumber', 'Rice', 'Nori'],
      isAvailable: true,
    ),
    FoodItem(
      id: '5',
      name: 'Chocolate Lava Cake',
      description: 'Warm chocolate cake with a molten center',
      price: 8.99,
      imageUrl: 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.9,
      category: 'Dessert',
      ingredients: ['Chocolate', 'Butter', 'Eggs', 'Sugar', 'Flour'],
      isAvailable: true,
    ),
    FoodItem(
      id: '6',
      name: 'Caesar Salad',
      description: 'Classic salad with romaine lettuce, croutons, and Caesar dressing',
      price: 9.99,
      imageUrl: 'https://images.unsplash.com/photo-1549411296-3c8c0b0c1c1a?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      rating: 4.4,
      category: 'Salad',
      ingredients: ['Romaine lettuce', 'Croutons', 'Parmesan cheese', 'Caesar dressing', 'Anchovies'],
      isAvailable: true,
    ),
  ];

  // Sample brands data
  final List<Map<String, dynamic>> _topBrands = [
    {
      'name': 'Domino\'s Pizza',
      'imageUrl': 'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      'rating': 4.3,
      'deliveryTime': '25-35 min',
      'category': 'Pizza',
      'menu': [
        {
          'name': 'Margherita Pizza',
          'description': 'Classic tomato sauce, mozzarella, and basil',
          'price': 12.99,
          'imageUrl': 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80',
          'rating': 4.5,
        },
        {
          'name': 'Pepperoni Pizza',
          'description': 'Tomato sauce, mozzarella, and spicy pepperoni',
          'price': 14.99,
          'imageUrl': 'https://images.unsplash.com/photo-1628840042765-356cda07504e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
          'rating': 4.7,
        },
        {
          'name': 'BBQ Chicken Pizza',
          'description': 'BBQ sauce, chicken, red onions, and cilantro',
          'price': 16.99,
          'imageUrl': 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1481&q=80',
          'rating': 4.6,
        },
      ],
    },
    {
      'name': 'Starbucks',
      'imageUrl': 'https://images.unsplash.com/photo-1504753793650-d4a2b783c15e?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
      'rating': 4.5,
      'deliveryTime': '20-30 min',
      'category': 'Coffee & Beverages',
      'menu': [
        {
          'name': 'Caramel Frappuccino',
          'description': 'Blended coffee with caramel syrup and whipped cream',
          'price': 5.99,
          'imageUrl': 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1469&q=80',
          'rating': 4.8,
        },
        {
          'name': 'Vanilla Latte',
          'description': 'Espresso with steamed milk and vanilla syrup',
          'price': 4.99,
          'imageUrl': 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
          'rating': 4.6,
        },
        {
          'name': 'Chocolate Cookie Frappuccino',
          'description': 'Blended chocolate cookie cream with whipped cream',
          'price': 6.49,
          'imageUrl': 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1487&q=80',
          'rating': 4.7,
        },
      ],
    },
    {
      'name': 'McDonald\'s',
      'imageUrl': 'https://images.unsplash.com/photo-1552895638-f7fe08d2f7d5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
      'rating': 4.2,
      'deliveryTime': '15-25 min',
      'category': 'Fast Food',
      'menu': [
        {
          'name': 'Big Mac',
          'description': 'Classic double-decker burger with special sauce',
          'price': 6.99,
          'imageUrl': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1602&q=80',
          'rating': 4.5,
        },
        {
          'name': 'McNuggets',
          'description': 'Crispy chicken nuggets with your choice of sauce',
          'price': 5.99,
          'imageUrl': 'https://images.unsplash.com/photo-1585922676507-aa3e744e1d1c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
          'rating': 4.4,
        },
      ],
    },
  ];

  // Add the data lists here
  final List<Map<String, dynamic>> _popularItems = [
    {
      'name': 'Truffle Burger',
      'description': 'Premium beef patty with truffle mayo, caramelized onions, and aged cheddar',
      'price': 18.99,
      'imageUrl': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1480&q=80',
      'rating': 4.8,
      'category': 'Burgers',
    },
    {
      'name': 'Dragon Sushi Roll',
      'description': 'Fresh salmon, avocado, and cucumber topped with unagi sauce',
      'price': 16.99,
      'imageUrl': 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80',
      'rating': 4.7,
      'category': 'Japanese',
    },
    {
      'name': 'Truffle Pizza',
      'description': 'Black truffle, mushrooms, mozzarella, and arugula',
      'price': 24.99,
      'imageUrl': 'https://images.unsplash.com/photo-1604068549290-dea0e4a305ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80',
      'rating': 4.9,
      'category': 'Pizza',
    },
    {
      'name': 'Wagyu Steak',
      'description': 'Premium Japanese A5 wagyu beef with truffle butter',
      'price': 89.99,
      'imageUrl': 'https://images.unsplash.com/photo-1546241072-48010ad2862c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1473&q=80',
      'rating': 4.9,
      'category': 'Steak',
    },
    {
      'name': 'Tiramisu',
      'description': 'Classic Italian dessert with coffee-soaked ladyfingers',
      'price': 9.99,
      'imageUrl': 'https://images.unsplash.com/photo-1565117661210-fd54898de423?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'rating': 4.7,
      'category': 'Dessert',
    },
  ];

  final List<Map<String, dynamic>> _popularRestaurants = [
    {
      'name': 'Le Petit Bistro',
      'cuisine': 'French',
      'imageUrl': 'https://images.unsplash.com/photo-1550966871-3ed3cdb5ed0c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      'rating': 4.8,
      'deliveryTime': '30-45 min',
      'deliveryFee': 5.99,
      'minOrder': 20.00,
      'distance': '1.2 km',
    },
    {
      'name': 'Sakura Japanese',
      'cuisine': 'Japanese',
      'imageUrl': 'https://images.unsplash.com/photo-1580442151529-343f2f6e0e27?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      'rating': 4.7,
      'deliveryTime': '25-40 min',
      'deliveryFee': 4.99,
      'minOrder': 15.00,
      'distance': '0.8 km',
    },
    {
      'name': 'Tuscany Trattoria',
      'cuisine': 'Italian',
      'imageUrl': 'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      'rating': 4.9,
      'deliveryTime': '35-50 min',
      'deliveryFee': 6.99,
      'minOrder': 25.00,
      'distance': '1.5 km',
    },
    {
      'name': 'The Grill House',
      'cuisine': 'Steakhouse',
      'imageUrl': 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1474&q=80',
      'rating': 4.8,
      'deliveryTime': '40-55 min',
      'deliveryFee': 7.99,
      'minOrder': 30.00,
      'distance': '2.5 km',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          SafeArea(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // App Bar
                SliverAppBar(
                  floating: true,
                  backgroundColor: AppTheme.background,
                  expandedHeight: 80,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Delivering to',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.location_on,
                                          color: AppTheme.goldenYellow,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        const Text(
                                          'San Francisco, CA',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.white.withOpacity(0.7),
                                          size: 16,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const ProfileScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppTheme.surfaceDark,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: const Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Consumer<CartService>(
                                    builder: (context, cartService, child) {
                                      return Stack(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.shopping_cart_outlined,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => const CartScreen(),
                                                ),
                                              );
                                            },
                                          ),
                                          if (cartService.items.isNotEmpty)
                                            Positioned(
                                              right: 0,
                                              top: 0,
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: const BoxDecoration(
                                                  color: AppTheme.goldenYellow,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Text(
                                                  cartService.items.length.toString(),
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Content
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      _buildTopBrands(),
                      const SizedBox(height: 32),
                      _buildPopularItems(),
                      const SizedBox(height: 32),
                      _buildPopularRestaurants(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const FloatingSearchBar(),
        ],
      ),
    );
  }

  Widget _buildTopBrands() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Top Brands',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppTheme.goldenYellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _topBrands.length,
            itemBuilder: (context, index) {
              final brand = _topBrands[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BrandMenuScreen(
                        brandName: brand['name'],
                        brandImage: brand['imageUrl'],
                        rating: brand['rating'],
                        deliveryTime: brand['deliveryTime'],
                        menuItems: brand['menu'],
                        category: brand['category'],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background Image with error handling
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          brand['imageUrl'],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppTheme.surfaceDark,
                              child: const Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: AppTheme.goldenYellow,
                                  size: 48,
                                ),
                              ),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: AppTheme.surfaceDark,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppTheme.goldenYellow,
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),

                      // Content
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Brand Name
                              Text(
                                brand['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Rating and Delivery Time
                              Row(
                                children: [
                                  // Rating Badge
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
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
                                          brand['rating'].toString(),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Delivery Time
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
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
                                          brand['deliveryTime'],
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
        ),
      ],
    );
  }

  Widget _buildFeaturedItems(double cardWidth, double cardHeight) {
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _sampleFoodItems.length,
        itemBuilder: (context, index) {
          final foodItem = _sampleFoodItems[index];
          return Container(
            width: cardWidth,
            margin: const EdgeInsets.only(right: 16),
            child: _buildFoodItemCard(foodItem, cardHeight),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItems(double cardWidth, double cardHeight) {
    final categories = ['Pizza', 'Pasta', 'Indian', 'Sushi', 'Dessert', 'Salad'];
    return SizedBox(
      height: cardHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final categoryItems = _sampleFoodItems.where((item) => item.category == category).toList();
          if (categoryItems.isEmpty) return const SizedBox.shrink();
          
          return Container(
            width: cardWidth,
            margin: const EdgeInsets.only(right: 16),
            child: _buildFoodItemCard(categoryItems.first, cardHeight),
          );
        },
      ),
    );
  }

  Widget _buildFoodItemCard(FoodItem foodItem, double height) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceDark,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  foodItem.imageUrl,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 140,
                      color: AppTheme.surface,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.goldenYellow,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
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
                        foodItem.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  foodItem.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${foodItem.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldenYellow,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppTheme.goldenYellow,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildPopularItems() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Items',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PopularItemsScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppTheme.goldenYellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _popularItems.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _popularItems[index];
              return GestureDetector(
                onTap: () {
                  final foodItem = FoodItem(
                    id: index.toString(),
                    name: item['name'],
                    description: item['description'],
                    price: item['price'],
                    imageUrl: item['imageUrl'],
                    rating: item['rating'],
                    category: item['category'],
                    ingredients: ['Ingredient 1', 'Ingredient 2', 'Ingredient 3'],
                    isAvailable: true,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailsScreen(foodItem: foodItem),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                            child: Image.network(
                              item['imageUrl'],
                              height: 140,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.goldenYellow,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.star, color: Colors.white, size: 16),
                                  const SizedBox(width: 4),
                                  Text(
                                    item['rating'].toString(),
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
                      Padding(
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
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
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
                            const SizedBox(height: 12),
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
                                    final isInCart = cartService.isItemInCart(index.toString());
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
        ),
      ],
    );
  }

  Widget _buildPopularRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Restaurants',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RestaurantListScreen(),
                    ),
                  );
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppTheme.goldenYellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _popularRestaurants.length,
            itemBuilder: (BuildContext context, int index) {
              final restaurant = _popularRestaurants[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceDark,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            restaurant['imageUrl'],
                            height: 180,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.8),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  restaurant['cuisine'],
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                                      restaurant['rating'].toString(),
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
                                child: Text(
                                  restaurant['deliveryTime'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            restaurant['distance'],
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 14,
                            ),
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
              );
            },
          ),
        ),
      ],
    );
  }
} 