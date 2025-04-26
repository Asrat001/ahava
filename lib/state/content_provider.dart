import 'package:flutter/material.dart';
import '../data/model/content_item.dart';


class ContentProvider with ChangeNotifier {
  final List<String> _categories = [
    'For You',
    'Trending',
    'Food',
    'DIY',
    'Fitness',
    'Travel',
  ];

  String _selectedCategory = 'For You';

  final List<ContentItem> _items = [
    ContentItem(
      id: '1',
      title: 'How To Hang A Seamless Paper Backdrop',
      imageUrl: 'https://images.unsplash.com/photo-1542038784456-1ea8e935640e',
      views: 2500,
      category: 'DIY',
    ),
    ContentItem(
      id: '2',
      title: 'Yoga For A Toned Stomach',
      imageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b',
      views: 1100,
      category: 'Fitness',
    ),
    ContentItem(
      id: '3',
      title: 'How To Make Oreo Cake Pops',
      imageUrl: 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c',
      views: 4500,
      category: 'Food',
    ),
    ContentItem(
      id: '4',
      title: 'Signs For Tight Calves And How To Fix',
      imageUrl: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b',
      views: 750,
      category: 'Fitness',
    ),
    ContentItem(
      id: '5',
      title: 'Hike In The Mountains',
      imageUrl: 'https://images.unsplash.com/photo-1551632811-561732d1e306',
      views: 1800,
      category: 'Travel',
    ),
    ContentItem(
      id: '6',
      title: 'DIY Macrame Wall Hanging',
      imageUrl: 'https://images.unsplash.com/photo-1617791160505-6f00504e3519',
      views: 3200,
      category: 'DIY',
    ),
  ];

  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;

  List<ContentItem> get items {
    if (_selectedCategory == 'For You' || _selectedCategory == 'Trending') {
      return _items;
    }
    return _items.where((item) => item.category == _selectedCategory).toList();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  String formatViews(int views) {
    if (views >= 1000) {
      return '${(views / 1000).toStringAsFixed(1)}K';
    }
    return views.toString();
  }
}
