import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../providers/cart_provider.dart';
import '../pages/cart_page.dart';

class CartPreviewWidget extends ConsumerWidget {
  const CartPreviewWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final itemCount = ref.watch(cartItemCountProvider);
    final total = ref.watch(cartTotalProvider);

    if (cartItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: ResponsiveUtils.p(context, 16),
          right: ResponsiveUtils.p(context, 16),
          bottom: ResponsiveUtils.h(context, 12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.p(context, 20),
          vertical: ResponsiveUtils.p(context, 12),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF99D616), Color(0xFFCCF14D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 16)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF99D616).withValues(alpha: 0.4),
              blurRadius: ResponsiveUtils.r(context, 20),
              offset: Offset(0, ResponsiveUtils.h(context, 8)),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: ResponsiveUtils.w(context, 45),
              height: ResponsiveUtils.h(context, 45),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 12),
                ),
              ),
              child: Center(
                child: Text(
                  itemCount.toString(),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: ResponsiveUtils.w(context, 16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Cart',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$itemCount ${itemCount == 1 ? 'item' : 'items'}',
                    style: TextStyle(
                      color: AppColors.black.withValues(alpha: 0.7),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  '\$${total.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: ResponsiveUtils.w(context, 8)),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.black,
                  size: ResponsiveUtils.f(context, 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
