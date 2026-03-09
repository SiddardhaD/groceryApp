import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Fruits & Vegetables', 'icon': '🥗', 'count': '150+'},
      {'name': 'Dairy & Eggs', 'icon': '🥛', 'count': '80+'},
      {'name': 'Bakery', 'icon': '🥖', 'count': '120+'},
      {'name': 'Meat & Seafood', 'icon': '🥩', 'count': '90+'},
      {'name': 'Beverages', 'icon': '🥤', 'count': '200+'},
      {'name': 'Snacks', 'icon': '🍿', 'count': '180+'},
      {'name': 'Frozen Foods', 'icon': '🧊', 'count': '110+'},
      {'name': 'Personal Care', 'icon': '🧴', 'count': '140+'},
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Categories'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.defaultPadding),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              context,
              category['name']!,
              category['icon']!,
              category['count']!,
              index,
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String name,
    String icon,
    String count,
    int index,
  ) {
    final colors = [
      AppColors.greenCard,
      AppColors.yellowCard,
      AppColors.pinkCard,
      AppColors.blueCard,
    ];

    return Container(
      decoration: BoxDecoration(
        color: colors[index % colors.length],
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(icon, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '$count items',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
