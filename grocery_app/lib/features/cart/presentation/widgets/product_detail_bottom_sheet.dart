import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_app/features/cart/domain/entities/cart_item.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../home/domain/entities/product.dart';
import '../../../home/presentation/providers/home_providers.dart';
import '../providers/cart_provider.dart';

class ProductDetailBottomSheet extends ConsumerStatefulWidget {
  final Product product;
  final bool isStackedPage;

  const ProductDetailBottomSheet({
    super.key,
    required this.product,
    this.isStackedPage = false,
  });

  static void show(BuildContext context, Product product) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          ProductDetailBottomSheet(product: product, isStackedPage: false),
    );
  }

  static void showAsPage(BuildContext context, Product product) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductDetailBottomSheet(product: product, isStackedPage: true),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: Container(
              color: AppColors.black.withValues(alpha: 0.3),
              child: child,
            ),
          );
        },
        opaque: false,
        barrierColor: AppColors.black.withValues(alpha: 0.3),
      ),
    );
  }

  @override
  ConsumerState<ProductDetailBottomSheet> createState() =>
      _ProductDetailBottomSheetState();
}

class _ProductDetailBottomSheetState
    extends ConsumerState<ProductDetailBottomSheet> {
  bool _showAppBar = false;
  late PageController _pageController;
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll(double offset) {
    final shouldShow = offset > 100;
    if (_showAppBar != shouldShow) {
      setState(() {
        _showAppBar = shouldShow;
      });
    }
  }

  void _shareProduct() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Share feature: ${widget.product.name}'),
        backgroundColor: AppColors.primaryGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = ref
        .watch(cartProvider)
        .cast<CartItem?>()
        .firstWhere(
          (item) => item?.product.id == widget.product.id,
          orElse: () => null,
        );
    final quantity = cartItem?.quantity ?? 0;

    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.5,
      maxChildSize: 0.98,
      builder: (context, scrollController) {
        scrollController.addListener(() {
          _onScroll(scrollController.offset);
        });

        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(ResponsiveUtils.r(context, 30)),
                topRight: Radius.circular(ResponsiveUtils.r(context, 30)),
              ),
            ),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: _showAppBar ? 0 : ResponsiveUtils.h(context, 50),
                  child: _showAppBar
                      ? SizedBox.shrink()
                      : _buildHandle(context),
                ),
                if (_showAppBar) _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!_showAppBar) _buildProductImageCarousel(context),
                        if (_showAppBar)
                          SizedBox(height: ResponsiveUtils.h(context, 20)),
                        if (_showAppBar) _buildCompactImageCarousel(context),
                        _buildProductInfo(context),
                        // _buildDescription(context),
                        _buildPriceDetails(context),
                        _buildBadges(context),
                        _buildMetrics(context),
                        _buildRelatedProducts(context, ref),
                        SizedBox(height: ResponsiveUtils.h(context, 100)),
                      ],
                    ),
                  ),
                ),
                _buildCartControl(context, ref, quantity),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ResponsiveUtils.h(context, 12)),
      alignment: Alignment.center,
      child: Container(
        width: ResponsiveUtils.w(context, 40),
        height: ResponsiveUtils.h(context, 5),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 10)),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final topPadding = !widget.isStackedPage
        ? ResponsiveUtils.h(context, 40)
        : ResponsiveUtils.h(context, 8);

    return Container(
      padding: EdgeInsets.only(
        top: statusBarHeight + topPadding,
        left: ResponsiveUtils.p(context, 8),
        right: ResponsiveUtils.p(context, 8),
        bottom: ResponsiveUtils.p(context, 12),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
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
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.black,
              size: ResponsiveUtils.f(context, 24),
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 8)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.product.name,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${widget.product.finalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: ResponsiveUtils.w(context, 8)),
          IconButton(
            onPressed: _shareProduct,
            icon: Icon(
              Icons.share_outlined,
              color: AppColors.black,
              size: ResponsiveUtils.f(context, 22),
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            style: IconButton.styleFrom(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImageCarousel(BuildContext context) {
    final images = widget.product.variants.isNotEmpty
        ? widget.product.variants
        : [widget.product.imageUrl];

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 20),
        vertical: ResponsiveUtils.h(context, 20),
      ),
      height: ResponsiveUtils.h(context, 350),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 20),
                  ),
                  border: Border.all(
                    color: AppColors.lightGrey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 20),
                  ),
                  child: Image.network(
                    images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: ResponsiveUtils.f(context, 80),
                          color: AppColors.textSecondary,
                        ),
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
              );
            },
          ),
          Positioned(
            top: ResponsiveUtils.h(context, 16),
            right: ResponsiveUtils.w(context, 16),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: ResponsiveUtils.r(context, 8),
                    offset: Offset(0, ResponsiveUtils.h(context, 2)),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _shareProduct,
                icon: Icon(
                  Icons.share_outlined,
                  color: AppColors.black,
                  size: ResponsiveUtils.f(context, 20),
                ),
                padding: EdgeInsets.all(ResponsiveUtils.p(context, 8)),
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: ResponsiveUtils.h(context, 16),
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.p(context, 12),
                    vertical: ResponsiveUtils.p(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.r(context, 20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      images.length,
                      (index) => Container(
                        width: ResponsiveUtils.w(context, 8),
                        height: ResponsiveUtils.h(context, 8),
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.w(context, 4),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? AppColors.primaryGreen
                              : AppColors.white.withValues(alpha: 0.5),
                        ),
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

  Widget _buildCompactImageCarousel(BuildContext context) {
    final images = widget.product.variants.isNotEmpty
        ? widget.product.variants
        : [widget.product.imageUrl];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.p(context, 20)),
      height: ResponsiveUtils.h(context, 220),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemCount: images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 20),
                  ),
                  border: Border.all(
                    color: AppColors.lightGrey.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 20),
                  ),
                  child: Image.network(
                    images[index],
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: ResponsiveUtils.f(context, 60),
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: ResponsiveUtils.h(context, 12),
            right: ResponsiveUtils.w(context, 12),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: ResponsiveUtils.r(context, 8),
                    offset: Offset(0, ResponsiveUtils.h(context, 2)),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _shareProduct,
                icon: Icon(
                  Icons.share_outlined,
                  color: AppColors.black,
                  size: ResponsiveUtils.f(context, 18),
                ),
                padding: EdgeInsets.all(ResponsiveUtils.p(context, 6)),
              ),
            ),
          ),
          if (images.length > 1)
            Positioned(
              bottom: ResponsiveUtils.h(context, 12),
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.p(context, 10),
                    vertical: ResponsiveUtils.p(context, 4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(
                      ResponsiveUtils.r(context, 20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      images.length,
                      (index) => Container(
                        width: ResponsiveUtils.w(context, 6),
                        height: ResponsiveUtils.h(context, 6),
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.w(context, 3),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentImageIndex == index
                              ? AppColors.primaryGreen
                              : AppColors.white.withValues(alpha: 0.5),
                        ),
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

  Widget _buildProductInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.p(context, 20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.p(context, 10),
                  vertical: ResponsiveUtils.p(context, 6),
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 8),
                  ),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.vendor,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: ResponsiveUtils.f(context, 12),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.w(context, 4)),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: AppColors.textSecondary,
                      size: ResponsiveUtils.f(context, 12),
                    ),
                  ],
                ),
              ),

              Text(
                widget.product.description,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),

          SizedBox(height: ResponsiveUtils.h(context, 12)),
          if (!_showAppBar)
            Text(
              widget.product.name,
              style: GoogleFonts.inter(
                color: AppColors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 20),
        vertical: ResponsiveUtils.h(context, 12),
      ),
      child: Text(
        widget.product.description,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildPriceDetails(BuildContext context) {
    final hasDiscount =
        widget.product.discount != null && widget.product.discount! > 0;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 20),
        vertical: ResponsiveUtils.h(context, 12),
      ),
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.h(context, 4)),
                Row(
                  children: [
                    Text(
                      '\$${widget.product.finalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (hasDiscount) ...[
                      SizedBox(width: ResponsiveUtils.w(context, 4)),
                      Text(
                        '\$${widget.product.price.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
                if (hasDiscount)
                  Container(
                    margin: EdgeInsets.only(top: ResponsiveUtils.h(context, 4)),
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.p(context, 8),
                      vertical: ResponsiveUtils.p(context, 2),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.r(context, 6),
                      ),
                    ),
                    child: Text(
                      '${widget.product.discount!.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Net Qty',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: ResponsiveUtils.h(context, 4)),
                Text(
                  '${widget.product.quantity}g',
                  style: GoogleFonts.poppins(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadges(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 20),
        vertical: ResponsiveUtils.h(context, 8),
      ),
      child: Wrap(
        spacing: ResponsiveUtils.w(context, 8),
        runSpacing: ResponsiveUtils.h(context, 8),
        children: [
          _buildBadgeChip(
            context,
            Icons.electric_bolt,
            'Fast Delivery',
            AppColors.darkGreen,
          ),
          _buildBadgeChip(
            context,
            Icons.verified_user,
            'Quality Assured',
            AppColors.success,
          ),
          if (widget.product.quantity > 0)
            _buildBadgeChip(
              context,
              Icons.check_circle,
              'In Stock',
              AppColors.success,
            ),
          if (widget.product.badge != null)
            _buildBadgeChip(
              context,
              Icons.local_offer,
              widget.product.badge!,
              AppColors.warning,
            ),
        ],
      ),
    );
  }

  Widget _buildBadgeChip(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 12),
        vertical: ResponsiveUtils.p(context, 6),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: ResponsiveUtils.f(context, 14)),
          SizedBox(width: ResponsiveUtils.w(context, 4)),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 10,
              fontWeight: FontWeight.w600,
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
            widget.product.rating.toString(),
            AppColors.warning,
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          _buildMetricChip(
            context,
            Icons.access_time,
            '${widget.product.deliveryTime} min',
            AppColors.textSecondary,
          ),
          SizedBox(width: ResponsiveUtils.w(context, 12)),
          _buildMetricChip(
            context,
            Icons.shopping_bag_outlined,
            '${widget.product.soldCount.toStringAsFixed(1)}k sold',
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
        vertical: ResponsiveUtils.p(context, 6),
      ),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: ResponsiveUtils.f(context, 16)),
          SizedBox(width: ResponsiveUtils.w(context, 4)),
          Text(
            label,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: ResponsiveUtils.f(context, 13),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedProducts(BuildContext context, WidgetRef ref) {
    final allProducts = ref.watch(productsProvider);
    final relatedProducts = allProducts
        .where(
          (p) =>
              p.category == widget.product.category &&
              p.id != widget.product.id,
        )
        .take(10)
        .toList();

    if (relatedProducts.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.p(context, 20),
            vertical: ResponsiveUtils.h(context, 16),
          ),
          child: Text(
            'Similar Fresh Products',
            style: GoogleFonts.poppins(
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          height: ResponsiveUtils.h(context, 180),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.p(context, 16),
            ),
            itemCount: relatedProducts.length,
            itemBuilder: (context, index) {
              return _buildRelatedProductCard(context, relatedProducts[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRelatedProductCard(
    BuildContext context,
    Product relatedProduct,
  ) {
    return GestureDetector(
      onTap: () {
        ProductDetailBottomSheet.showAsPage(context, relatedProduct);
      },
      child: Container(
        width: ResponsiveUtils.w(context, 130),
        margin: EdgeInsets.only(right: ResponsiveUtils.w(context, 12)),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 16)),
          border: Border.all(
            color: AppColors.grey.withValues(alpha: 0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.03),
              blurRadius: ResponsiveUtils.r(context, 8),
              offset: Offset(0, ResponsiveUtils.h(context, 2)),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ResponsiveUtils.h(context, 100),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ResponsiveUtils.r(context, 16)),
                  topRight: Radius.circular(ResponsiveUtils.r(context, 16)),
                ),
              ),
              child: Center(
                child: Image.network(
                  relatedProduct.imageUrl,
                  width: ResponsiveUtils.w(context, 80),
                  height: ResponsiveUtils.h(context, 80),
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
            ),
            Padding(
              padding: EdgeInsets.all(ResponsiveUtils.p(context, 8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    relatedProduct.name,
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 12),
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: ResponsiveUtils.h(context, 4)),
                  Text(
                    '\$${relatedProduct.finalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: ResponsiveUtils.f(context, 14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartControl(BuildContext context, WidgetRef ref, int quantity) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.p(context, 20)),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: ResponsiveUtils.r(context, 20),
            offset: Offset(0, ResponsiveUtils.h(context, -5)),
          ),
        ],
      ),
      child: Row(
        children: [
          if (quantity > 0) ...[
            Container(
              height: ResponsiveUtils.h(context, 60),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.p(context, 6),
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 30),
                ),
                border: Border.all(
                  color: AppColors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .removeItem(widget.product.id);
                    },
                    icon: Icon(
                      quantity == 1 ? Icons.delete_outline : Icons.remove,
                      color: AppColors.black,
                      size: ResponsiveUtils.f(context, 18),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.p(context, 12),
                    ),
                    child: Text(
                      quantity.toString(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addItem(widget.product);
                    },
                    icon: Icon(Icons.add, color: AppColors.black),
                    iconSize: ResponsiveUtils.f(context, 18),
                  ),
                ],
              ),
            ),
            SizedBox(width: ResponsiveUtils.w(context, 12)),
          ],
          Expanded(
            child: Container(
              height: ResponsiveUtils.h(context, 60),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.p(context, 6),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 30),
                ),
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
                  onTap: widget.product.isOutOfStock
                      ? null
                      : () {
                          ref
                              .read(cartProvider.notifier)
                              .addItem(widget.product);
                        },
                  borderRadius: BorderRadius.circular(
                    ResponsiveUtils.r(context, 30),
                  ),
                  child: Center(
                    child: Text(
                      widget.product.isOutOfStock
                          ? 'Out of Stock'
                          : quantity > 0
                          ? 'Add More (\$${(widget.product.finalPrice * quantity).toStringAsFixed(2)})'
                          : 'Add to Cart',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
