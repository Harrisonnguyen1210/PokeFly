import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:poke_fly/widgets/type_tags.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

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
                print('LOL');
              },
              splashColor: Colors.lightGreen,
              borderRadius: BorderRadius.circular(25),
              child: Card(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('#01'),
                      Text(
                        'Kakuna',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      TypeTags(),
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
