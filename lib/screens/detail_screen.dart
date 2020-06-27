import 'package:flutter/material.dart';
import 'package:poke_fly/models/pokemon.dart';
import 'package:poke_fly/models/type_color.dart';
import 'package:poke_fly/widgets/type_tag.dart';

class DetailScreen extends StatelessWidget {
  static const route = '/detail';

  List<Widget> _buildTypeTags(BuildContext context, Pokemon pokemon) {
    return pokemon.types.map((type) => TypeTag(type)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = ModalRoute.of(context).settings.arguments as Pokemon;
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: TypeColor.typeColors[pokemon.types[0]][0],
            ),
            ListView(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 16, left: 16),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24, right: 24),
                      child: Icon(
                        Icons.star,
                        color:
                            pokemon.isFavourite ? Colors.yellow : Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  height: 200,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Image(
                          image: NetworkImage(
                              'https://pokeres.bastionbot.org/images/pokemon/${pokemon.id}.png'),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('#${pokemon.id}'),
                            Text(
                              pokemon.name,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                ..._buildTypeTags(context, pokemon)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                  width: deviceSize.width,
                  height: MediaQuery.of(context).orientation == Orientation.portrait ? (deviceSize.height - 310) : deviceSize.height,
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Pokemon data',
                        style: TextStyle(
                            color: TypeColor.typeColors[pokemon.types[0]][0]),
                      ),
                      SizedBox(height: 48),
                      Row(
                        children: <Widget>[
                          Text('Height:'),
                          SizedBox(
                            width: 48,
                          ),
                          Text(
                            '${pokemon.height.toString()} cm',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          Text('Weight:'),
                          SizedBox(
                            width: 48,
                          ),
                          Text(
                            '${pokemon.weight.toString()} kg',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
