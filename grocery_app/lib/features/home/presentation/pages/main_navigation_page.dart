import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/navigation_provider.dart';
import '../../../categories/presentation/pages/categories_page.dart';
import '../../../orders/presentation/pages/orders_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';
import 'home_page.dart';

class MainNavigationPage extends ConsumerWidget {
  const MainNavigationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navigationIndexProvider);

    final pages = [
      const HomePage(),
      const CategoriesPage(),
      const OrdersPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              ref.read(navigationIndexProvider.notifier).state = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedItemColor: AppColors.black,
            unselectedItemColor: AppColors.grey,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: true,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: AppConstants.homeLabel,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_outlined),
                activeIcon: Icon(Icons.grid_view),
                label: AppConstants.categoriesLabel,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.refresh_outlined),
                activeIcon: Icon(Icons.refresh),
                label: AppConstants.orderAgainLabel,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: AppConstants.profileLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
