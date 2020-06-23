import 'package:flutter/material.dart';
import 'package:poke_fly/providers/pokemons_provider.dart';
import 'package:poke_fly/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';

class PokemonList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pokemonsProvider = Provider.of<PokemonsProvider>(context);
    final pokemons = pokemonsProvider.pokemons;
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: pokemons.length,
      itemBuilder: (context, index) => PokemonCard(pokemons[index]),
    );
  }
}
