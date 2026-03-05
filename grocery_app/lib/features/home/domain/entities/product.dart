import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final double? discount;
  final bool isFeatured;
  final String? badge;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    this.discount,
    this.isFeatured = false,
    this.badge,
  });

  double get finalPrice {
    if (discount != null && discount! > 0) {
      return price - (price * discount! / 100);
    }
    return price;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        category,
        imageUrl,
        discount,
        isFeatured,
        badge,
      ];
}
