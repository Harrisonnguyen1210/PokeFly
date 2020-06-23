import 'package:flutter/material.dart';

class Pokemon {
  final int id;
  final String name;
  final int height;
  final List<String> types;
  bool isfavourite;

  Pokemon({
    @required this.id,
    @required this.name,
    @required this.height,
    @required this.types,
    this.isfavourite = false,
  });
}
