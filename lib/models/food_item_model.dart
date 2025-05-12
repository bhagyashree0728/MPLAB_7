class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;
  final List<String> ingredients;
  final bool isAvailable;

  FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
    required this.ingredients,
    this.isAvailable = true,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      category: json['category'] ?? '',
      ingredients: List<String>.from(json['ingredients'] ?? []),
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'category': category,
      'ingredients': ingredients,
      'isAvailable': isAvailable,
    };
  }
} 