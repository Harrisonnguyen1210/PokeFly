import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pokemon extends ChangeNotifier {
  final int id;
  final String name;
  final int height;
  final List<String> types;
  bool isFavourite;

  Pokemon({
    @required this.id,
    @required this.name,
    @required this.height,
    @required this.types,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final url =
        'https://pokefly-31860.firebaseio.com/userFavourites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(isFavourite),
      );
      if (response.statusCode >= 400) {
        throw Exception();
      } else {
        isFavourite = !isFavourite;
        notifyListeners();
      }
    } catch (e) {
      throw e;
    }
  }
}
