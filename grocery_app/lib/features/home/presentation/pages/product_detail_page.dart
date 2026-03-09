import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../domain/entities/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: ResponsiveUtils.w(context, 50),
              height: ResponsiveUtils.h(context, 50),
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: ResponsiveUtils.r(context, 10),
                    offset: Offset(0, ResponsiveUtils.h(context, 2)),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back,
                color: AppColors.black,
                size: ResponsiveUtils.f(context, 24),
              ),
            ),
          ),
          Text(
            'Product Details',
            style: TextStyle(
              color: AppColors.black,
              fontSize: ResponsiveUtils.f(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 50)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.white,
            product.backgroundColor ?? AppColors.lightGrey,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ResponsiveUtils.r(context, 30)),
          topRight: Radius.circular(ResponsiveUtils.r(context, 30)),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImage(context),
                  _buildVariants(context),
                  _buildProductInfo(context),
                  _buildMetrics(context),
                  _buildProductDetails(context),
                  _buildVariantsSection(context),
                  SizedBox(height: ResponsiveUtils.h(context, 100)),
                ],
              ),
            ),
          ),
          _buildAddButton(context),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveUtils.h(context, 20)),
      alignment: Alignment.center,
      child: Container(
        width: ResponsiveUtils.w(context, 250),
        height: ResponsiveUtils.h(context, 250),
        child: Center(
          child: Image.network(
            product.imageUrl,
            width: ResponsiveUtils.w(context, 200),
            height: ResponsiveUtils.h(context, 200),
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Icon(
                Icons.image_not_supported,
                size: ResponsiveUtils.f(context, 80),
                color: AppColors.textSecondary,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  color: AppColors.primaryGreen,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVariants(BuildContext context) {
    final variants = product.variants.isNotEmpty
        ? product.variants
        : [product.imageUrl];

    return Container(
      height: ResponsiveUtils.h(context, 80),
      margin: EdgeInsets.symmetric(vertical: ResponsiveUtils.h(context, 20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.p(context, 16),
        ),
        itemCount: variants.length,
        itemBuilder: (context, index) {
          return Container(
            width: ResponsiveUtils.w(context, 70),
            height: ResponsiveUtils.h(context, 70),
            margin: EdgeInsets.only(right: ResponsiveUtils.w(context, 12)),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 15),
              ),
              border: Border.all(color: AppColors.lightGrey, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  blurRadius: ResponsiveUtils.r(context, 8),
                  offset: Offset(0, ResponsiveUtils.h(context, 2)),
                ),
              ],
            ),
            child: Center(
              child: Image.network(
                variants[index],
                width: ResponsiveUtils.w(context, 50),
                height: ResponsiveUtils.h(context, 50),
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.image_not_supported,
                    size: ResponsiveUtils.f(context, 20),
                    color: AppColors.textSecondary,
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.p(context, 20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.p(context, 10),
                    vertical: ResponsiveUtils.p(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF3CD),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.r(context, 8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        product.vendor,
                        style: TextStyle(
                          color: Color(0xFFE6A82E),
                          fontSize: ResponsiveUtils.f(context, 12),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xFFE6A82E),
                        size: ResponsiveUtils.f(context, 12),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveUtils.h(context, 8)),
                Text(
                  product.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: ResponsiveUtils.f(context, 20),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.p(context, 12),
              vertical: ResponsiveUtils.p(context, 8),
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(
                ResponsiveUtils.r(context, 12),
              ),
            ),
            child: Text(
              '\$${product.finalPrice.toStringAsFixed(0)}',
              style: TextStyle(
                color: AppColors.black,
                fontSize: ResponsiveUtils.f(context, 24),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetrics(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 20),
        vertical: ResponsiveUtils.h(context, 16),
      ),
      child: Row(
        children: [
          _buildMetricChip(
            context,
            Icons.star,
            product.rating.toString(),
            Colors.amber,
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          _buildMetricChip(
            context,
            Icons.access_time,
            '${product.deliveryTime} min',
            AppColors.textSecondary,
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          _buildMetricChip(
            context,
            Icons.shopping_bag_outlined,
            '${product.soldCount.toStringAsFixed(1)}+ sold',
            AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildMetricChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 12),
        vertical: ResponsiveUtils.p(context, 8),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: ResponsiveUtils.f(context, 16)),
          SizedBox(width: ResponsiveUtils.w(context, 4)),
          Text(
            label,
            style: TextStyle(
              color: AppColors.black,
              fontSize: ResponsiveUtils.f(context, 13),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.p(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hide Product details',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 15),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.black,
                    size: ResponsiveUtils.f(context, 24),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVariantsSection(BuildContext context) {
    final variantImages = product.variants.isNotEmpty
        ? product.variants.take(3).toList()
        : [product.imageUrl];

    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Variants',
            style: TextStyle(
              color: AppColors.black,
              fontSize: ResponsiveUtils.f(context, 18),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: ResponsiveUtils.h(context, 12)),
          SizedBox(
            height: ResponsiveUtils.h(context, 80),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: variantImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: ResponsiveUtils.w(context, 120),
                  margin: EdgeInsets.only(
                    right: ResponsiveUtils.w(context, 12),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.r(context, 16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.05),
                        blurRadius: ResponsiveUtils.r(context, 8),
                        offset: Offset(0, ResponsiveUtils.h(context, 2)),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.network(
                      variantImages[index],
                      width: ResponsiveUtils.w(context, 80),
                      height: ResponsiveUtils.h(context, 60),
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 20)),
      decoration: BoxDecoration(
        color: Colors.transparent,
        // boxShadow: [
        //   BoxShadow(
        //     color: AppColors.black.withValues(alpha: 0.1),
        //     blurRadius: ResponsiveUtils.r(context, 20),
        //     offset: Offset(0, ResponsiveUtils.h(context, -5)),
        //   ),
        // ],
      ),
      child: Container(
        width: double.infinity,
        height: ResponsiveUtils.h(context, 60),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF99D616), Color(0xFFCCF14D)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 30)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF99D616).withValues(alpha: 0.4),
              blurRadius: ResponsiveUtils.r(context, 20),
              offset: Offset(0, ResponsiveUtils.h(context, 8)),
            ),
          ],
        ),
        child: InkWell(
          onTap: product.isOutOfStock ? null : () {},
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 30)),
          child: Center(
            child: Text(
              product.isOutOfStock ? 'Out of Stock' : 'Add',
              style: TextStyle(
                color: AppColors.black,
                fontSize: ResponsiveUtils.f(context, 18),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
