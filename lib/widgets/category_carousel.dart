import 'package:flutter/material.dart';
import 'package:poke_fly/models/category.dart';
import 'package:poke_fly/providers/category_provider.dart';
import 'package:poke_fly/widgets/category_item.dart';
import 'package:provider/provider.dart';

class CategoryCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    final List<Category> categories = categoryProvider.categories;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: categoryProvider.categories
          .map((category) => CategoryItem(category))
          .toList(),
    );
  }
}
