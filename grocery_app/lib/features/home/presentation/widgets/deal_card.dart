import 'package:flutter/material.dart';
import 'package:grocery_app/core/utils/responsive_utils.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/deal.dart';

class DealCard extends StatelessWidget {
  final Deal deal;

  const DealCard({super.key, required this.deal});

  @override
  Widget build(BuildContext context) {
    Color bgColor = _getBackgroundColor(deal.backgroundColor);

    return Container(
      width: ResponsiveUtils.w(context, 135),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.white, bgColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: ResponsiveUtils.h(context, 4)),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.p(context, 16),
                ),
                child: Text(
                  deal.discountUnit,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.p(context, 16),
                ),
                child: Text(
                  deal.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.p(context, 16),
                ),
                child: Text(
                  deal.title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                deal.imageUrl,
                height: ResponsiveUtils.h(context, 90),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor(String hexColor) {
    try {
      return Color(int.parse(hexColor.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppColors.lightGrey;
    }
  }
}
