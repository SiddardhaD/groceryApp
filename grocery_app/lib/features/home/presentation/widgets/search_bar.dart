import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: ResponsiveUtils.h(context, 56),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 28)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: ResponsiveUtils.r(context, 10),
            offset: Offset(0, ResponsiveUtils.h(context, 4)),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ResponsiveUtils.p(context, 16),
              right: ResponsiveUtils.p(context, 8),
            ),
            child: Icon(
              Icons.search,
              color: AppColors.grey,
              size: ResponsiveUtils.f(context, 24),
            ),
          ),
          Text(
            AppConstants.searchHint,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: ResponsiveUtils.f(context, 14),
            ),
          ),
          // Expanded(
          //   child: TextField(
          //     onChanged: (value) {
          //       ref.read(searchQueryProvider.notifier).state = value;
          //     },
          //     decoration: InputDecoration(
          //       hintText: AppConstants.searchHint,
          //       hintStyle: TextStyle(
          //         color: AppColors.white,
          //         fontSize: ResponsiveUtils.f(context, 14),
          //       ),
          //       border: InputBorder.none,
          //       contentPadding: EdgeInsets.symmetric(
          //         horizontal: ResponsiveUtils.p(context, 8),
          //         vertical: ResponsiveUtils.p(context, 16),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.p(context, 6)),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.p(context, 16),
                vertical: ResponsiveUtils.p(context, 10),
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFEB3B), Color(0xFFFDD835)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(
                  ResponsiveUtils.r(context, 22),
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFFEB3B).withValues(alpha: 0.3),
                    blurRadius: ResponsiveUtils.r(context, 8),
                    offset: Offset(0, ResponsiveUtils.h(context, 2)),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on,
                    size: ResponsiveUtils.f(context, 16),
                    color: AppColors.black,
                  ),
                  SizedBox(width: ResponsiveUtils.w(context, 6)),
                  Text(
                    'Pocket 25.NH 254',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.f(context, 12),
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
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
}
