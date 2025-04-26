import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/configs/app_color.dart';
import '../state/navigation_provider.dart';


class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final currentIndex = navigationProvider.currentIndex;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, currentIndex == 0, () => navigationProvider.setIndex(0)),
          _buildNavItem(Icons.search, currentIndex == 1, () => navigationProvider.setIndex(1)),
          _buildNavItem(Icons.play_circle_outline_outlined, currentIndex == 2, () => navigationProvider.setIndex(2)),
          _buildNavItem(Icons.favorite_border, currentIndex == 3, () => navigationProvider.setIndex(3)),
          _buildNavItem(Icons.person_outline, currentIndex == 4, () => navigationProvider.setIndex(4)),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : Colors.grey.shade400,
              size: 24,
            ),
            if (isSelected)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
