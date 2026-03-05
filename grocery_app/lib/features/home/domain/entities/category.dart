import 'package:equatable/equatable.dart';

class CategoryItem extends Equatable {
  final String id;
  final String name;
  final String icon;
  final bool isSelected;

  const CategoryItem({
    required this.id,
    required this.name,
    required this.icon,
    this.isSelected = false,
  });

  CategoryItem copyWith({
    String? id,
    String? name,
    String? icon,
    bool? isSelected,
  }) {
    return CategoryItem(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object?> get props => [id, name, icon, isSelected];
}
