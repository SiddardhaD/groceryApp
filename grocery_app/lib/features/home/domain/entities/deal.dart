import 'package:equatable/equatable.dart';

class Deal extends Equatable {
  final String id;
  final String title;
  final String description;
  final int discount;
  final String imageUrl;
  final String backgroundColor;

  const Deal({
    required this.id,
    required this.title,
    required this.description,
    required this.discount,
    required this.imageUrl,
    required this.backgroundColor,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        discount,
        imageUrl,
        backgroundColor,
      ];
}
