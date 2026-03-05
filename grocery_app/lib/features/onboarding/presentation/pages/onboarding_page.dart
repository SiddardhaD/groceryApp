import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
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
                  radius: 1.0,
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.5),
                    AppColors.lightGreen.withOpacity(0.4),
                    AppColors.primaryGreen.withOpacity(0.5),
                    AppColors.primaryGreen.withOpacity(0.9),
                  ],
                  stops: const [0.0, 0.1, 0.5, 0.75, 1.0],
                ),
              ),
              child: SafeArea(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.largePadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(flex: 1),
                          Center(
                            child: SizedBox(
                              height: 350,
                              width: 280,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ..._buildAnimatedVegetables(),
                                  Positioned(
                                    top: 120,
                                    child: SlideTransition(
                                      position: _cartSlideAnimation,
                                      child: const Center(
                                        child: Text(
                                          '🛒',
                                          style: TextStyle(fontSize: 120),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 50,
                                    right: 10,
                                    child: ScaleTransition(
                                      scale: _badge1ScaleAnimation,
                                      child: _buildFloatingBadge(
                                        'Naturally fresh, chemical-\nfree and nutritious',
                                        const Icon(
                                          Icons.eco,
                                          color: AppColors.darkGreen,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    child: ScaleTransition(
                                      scale: _badge2ScaleAnimation,
                                      child: _buildFloatingBadge(
                                        'Premium sweetness that\nadds color & flavor',
                                        const Icon(
                                          Icons.star,
                                          color: AppColors.darkGreen,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),
                          const Spacer(flex: 1),
                          Text(
                            AppConstants.onboardingTitle,
                            style: Theme.of(context).textTheme.displayLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppConstants.onboardingSubtitle,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppColors.textPrimary.withValues(
                                    alpha: 0.8,
                                  ),
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainNavigationPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                foregroundColor: AppColors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.shopping_cart, size: 24),
                                  const SizedBox(width: 12),
                                  Text(
                                    AppConstants.startButtonText,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
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
      const Offset(-30, 30),
      const Offset(0, -15),
      const Offset(-40, 0),
      const Offset(30, 5),
      const Offset(0, 35),
    ];

    return List.generate(_vegetables.length, (index) {
      return AnimatedBuilder(
        animation: _vegetableScaleAnimations[index],
        builder: (context, child) {
          return Positioned(
            left: 120 + positions[index].dx,
            top: 125 + positions[index].dy,
            child: Transform.scale(
              scale: _vegetableScaleAnimations[index].value,
              child: Transform.rotate(
                angle: (index * 0.3) * _vegetableScaleAnimations[index].value,
                child: Text(
                  _vegetables[index],
                  style: const TextStyle(
                    fontSize: 45,
                    shadows: [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(2, 2),
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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.lightGreen.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.black : AppColors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
