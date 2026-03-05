import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
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
      backgroundColor: AppColors.primaryGreen,
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // User Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.darkGreen,
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                user.avatarUrl ?? '👤',
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppConstants.welcomeBack,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textPrimary.withOpacity(0.7),
                                    ),
                              ),
                              Text(
                                user.name,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined),
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Title
                  Text(
                    AppConstants.planGrocery,
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Row(
                    children: [
                      Text('🛒', style: TextStyle(fontSize: 28)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Search Bar and Location
                  const HomeSearchBar(),
                ],
              ),
            ),
            
            // Content Section (White Background)
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      
                      // Categories
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories.map((category) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: CategoryChip(category: category),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Best Value Days
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: Text(
                          AppConstants.bestValueDays,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.defaultPadding,
                          ),
                          itemCount: deals.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: DealCard(deal: deals[index]),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // Repeat & Save Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppConstants.repeatAndSave,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 12),
                            
                            // Tabs
                            Row(
                              children: [
                                _buildTab(
                                  context,
                                  AppConstants.bestPrices,
                                  isSelected: true,
                                ),
                                const SizedBox(width: 16),
                                _buildTab(
                                  context,
                                  AppConstants.orderAgain,
                                  isSelected: false,
                                ),
                                const SizedBox(width: 16),
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
                      const SizedBox(height: 16),
                      
                      // Products Grid
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.defaultPadding,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            return ProductCard(product: products[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String text, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        border: isSelected
            ? const Border(
                bottom: BorderSide(color: AppColors.black, width: 2),
              )
            : null,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? AppColors.black : AppColors.textSecondary,
            ),
      ),
    );
  }
}
