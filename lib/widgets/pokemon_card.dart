import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:poke_fly/models/type_color.dart';
import 'package:poke_fly/providers/auth_provider.dart';
import 'package:poke_fly/screens/detail_screen.dart';
import 'package:poke_fly/utils/error_dialog.dart';
import 'package:poke_fly/widgets/type_tag.dart';
import 'package:provider/provider.dart';

class PokemonCard extends StatelessWidget {
  Color _getCardColor(Pokemon pokemon) {
    return TypeColor.typeColors[pokemon.types[0]] != null
        ? TypeColor.typeColors[pokemon.types[0]][0]
        : TypeColor.typeColors['normal'][0];
  }

  List<Widget> _buildTypeTags(BuildContext context, Pokemon pokemon) {
    return pokemon.types
        .map(
          (type) => TypeTag(type)
        )
        .toList();
  }

  void _showInSnackBar(BuildContext context, Pokemon pokemon) {
    Scaffold.of(context).hideCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Favourite ${pokemon.isFavourite ? 'added' : 'removed'}'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = Provider.of<Pokemon>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Container(
      height: 180,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 24),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, DetailScreen.route,
                    arguments: pokemon);
              },
              splashColor: _getCardColor(pokemon),
              borderRadius: BorderRadius.circular(25),
              child: Card(
                color: _getCardColor(pokemon),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Text(
                          pokemon.name,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Row(
                          children: <Widget>[
                            ..._buildTypeTags(context, pokemon)
                          ],
                        ),
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
          Positioned(
            top: 32,
            left: 8,
            child: IconButton(
              onPressed: () async {
                try {
                  await pokemon.toggleFavouriteStatus(
                      authProvider.token, authProvider.userId);
                  _showInSnackBar(context, pokemon);
                } catch (error) {
                  ErrorDialog.showErrorDialog(context);
                }
              },
              icon: Icon(
                Icons.star,
                color: pokemon.isFavourite ? Colors.yellow : Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
