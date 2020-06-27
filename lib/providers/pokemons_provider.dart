import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:poke_fly/utils/string_extension.dart';

class PokemonsProvider extends ChangeNotifier {
  var _authToken;
  var _userId;

  List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons {
    return _pokemons;
  }

  void updateToken(String token) {
    _authToken = token;
  }

  void updateUserId(String userId) {
    _userId = userId;
  }

  Future<void> fetchPokemons() async {
    final flyingPokemonsUrl = 'https://pokeapi.co/api/v2/type/3/';
    final favouriteUrl =
        'https://pokefly-31860.firebaseio.com/userFavourites/$_userId.json?auth=$_authToken';
    final List<Pokemon> pokemonList = [];
    try {
      List responses = await Future.wait(
        [http.get(favouriteUrl), http.get(flyingPokemonsUrl)],
      );
      final flyingPokeJson =
          json.decode(responses[1].body)['pokemon'] as List<dynamic>;
      final favouriteJson = json.decode(responses[0].body);
      if (flyingPokeJson == null) {
        _pokemons = pokemonList;
        notifyListeners();
        return;
      }
      for (var pokemon in flyingPokeJson.sublist(0, 30)) {
        pokemonList
            .add(await _fetchPokemon(pokemon['pokemon']['url'], favouriteJson));
      }
      _pokemons = pokemonList;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<Pokemon> _fetchPokemon(
      String pokemonUrl, dynamic favouriteJson) async {
    final List<String> pokemonTypes = [];
    try {
      final pokemonResponse = await http.get(pokemonUrl);
      final pokemonJson =
          json.decode(pokemonResponse.body) as Map<String, dynamic>;
      final typesResponse = pokemonJson['types'] as List<dynamic>;
      typesResponse.forEach((type) {
        pokemonTypes.add(type['type']['name']);
      });
      return Pokemon(
        id: pokemonJson['id'],
        name: pokemonJson['name'].toString().firstLetterCapitalize(),
        weight: pokemonJson['weight'] * 0.1,
        height: pokemonJson['height'] * 10,
        types: pokemonTypes,
        isFavourite: favouriteJson == null
            ? false
            : favouriteJson[pokemonJson['id'].toString()] ?? false,
      );
    } catch (e) {
      throw e;
    }
  }
}
