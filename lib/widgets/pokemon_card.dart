import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:poke_fly/models/type_color.dart';
import 'package:poke_fly/utils/string_extension.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

  Color _getCardColor() {
    return TypeColor.typeColors[pokemon.types[0]] != null ? TypeColor.typeColors[pokemon.types[0]][0] : TypeColor.typeColors['normal'][0];
  }

  Color _getTypeColor(String type) {
    return TypeColor.typeColors[type] != null ? TypeColor.typeColors[type][1] : TypeColor.typeColors['normal'][1];
  }

  List<Widget> _buildTypeTags(BuildContext context) {
    return pokemon.types.map(
      (type) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: _getTypeColor(type),
        ),
        margin: EdgeInsets.only(top: 8, right: 8),
        padding: EdgeInsets.all(4),
        child: Row(
          children: <Widget>[
            // add icons here for future improvement
            Text(
              type.firstLetterCapitalize(),
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 24),
            child: InkWell(
              onTap: () {
                // navigate to detail screen
              },
              splashColor: _getCardColor(),
              borderRadius: BorderRadius.circular(25),
              child: Card(
                color: _getCardColor(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('#${pokemon.id.toString()}'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          pokemon.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[..._buildTypeTags(context)],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: 0,
            child: Container(
              height: 150,
              width: 150,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image(
                  image: NetworkImage(
                      'https://pokeres.bastionbot.org/images/pokemon/${pokemon.id}.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
