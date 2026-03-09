import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../providers/home_providers.dart';
import '../../../profile/presentation/providers/user_providers.dart';
import '../widgets/category_chip.dart';
import '../widgets/deal_card.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);
    final categories = ref.watch(categoriesProvider);
    final deals = ref.watch(dealsProvider);
    final products = ref.watch(filteredProductsProvider);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Stack(
        children: [
          Container(
            height: ResponsiveUtils.h(context, 220),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD9FF40), Color(0xFFEFFF48)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Container(
            height: ResponsiveUtils.h(context, 220),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD9FF40), Color.fromARGB(255, 245, 245, 245)],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SizedBox(
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(ResponsiveUtils.p(context, 16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                  right: ResponsiveUtils.h(context, 70),
                                ),
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.p(context, 8),
                                  vertical: ResponsiveUtils.p(context, 8),
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.r(context, 35),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.black.withValues(
                                        alpha: 0.08,
                                      ),
                                      blurRadius: ResponsiveUtils.r(
                                        context,
                                        15,
                                      ),
                                      offset: Offset(
                                        0,
                                        ResponsiveUtils.h(context, 4),
                                      ),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: ResponsiveUtils.w(context, 40),
                                      height: ResponsiveUtils.h(context, 40),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        shape: BoxShape.circle,
                                        image: user.avatarUrl != null
                                            ? DecorationImage(
                                                image: NetworkImage(
                                                  user.avatarUrl!,
                                                ),
                                                fit: BoxFit.cover,
                                              )
                                            : null,
                                      ),
                                      child: user.avatarUrl == null
                                          ? Center(
                                              child: Text(
                                                '👤',
                                                style: TextStyle(
                                                  fontSize: ResponsiveUtils.f(
                                                    context,
                                                    24,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    SizedBox(
                                      width: ResponsiveUtils.w(context, 12),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppConstants.welcomeBack,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color:
                                                      AppColors.textSecondary,
                                                  fontSize: ResponsiveUtils.f(
                                                    context,
                                                    12,
                                                  ),
                                                ),
                                          ),
                                          Text(
                                            user.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: ResponsiveUtils.f(
                                                    context,
                                                    14,
                                                  ),
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.w(context, 12)),
                            Container(
                              width: ResponsiveUtils.w(context, 50),
                              height: ResponsiveUtils.h(context, 50),
                              decoration: const BoxDecoration(
                                color: AppColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.notifications_outlined),
                                color: AppColors.black,
                                iconSize: ResponsiveUtils.f(context, 24),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.h(context, 18)),

                        Row(
                          children: [
                            Text(
                              AppConstants.planGrocery,
                              style: Theme.of(context).textTheme.displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: ResponsiveUtils.f(context, 18),
                                  ),
                            ),
                            SizedBox(width: ResponsiveUtils.w(context, 12)),
                            Text(
                              '🛒',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.f(context, 18),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ResponsiveUtils.h(context, 20)),
                        const HomeSearchBar(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 245, 245),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            ResponsiveUtils.r(context, 20),
                          ),
                          topRight: Radius.circular(
                            ResponsiveUtils.r(context, 20),
                          ),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: ResponsiveUtils.h(context, 8)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.p(context, 16),
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: categories.map((category) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        right: ResponsiveUtils.w(context, 8),
                                      ),
                                      child: CategoryChip(category: category),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.h(context, 14)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.p(context, 20),
                              ),
                              child: Text(
                                AppConstants.bestValueDays,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 18),
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.h(context, 12)),
                            SizedBox(
                              height: ResponsiveUtils.h(context, 160),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.p(context, 16),
                                ),
                                itemCount: deals.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: ResponsiveUtils.w(context, 12),
                                    ),
                                    child: DealCard(deal: deals[index]),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.h(context, 20)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.p(context, 20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppConstants.repeatAndSave,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          fontSize: ResponsiveUtils.f(
                                            context,
                                            20,
                                          ),
                                        ),
                                  ),
                                  SizedBox(
                                    height: ResponsiveUtils.h(context, 20),
                                  ),
                                  Row(
                                    children: [
                                      _buildTab(
                                        context,
                                        AppConstants.bestPrices,
                                        isSelected: true,
                                      ),
                                      SizedBox(
                                        width: ResponsiveUtils.w(context, 16),
                                      ),
                                      _buildTab(
                                        context,
                                        AppConstants.orderAgain,
                                        isSelected: false,
                                      ),
                                      SizedBox(
                                        width: ResponsiveUtils.w(context, 16),
                                      ),
                                      _buildTab(
                                        context,
                                        AppConstants.trendingNow,
                                        isSelected: false,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.h(context, 16)),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.p(context, 16),
                              ),
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: ResponsiveUtils.w(
                                        context,
                                        12,
                                      ),
                                      mainAxisSpacing: ResponsiveUtils.h(
                                        context,
                                        12,
                                      ),
                                      childAspectRatio: 1,
                                    ),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return ProductCard(product: products[index]);
                                },
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.h(context, 24)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(
    BuildContext context,
    String text, {
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 4),
        vertical: ResponsiveUtils.p(context, 2),
      ),
      decoration: BoxDecoration(
        border: isSelected
            ? const Border(bottom: BorderSide(color: AppColors.black, width: 2))
            : null,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? AppColors.black : AppColors.textSecondary,
          fontSize: ResponsiveUtils.f(context, 14),
        ),
      ),
    );
  }
}
