import 'dart:ui';

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
  final Color? backgroundColor;
  final double rating;
  final int deliveryTime;
  final double soldCount;
  final int quantity;
  final String vendor;
  final List<String> variants;

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
    this.backgroundColor,
    this.rating = 4.5,
    this.deliveryTime = 15,
    this.soldCount = 0,
    this.quantity = 100,
    this.vendor = 'Keventer',
    this.variants = const [],
  });

  double get finalPrice {
    if (discount != null && discount! > 0) {
      return price - (price * discount! / 100);
    }
    return price;
  }

  bool get isOutOfStock => quantity == 0;

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
    backgroundColor,
    rating,
    deliveryTime,
    soldCount,
    quantity,
    vendor,
    variants,
  ];
}
