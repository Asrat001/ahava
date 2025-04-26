
import 'package:flutter/material.dart';
import '../widgets/category_selector.dart';
import '../widgets/content_grid.dart';
import '../widgets/search_bar.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return       // Home tab - original content
      Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Search bar
              const CustomSearchBar(),

              // Categories
              const CategorySelector(),

              // Content grid
              const Expanded(
                child: ContentGrid(),
              ),
            ],
          ),
        ),
      );
  }
}


