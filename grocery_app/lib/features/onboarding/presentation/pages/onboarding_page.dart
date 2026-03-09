import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../home/presentation/pages/main_navigation_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  late AnimationController _cartController;
  late AnimationController _vegetablesController;
  late AnimationController _badgesController;
  late Animation<Offset> _cartSlideAnimation;
  late List<Animation<double>> _vegetableScaleAnimations;
  late Animation<double> _badge1ScaleAnimation;
  late Animation<double> _badge2ScaleAnimation;

  final List<String> _vegetables = ['🥬', '🍅', '🫑', '🥕', '🥦'];

  @override
  void initState() {
    super.initState();

    _cartController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _cartSlideAnimation =
        Tween<Offset>(begin: const Offset(2.0, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: _cartController, curve: Curves.easeOutBack),
        );

    _vegetablesController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _vegetableScaleAnimations = List.generate(
      _vegetables.length,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _vegetablesController,
          curve: Interval(
            index * 0.1,
            0.4 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      ),
    );

    _badgesController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _badge1ScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _badgesController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _badge2ScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _badgesController,
        curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      ),
    );

    _cartController.forward().then((_) {
      _vegetablesController.forward();
      _badgesController.forward();
    });
  }

  @override
  void dispose() {
    _cartController.dispose();
    _vegetablesController.dispose();
    _badgesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform.scale(
        scale: 1.2,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppConstants.backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform.scale(
            scale: 1 / 1.2,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.2,
                  colors: [
                    Colors.white.withValues(alpha: 0.85),
                    const Color(0xFFF5FFB3).withValues(alpha: 0.8),
                    const Color(0xFFCDFF00).withValues(alpha: 0.7),
                    const Color(0xFFB8E600).withValues(alpha: 0.85),
                    const Color(0xFF89A600).withValues(alpha: 0.95),
                  ],
                  stops: const [0.0, 0.2, 0.5, 0.75, 1.0],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ResponsiveUtils.p(context, 24)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 1),
                          Center(
                            child: SizedBox(
                              height: ResponsiveUtils.h(context, 350),
                              width: ResponsiveUtils.w(context, 280),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ..._buildAnimatedVegetables(),
                                  Positioned(
                                    top: ResponsiveUtils.h(context, 120),
                                    child: SlideTransition(
                                      position: _cartSlideAnimation,
                                      child: Center(
                                        child: Text(
                                          '🛒',
                                          style: TextStyle(
                                            fontSize: ResponsiveUtils.f(
                                              context,
                                              120,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: ResponsiveUtils.h(context, 50),
                                    right: ResponsiveUtils.w(context, 10),
                                    child: ScaleTransition(
                                      scale: _badge1ScaleAnimation,
                                      child: _buildFloatingBadge(
                                        'Naturally fresh, chemical-\nfree and nutritious',
                                        Icon(
                                          Icons.eco,
                                          color: AppColors.darkGreen,
                                          size: ResponsiveUtils.f(context, 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: ResponsiveUtils.h(context, 10),
                                    left: 0,
                                    child: ScaleTransition(
                                      scale: _badge2ScaleAnimation,
                                      child: _buildFloatingBadge(
                                        'Premium sweetness that\nadds color & flavor',
                                        Icon(
                                          Icons.star,
                                          color: AppColors.darkGreen,
                                          size: ResponsiveUtils.f(context, 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.h(context, 40)),
                          const Spacer(flex: 1),
                          Text(
                            AppConstants.onboardingTitle,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ResponsiveUtils.f(context, 28),
                                ),
                          ),
                          SizedBox(height: ResponsiveUtils.h(context, 16)),
                          Text(
                            AppConstants.onboardingSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.8,
                                  ),
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: ResponsiveUtils.f(context, 14),
                                ),
                          ),
                          SizedBox(height: ResponsiveUtils.h(context, 32)),
                          Container(
                            width: double.infinity,
                            height: ResponsiveUtils.h(context, 64),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.white, AppColors.white],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                ResponsiveUtils.r(context, 32),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryGreen.withValues(
                                    alpha: 0.4,
                                  ),
                                  blurRadius: ResponsiveUtils.r(context, 20),
                                  offset: Offset(
                                    0,
                                    ResponsiveUtils.h(context, 8),
                                  ),
                                ),
                              ],
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MainNavigationPage(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.r(context, 32),
                                ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.w(context, 24),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.shopping_cart_rounded,
                                        size: ResponsiveUtils.f(context, 20),
                                        color: AppColors.black,
                                      ),
                                      SizedBox(
                                        width: ResponsiveUtils.w(context, 12),
                                      ),
                                      Text(
                                        AppConstants.startButtonText,
                                        style: TextStyle(
                                          fontSize: ResponsiveUtils.f(
                                            context,
                                            18,
                                          ),
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: ResponsiveUtils.h(context, 24)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedVegetables() {
    final positions = [
      Offset(ResponsiveUtils.w(context, -30), ResponsiveUtils.h(context, 30)),
      Offset(0, ResponsiveUtils.h(context, -15)),
      Offset(ResponsiveUtils.w(context, -40), 0),
      Offset(ResponsiveUtils.w(context, 30), ResponsiveUtils.h(context, 5)),
      Offset(0, ResponsiveUtils.h(context, 35)),
    ];

    return List.generate(_vegetables.length, (index) {
      return AnimatedBuilder(
        animation: _vegetableScaleAnimations[index],
        builder: (context, child) {
          return Positioned(
            left: ResponsiveUtils.w(context, 120) + positions[index].dx,
            top: ResponsiveUtils.h(context, 125) + positions[index].dy,
            child: Transform.scale(
              scale: _vegetableScaleAnimations[index].value,
              child: Transform.rotate(
                angle: (index * 0.3) * _vegetableScaleAnimations[index].value,
                child: Text(
                  _vegetables[index],
                  style: TextStyle(
                    fontSize: ResponsiveUtils.f(context, 45),
                    shadows: [
                      Shadow(
                        blurRadius: ResponsiveUtils.r(context, 4),
                        color: Colors.black26,
                        offset: Offset(
                          ResponsiveUtils.w(context, 2),
                          ResponsiveUtils.h(context, 2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildFloatingBadge(String text, Icon icon) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.p(context, 12),
        vertical: ResponsiveUtils.p(context, 8),
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.r(context, 20)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            blurRadius: ResponsiveUtils.r(context, 10),
            offset: Offset(0, ResponsiveUtils.h(context, 4)),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          SizedBox(width: ResponsiveUtils.w(context, 8)),
          Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveUtils.f(context, 11),
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
