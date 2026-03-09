import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../../cart/presentation/widgets/product_detail_bottom_sheet.dart';
import '../../domain/entities/product.dart';

class ProductCard extends ConsumerStatefulWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final quantity =
        cartItems
            .where((item) => item.product.id == widget.product.id)
            .firstOrNull
            ?.quantity ??
        0;

    return GestureDetector(
      onTap: () {
        ProductDetailBottomSheet.show(context, widget.product);
      },
      child: Opacity(
        opacity: widget.product.isOutOfStock ? 0.5 : 1.0,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: ResponsiveUtils.h(context, 135),
                  child: ClipPath(
                    clipper: ProductCardClipper(context),
                    child: Container(
                      decoration: BoxDecoration(
                        color: widget.product.backgroundColor,
                        borderRadius: BorderRadius.circular(
                          ResponsiveUtils.r(context, 20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withValues(alpha: 0.08),
                            blurRadius: ResponsiveUtils.r(context, 15),
                            offset: Offset(0, ResponsiveUtils.h(context, 4)),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: ResponsiveUtils.h(context, 200),
                            width: ResponsiveUtils.w(context, 200),
                            child: Image.network(
                              widget.product.imageUrl,
                              width: ResponsiveUtils.w(context, 80),
                              height: ResponsiveUtils.h(context, 80),
                              fit: BoxFit.fitWidth,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.image_not_supported,
                                  size: ResponsiveUtils.f(context, 40),
                                  color: AppColors.textSecondary,
                                );
                              },
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value:
                                            loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                            : null,
                                        color: AppColors.primaryGreen,
                                        strokeWidth: 2,
                                      ),
                                    );
                                  },
                            ),
                          ),
                          Positioned(
                            left: ResponsiveUtils.p(context, 10),
                            top: ResponsiveUtils.p(context, 10),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.p(context, 8),
                                vertical: ResponsiveUtils.p(context, 4),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryGreen,
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.r(context, 8),
                                ),
                              ),
                              child: Text(
                                '\$${widget.product.finalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: AppColors.black,
                                  fontSize: ResponsiveUtils.f(context, 12),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          if (widget.product.badge != null)
                            Positioned(
                              left: ResponsiveUtils.p(context, 10),
                              bottom: ResponsiveUtils.p(context, 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.p(context, 8),
                                  vertical: ResponsiveUtils.p(context, 4),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.black,
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.r(context, 8),
                                  ),
                                ),
                                child: Text(
                                  widget.product.badge!,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: ResponsiveUtils.f(context, 9),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: ResponsiveUtils.h(context, 4)),
                    Text(
                      widget.product.description,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: ResponsiveUtils.f(context, 11),
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.h(context, 4)),
                    Text(
                      widget.product.name,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: ResponsiveUtils.f(context, 13),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.elasticOut,
                switchOutCurve: Curves.easeInOut,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    alignment: Alignment.centerRight,
                    child: FadeTransition(opacity: animation, child: child),
                  );
                },
                layoutBuilder: (currentChild, previousChildren) {
                  return Stack(
                    alignment: Alignment.centerRight,
                    children: <Widget>[
                      ...previousChildren,
                      if (currentChild != null) currentChild,
                    ],
                  );
                },
                child: quantity > 0
                    ? _buildQuantityControl(context, ref, quantity)
                    : _buildAddButton(context, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      key: const ValueKey('add_button'),
      onTap: () {
        if (!widget.product.isOutOfStock) {
          ref.read(cartProvider.notifier).addItem(widget.product);
        }
      },
      child: Container(
        width: ResponsiveUtils.w(context, 50),
        height: ResponsiveUtils.h(context, 50),
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFF99D616).withValues(alpha: 0.3),
              blurRadius: ResponsiveUtils.r(context, 8),
              offset: Offset(0, ResponsiveUtils.h(context, 2)),
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          color: AppColors.black,
          size: ResponsiveUtils.f(context, 20),
        ),
      ),
    );
  }

  Widget _buildQuantityControl(
    BuildContext context,
    WidgetRef ref,
    int quantity,
  ) {
    return Container(
      key: const ValueKey('quantity_control'),
      height: ResponsiveUtils.h(context, 50),
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 25)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF99D616).withValues(alpha: 0.3),
            blurRadius: ResponsiveUtils.r(context, 8),
            offset: Offset(0, ResponsiveUtils.h(context, 2)),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(cartProvider.notifier).removeItem(widget.product.id);
            },
            child: Container(
              width: ResponsiveUtils.w(context, 30),
              height: ResponsiveUtils.h(context, 50),
              child: Icon(
                Icons.remove,
                color: AppColors.black,
                size: ResponsiveUtils.f(context, 18),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minWidth: ResponsiveUtils.w(context, 25),
            ),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.elasticOut,
                      ),
                    ),
                    child: child,
                  );
                },
                child: Text(
                  quantity.toString(),
                  key: ValueKey<int>(quantity),
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveUtils.f(context, 14),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref.read(cartProvider.notifier).addItem(widget.product);
            },
            child: Container(
              width: ResponsiveUtils.w(context, 30),
              height: ResponsiveUtils.h(context, 50),
              child: Icon(
                Icons.add,
                color: AppColors.black,
                size: ResponsiveUtils.f(context, 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCardClipper extends CustomClipper<Path> {
  final BuildContext context;

  ProductCardClipper(this.context);

  @override
  Path getClip(Size size) {
    final path = Path();

    final cornerRadius = ResponsiveUtils.r(context, 20);
    final notchRadius = ResponsiveUtils.w(context, 35);

    final notchStart = size.width - notchRadius * 2;

    path.moveTo(cornerRadius, 0);

    path.lineTo(notchStart, 0);

    path.quadraticBezierTo(notchStart + 15, 0, notchStart + 10, notchRadius);

    path.arcToPoint(
      Offset(size.width, notchRadius * 1.5),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height - cornerRadius);

    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - cornerRadius,
      size.height,
    );

    path.lineTo(cornerRadius, size.height);

    path.quadraticBezierTo(0, size.height, 0, size.height - cornerRadius);

    path.lineTo(0, cornerRadius);

    path.quadraticBezierTo(0, 0, cornerRadius, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
