import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../providers/cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Cart',
          style: TextStyle(
            color: AppColors.black,
            fontSize: ResponsiveUtils.f(context, 20),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (cartItems.isNotEmpty)
            TextButton(
              onPressed: () {
                ref.read(cartProvider.notifier).clearCart();
              },
              child: Text(
                'Clear',
                style: TextStyle(
                  color: AppColors.error,
                  fontSize: ResponsiveUtils.f(context, 14),
                ),
              ),
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? _buildEmptyCart(context)
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return _buildCartItem(context, ref, cartItem);
                    },
                  ),
                ),
                _buildCheckoutSection(context, ref, total),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: ResponsiveUtils.f(context, 100),
            color: AppColors.textSecondary.withValues(alpha: 0.3),
          ),
          SizedBox(height: ResponsiveUtils.h(context, 24)),
          Text(
            'Your cart is empty',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: ResponsiveUtils.f(context, 20),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveUtils.h(context, 8)),
          Text(
            'Add items to get started',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: ResponsiveUtils.f(context, 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, WidgetRef ref, cartItem) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.h(context, 16)),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 12)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 16)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: ResponsiveUtils.r(context, 10),
            offset: Offset(0, ResponsiveUtils.h(context, 2)),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: ResponsiveUtils.w(context, 80),
            height: ResponsiveUtils.h(context, 80),
            decoration: BoxDecoration(
              color: cartItem.product.backgroundColor,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 12),
              ),
            ),
            child: Image.network(
              cartItem.product.imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: ResponsiveUtils.f(context, 30),
                  color: AppColors.textSecondary,
                );
              },
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.name,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: ResponsiveUtils.f(context, 14),
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: ResponsiveUtils.h(context, 4)),
                Text(
                  '\$${cartItem.product.finalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.primaryGreen,
                    fontSize: ResponsiveUtils.f(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF99D616),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 12),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ref
                        .read(cartProvider.notifier)
                        .removeItem(cartItem.product.id);
                  },
                  child: Container(
                    width: ResponsiveUtils.w(context, 32),
                    height: ResponsiveUtils.h(context, 32),
                    child: Icon(
                      Icons.remove,
                      color: AppColors.black,
                      size: ResponsiveUtils.f(context, 18),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: ResponsiveUtils.w(context, 30),
                  ),
                  child: Center(
                    child: Text(
                      cartItem.quantity.toString(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: ResponsiveUtils.f(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(cartProvider.notifier).addItem(cartItem.product);
                  },
                  child: Container(
                    width: ResponsiveUtils.w(context, 32),
                    height: ResponsiveUtils.h(context, 32),
                    child: Icon(
                      Icons.add,
                      color: AppColors.black,
                      size: ResponsiveUtils.f(context, 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutSection(
    BuildContext context,
    WidgetRef ref,
    double total,
  ) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: ResponsiveUtils.r(context, 20),
            offset: Offset(0, ResponsiveUtils.h(context, -5)),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: ResponsiveUtils.f(context, 16),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: ResponsiveUtils.f(context, 24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: ResponsiveUtils.h(context, 16)),
          Container(
            width: double.infinity,
            height: ResponsiveUtils.h(context, 56),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF99D616), Color(0xFFCCF14D)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF99D616).withValues(alpha: 0.4),
                  blurRadius: ResponsiveUtils.r(context, 20),
                  offset: Offset(0, ResponsiveUtils.h(context, 8)),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Checkout functionality coming soon!'),
                      backgroundColor: AppColors.primaryGreen,
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 28),
                ),
                child: Center(
                  child: Text(
                    'Checkout',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
