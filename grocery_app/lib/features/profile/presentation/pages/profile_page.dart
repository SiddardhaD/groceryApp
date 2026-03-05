import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/user_providers.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProfileProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            
            // Profile Header
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.darkGreen,
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  user.avatarUrl ?? '👤',
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            Text(
              user.name,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              user.email,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            const SizedBox(height: 32),
            
            // Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.defaultPadding,
              ),
              child: Column(
                children: [
                  _buildProfileOption(
                    context,
                    'My Orders',
                    Icons.shopping_bag_outlined,
                    () {},
                  ),
                  _buildProfileOption(
                    context,
                    'Addresses',
                    Icons.location_on_outlined,
                    () {},
                  ),
                  _buildProfileOption(
                    context,
                    'Payment Methods',
                    Icons.payment_outlined,
                    () {},
                  ),
                  _buildProfileOption(
                    context,
                    'Notifications',
                    Icons.notifications_outlined,
                    () {},
                  ),
                  _buildProfileOption(
                    context,
                    'Help & Support',
                    Icons.help_outline,
                    () {},
                  ),
                  _buildProfileOption(
                    context,
                    'About',
                    Icons.info_outline,
                    () {},
                  ),
                  const SizedBox(height: 24),
                  
                  // Logout Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.error, width: 2),
                        foregroundColor: AppColors.error,
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.black),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
