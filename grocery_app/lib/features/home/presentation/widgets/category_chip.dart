import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/category.dart';
import '../providers/home_providers.dart';

class CategoryChip extends ConsumerWidget {
  final CategoryItem category;

  const CategoryChip({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        ref.read(categoriesProvider.notifier).selectCategory(category.id);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: category.isSelected ? AppColors.black : AppColors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: category.isSelected
                ? AppColors.black
                : AppColors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              category.icon,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(width: 8),
            Text(
              category.name,
              style: TextStyle(
                color: category.isSelected ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
