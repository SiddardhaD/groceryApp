import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../providers/cart_provider.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final total = ref.watch(cartTotalProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: _buildAppBar(context),
      body: cartItems.isEmpty
          ? _buildEmptyCart(context)
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildUnlockOfferBanner(context, total),
                  _buildCouponsSection(context),
                  _buildPaymentOptionsSection(context),
                  _buildCartItems(context, ref, cartItems),
                  _buildBillSummary(context, total, cartItems.length),
                  _buildLastMinuteItems(context, ref),
                  SizedBox(height: ResponsiveUtils.h(context, 100)),
                ],
              ),
            ),
      bottomSheet: cartItems.isNotEmpty
          ? _buildCheckoutButton(context, ref, total)
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: GestureDetector(
        onTap: () {
          // Open address selection bottom sheet
          _showAddressBottomSheet(context);
        },
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: AppColors.primaryGreen,
              size: ResponsiveUtils.f(context, 20),
            ),
            SizedBox(width: ResponsiveUtils.w(context, 8)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deliver to',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: ResponsiveUtils.f(context, 11),
                    ),
                  ),
                  Text(
                    'Home - 123 Main St, Apt 4B',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 14),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.black,
              size: ResponsiveUtils.f(context, 20),
            ),
          ],
        ),
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

  Widget _buildUnlockOfferBanner(BuildContext context, double total) {
    const threshold = 599.0;
    final remaining = threshold - total;
    final isUnlocked = remaining <= 0;

    return Container(
      margin: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: !isUnlocked
              ? [
                  AppColors.darkGreen.withValues(alpha: 0.5),
                  AppColors.darkGreen.withValues(alpha: 0.8),
                ]
              : [
                  AppColors.warning.withValues(alpha: 0.5),
                  AppColors.warning.withValues(alpha: 0.8),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Row(
        children: [
          Icon(
            isUnlocked ? Icons.check_circle : Icons.local_offer,
            color: AppColors.white,
            size: ResponsiveUtils.f(context, 32),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUnlocked
                      ? '🎉 Yay! ₹50 OFF Unlocked'
                      : 'Shop ₹${remaining.toStringAsFixed(0)} more',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: ResponsiveUtils.f(context, 16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!isUnlocked)
                  Text(
                    'to unlock ₹50 OFF',
                    style: TextStyle(
                      color: AppColors.white.withValues(alpha: 0.9),
                      fontSize: ResponsiveUtils.f(context, 13),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCouponsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 16),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.p(context, 10)),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 8),
              ),
            ),
            child: Icon(
              Icons.local_offer,
              color: AppColors.darkGreen,
              size: ResponsiveUtils.f(context, 24),
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Apply Coupon',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveUtils.f(context, 15),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Save ₹100 with code SAVE100',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveUtils.f(context, 12),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: ResponsiveUtils.f(context, 16),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOptionsSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 16),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.p(context, 10)),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 8),
              ),
            ),
            child: Icon(
              Icons.payment,
              color: AppColors.darkGreen,
              size: ResponsiveUtils.f(context, 24),
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          Expanded(
            child: Text(
              'View Payment Options',
              style: TextStyle(
                color: AppColors.black,
                fontSize: ResponsiveUtils.f(context, 15),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: ResponsiveUtils.f(context, 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItems(BuildContext context, WidgetRef ref, List cartItems) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 16),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
            child: Row(
              children: [
                Text(
                  'Items in Cart',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.access_time,
                  size: ResponsiveUtils.f(context, 14),
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: ResponsiveUtils.w(context, 4)),
                Text(
                  '15 min delivery',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: AppColors.lightGrey),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: AppColors.lightGrey),
            itemBuilder: (context, index) {
              final cartItem = cartItems[index];
              return _buildCartItem(context, ref, cartItem);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, WidgetRef ref, cartItem) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      child: Row(
        children: [
          Container(
            width: ResponsiveUtils.w(context, 60),
            height: ResponsiveUtils.h(context, 60),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 10),
              ),
            ),
            child: Image.network(
              cartItem.product.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.image_not_supported,
                  size: ResponsiveUtils.f(context, 24),
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
                  '${cartItem.product.quantity}g',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.h(context, 4)),
                Row(
                  children: [
                    Text(
                      '₹${cartItem.product.finalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (cartItem.product.discount != null &&
                        cartItem.product.discount! > 0) ...[
                      SizedBox(width: ResponsiveUtils.w(context, 6)),
                      Text(
                        '₹${cartItem.product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 10),
              ),
              border: Border.all(
                color: AppColors.grey.withValues(alpha: 0.2),
                width: 1,
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
                  child: SizedBox(
                    width: ResponsiveUtils.w(context, 28),
                    height: ResponsiveUtils.h(context, 28),
                    child: Icon(
                      cartItem.quantity == 1
                          ? Icons.delete_outline
                          : Icons.remove,
                      color: AppColors.black,
                      size: ResponsiveUtils.f(context, 16),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minWidth: ResponsiveUtils.w(context, 24),
                  ),
                  child: Center(
                    child: Text(
                      cartItem.quantity.toString(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    ref.read(cartProvider.notifier).addItem(cartItem.product);
                  },
                  child: SizedBox(
                    width: ResponsiveUtils.w(context, 28),
                    height: ResponsiveUtils.h(context, 28),
                    child: Icon(
                      Icons.add,
                      color: AppColors.darkGreen,
                      size: ResponsiveUtils.f(context, 16),
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

  Widget _buildBillSummary(BuildContext context, double total, int itemCount) {
    const deliveryFee = 25.0;
    const handlingFee = 5.0;
    final itemsTotal = total;
    final gst = itemsTotal * 0.05; // 5% GST
    final discount = 50.0; // Example discount
    final finalAmount = itemsTotal + deliveryFee + handlingFee + gst - discount;
    final savings = discount + (itemCount * 10); // Example savings calculation

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 16),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bill Summary',
            style: TextStyle(
              color: AppColors.black,
              fontSize: ResponsiveUtils.f(context, 16),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveUtils.h(context, 16)),
          _buildBillRow(
            context,
            'Items Total',
            '₹${itemsTotal.toStringAsFixed(2)}',
          ),
          _buildBillRow(
            context,
            'Delivery Fee',
            '₹${deliveryFee.toStringAsFixed(2)}',
          ),
          _buildBillRow(
            context,
            'Handling Fee',
            '₹${handlingFee.toStringAsFixed(2)}',
          ),
          _buildBillRow(context, 'GST (5%)', '₹${gst.toStringAsFixed(2)}'),
          _buildBillRow(
            context,
            'Discount',
            '- ₹${discount.toStringAsFixed(2)}',
            isDiscount: true,
          ),
          Divider(
            height: ResponsiveUtils.h(context, 24),
            color: AppColors.lightGrey,
          ),
          _buildBillRow(
            context,
            'To Pay',
            '₹${finalAmount.toStringAsFixed(2)}',
            isBold: true,
          ),
          SizedBox(height: ResponsiveUtils.h(context, 12)),
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.p(context, 12)),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 8),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.savings,
                  color: AppColors.success,
                  size: ResponsiveUtils.f(context, 18),
                ),
                SizedBox(width: ResponsiveUtils.w(context, 8)),
                Text(
                  'You are saving ₹${savings.toStringAsFixed(0)} on this order',
                  style: TextStyle(
                    color: AppColors.success,
                    fontSize: ResponsiveUtils.f(context, 13),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBillRow(
    BuildContext context,
    String label,
    String value, {
    bool isDiscount = false,
    bool isBold = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.h(context, 8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: isDiscount ? AppColors.success : AppColors.black,
              fontSize: 12,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastMinuteItems(BuildContext context, WidgetRef ref) {
    final products = ref.watch(productsProvider);
    final lastMinuteItems = products.take(6).toList();
    final cartItems = ref.watch(cartProvider);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 16),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Last Minute Add-ons',
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveUtils.h(context, 12)),
          SizedBox(
            height: ResponsiveUtils.h(context, 220),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: lastMinuteItems.length,
              itemBuilder: (context, index) {
                final product = lastMinuteItems[index];
                final quantity =
                    cartItems
                        .where((item) => item.product.id == product.id)
                        .firstOrNull
                        ?.quantity ??
                    0;

                return Container(
                  width: ResponsiveUtils.w(context, 120),
                  margin: EdgeInsets.only(
                    right: ResponsiveUtils.w(context, 12),
                  ),
                  padding: EdgeInsets.all(ResponsiveUtils.p(context, 8)),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.r(context, 12),
                    ),
                    border: Border.all(color: AppColors.lightGrey, width: 1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                              ResponsiveUtils.r(context, 8),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: ResponsiveUtils.h(context, 80),
                              color: AppColors.lightGrey,
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_not_supported,
                                    size: ResponsiveUtils.f(context, 24),
                                    color: AppColors.textSecondary,
                                  );
                                },
                              ),
                            ),
                          ),
                          if (product.discount != null && product.discount! > 0)
                            Positioned(
                              top: 4,
                              left: 4,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.p(context, 6),
                                  vertical: ResponsiveUtils.p(context, 2),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.r(context, 4),
                                  ),
                                ),
                                child: Text(
                                  '${product.discount!.toStringAsFixed(0)}% Off',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.h(context, 6)),
                      Text(
                        product.name,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: ResponsiveUtils.h(context, 2)),
                      Text(
                        '${product.quantity}g',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondary,
                          fontSize: 9,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.h(context, 4)),
                      Row(
                        children: [
                          Text(
                            '₹${product.finalPrice.toStringAsFixed(0)}',
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: ResponsiveUtils.w(context, 4)),
                          if (product.discount != null && product.discount! > 0)
                            Text(
                              '₹${product.price.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: ResponsiveUtils.h(context, 6)),
                      quantity > 0
                          ? Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                vertical: ResponsiveUtils.p(context, 6),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.lightGreen,
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.r(context, 6),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .removeItem(product.id);
                                    },
                                    child: Icon(
                                      quantity == 1
                                          ? Icons.delete_outline
                                          : Icons.remove,
                                      color: AppColors.black,
                                      size: ResponsiveUtils.f(context, 16),
                                    ),
                                  ),
                                  Text(
                                    quantity.toString(),
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(cartProvider.notifier)
                                          .addItem(product);
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: AppColors.black,
                                      size: ResponsiveUtils.f(context, 16),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                ref
                                    .read(cartProvider.notifier)
                                    .addItem(product);
                              },
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveUtils.p(context, 6),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreen,
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.r(context, 6),
                                  ),
                                  // border: Border.all(
                                  //   color: AppColors.darkGreen,
                                  //   width: 1,
                                  // ),
                                ),
                                child: Center(
                                  child: Text(
                                    'ADD',
                                    style: TextStyle(
                                      color: AppColors.darkGreen,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(
    BuildContext context,
    WidgetRef ref,
    double total,
  ) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
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
      child: Container(
        width: double.infinity,
        height: ResponsiveUtils.h(context, 56),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryGreen.withValues(alpha: 0.3),
              blurRadius: ResponsiveUtils.r(context, 15),
              offset: Offset(0, ResponsiveUtils.h(context, 6)),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Proceeding to checkout...'),
                  backgroundColor: AppColors.primaryGreen,
                ),
              );
            },
            borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.p(context, 20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '₹${total.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Proceed to Checkout',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: ResponsiveUtils.f(context, 16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: ResponsiveUtils.w(context, 8)),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.black,
                        size: ResponsiveUtils.f(context, 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(ResponsiveUtils.r(context, 20)),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(ResponsiveUtils.p(context, 20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Delivery Address',
              style: TextStyle(
                color: AppColors.black,
                fontSize: ResponsiveUtils.f(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: ResponsiveUtils.h(context, 20)),
            _buildAddressOption(context, 'Home', '123 Main St, Apt 4B', true),
            _buildAddressOption(context, 'Work', '456 Office Plaza', false),
            _buildAddressOption(context, 'Other', '789 Park Avenue', false),
            SizedBox(height: ResponsiveUtils.h(context, 16)),
            TextButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.add, color: AppColors.primaryGreen),
              label: Text(
                'Add New Address',
                style: TextStyle(
                  color: AppColors.primaryGreen,
                  fontSize: ResponsiveUtils.f(context, 14),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressOption(
    BuildContext context,
    String title,
    String address,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.h(context, 12)),
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 12)),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primaryGreen.withValues(alpha: 0.1)
            : AppColors.lightGrey,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 10)),
        border: Border.all(
          color: isSelected ? AppColors.primaryGreen : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected
                ? AppColors.primaryGreen
                : AppColors.textSecondary,
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveUtils.f(context, 14),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  address,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: ResponsiveUtils.f(context, 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
