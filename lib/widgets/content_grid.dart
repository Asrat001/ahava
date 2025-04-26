import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/content_provider.dart';
import 'content_card.dart';

class ContentGrid extends StatelessWidget {
  const ContentGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final contentProvider = Provider.of<ContentProvider>(context);
    final items = contentProvider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ContentCard(item: items[index]);
      },
    );
  }
}
