import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:http/http.dart' as http;
import 'package:poke_fly/utils/string_extension.dart';

class PokemonsProvider extends ChangeNotifier {
  List<Pokemon> _pokemons = [];

  List<Pokemon> get pokemons {
    return _pokemons;
  }

  Future<void> fetchPokemons() async {
    final flyingPokemonsUrl = 'https://pokeapi.co/api/v2/type/3/';
    final flyingPokemonsResponse = await http.get(flyingPokemonsUrl);
    final flyingPokeJson =
        json.decode(flyingPokemonsResponse.body)['pokemon'] as List<dynamic>;
    final List<Pokemon> pokemonList = [];
    for (var pokemon in flyingPokeJson.sublist(0, 30)) {
      final pokemonUrl = pokemon['pokemon']['url'];
      pokemonList.add(await _fetchPokemon(pokemonUrl));
    }
    _pokemons = pokemonList;
    notifyListeners();
  }

  Future<Pokemon> _fetchPokemon(String pokemonUrl) async {
    final pokemonResponse = await http.get(pokemonUrl);
    final pokemonJson =
        json.decode(pokemonResponse.body) as Map<String, dynamic>;
    final typesResponse = pokemonJson['types'] as List<dynamic>;
    final List<String> pokemonTypes = [];
    typesResponse.forEach((type) {
      pokemonTypes.add(type['type']['name']);
    });
    return Pokemon(
      id: pokemonJson['id'],
      name: pokemonJson['name'].toString().firstLetterCapitalize(),
      height: pokemonJson['height'],
      types: pokemonTypes,
    );
  }
}
