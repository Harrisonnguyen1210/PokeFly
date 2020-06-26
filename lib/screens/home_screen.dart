import 'package:flutter/material.dart';
import 'package:poke_fly/providers/pokemons_provider.dart';
import 'package:poke_fly/utils/error_dialog.dart';
import 'package:provider/provider.dart';
import 'package:poke_fly/widgets/pokemon_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isLoadingPokemons = false;

  @override
  void initState() {
    super.initState();
    _isLoadingPokemons = true;
    try {
      Provider.of<PokemonsProvider>(context, listen: false)
          .fetchPokemons()
          .then((_) {
        setState(() {
          _isLoadingPokemons = false;
        });
      });
    } catch (e) {
      ErrorDialog.showErrorDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoadingPokemons
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 48,
                          bottom: 16,
                          left: 24,
                          right: 24,
                        ),
                        child: Text(
                          'PokéFly',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 24,
                          left: 24,
                          right: 24,
                        ),
                        child: Text('Gotta catch \'em all!'),
                      ),
                      PokemonList()
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
