class Restaurant {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final String cuisine;
  final String deliveryTime;
  final double deliveryFee;
  final double minimumOrder;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      cuisine: json['cuisine'] ?? '',
      deliveryTime: json['deliveryTime'] ?? '',
      deliveryFee: (json['deliveryFee'] ?? 0.0).toDouble(),
      minimumOrder: (json['minimumOrder'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'rating': rating,
      'cuisine': cuisine,
      'deliveryTime': deliveryTime,
      'deliveryFee': deliveryFee,
      'minimumOrder': minimumOrder,
    };
  }
} 