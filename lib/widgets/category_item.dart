import 'package:flutter/material.dart';
import 'package:poke_fly/models/category.dart';
import 'package:poke_fly/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final isSelected =
        categoryProvider.selectedCategoryId == category.categoryId;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isSelected
                ? categoryProvider.selectedCategoryColor
                : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            icon: Icon(
              category.icon,
              color: isSelected
                  ? Theme.of(context).accentColor
                  : category.color,
              size: 30,
            ),
            onPressed: () {
              if (!isSelected)
                categoryProvider.updateSelectedCategory(category.categoryId);
            },
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          category.name,
          style: TextStyle(
            color: isSelected
                ? categoryProvider.selectedCategoryColor
                : Theme.of(context).accentColor,
          ),
        ),
      ],
    );
  }
}
