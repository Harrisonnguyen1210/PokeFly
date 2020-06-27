import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:poke_fly/models/category.dart';

class CategoryProvider extends ChangeNotifier {
  var _selectedCategoryId = 0;

  final List<Category> _categories = [
    Category(
      categoryId: 0,
      name: "Flying",
      icon: FontAwesomeIcons.featherAlt,
      color: Color(0xffA890F0),
    ),
    Category(
      categoryId: 1,
      name: "Electric",
      icon: FontAwesomeIcons.bolt,
      color: Color(0xffC6A114),
    ),
    Category(
      categoryId: 2,
      name: "Fire",
      icon: FontAwesomeIcons.fire,
      color: Color(0xffE24242),
    ),
    Category(
      categoryId: 3,
      name: "Water",
      icon: FontAwesomeIcons.water,
      color: Color(0xff6890F0),
    ),
  ];

  List<Category> get categories {
    return _categories;
  }

  int get selectedCategoryId {
    return _selectedCategoryId;
  }

  Color get selectedCategoryColor {
    return _categories
        .firstWhere((category) => category.categoryId == selectedCategoryId)
        .color;
  }

  void updateSelectedCategory(int categoryId) {
    _selectedCategoryId = categoryId;
    notifyListeners();
  }
}
