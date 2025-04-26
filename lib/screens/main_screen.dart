import 'package:ahava/screens/home_screen.dart';
import 'package:ahava/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../core/configs/app_color.dart';
import '../state/navigation_provider.dart';
import '../widgets/bottom_navigation.dart';
import 'create_screen.dart';
import 'explore_screen.dart';
import 'favorites_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:AppColors.surface, // Change this color as needed
      statusBarIconBrightness: Brightness.dark, // Set brightness accordingly
      systemNavigationBarColor: AppColors.background, // Change bottom navigation color
    ));
    // List of screens for each tab
    final screens = [

      //Home tab
      const HomeScreen(),
      // Explore tab
      const ExploreScreen(),
      // Create tab
      const CreateScreen(),
      // Favorites tab
      const FavoritesScreen(),
      // Profile tab
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(),
      body:screens[navigationProvider.currentIndex],
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}
