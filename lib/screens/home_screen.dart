import 'package:flutter/material.dart';
import 'package:poke_fly/providers/auth_provider.dart';
import 'package:poke_fly/providers/pokemons_provider.dart';
import 'package:poke_fly/utils/error_dialog.dart';
import 'package:poke_fly/widgets/category_carousel.dart';
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Do you want to logout?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(
                context,
                listen: false,
              ).logout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoadingPokemons
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              )
            : Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(
                          Rect.fromLTRB(0, 0, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image(
                        image: AssetImage(
                            'assets/images/pokemon_ball_background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 48,
                          bottom: 16,
                          left: 24,
                          right: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'PokéFly',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RaisedButton(
                              onPressed: () => _showLogoutDialog(context),
                              child: Text('Logout'),
                              color: Colors.blue[300],
                              textColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ],
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
                      CategoryCarousel(),
                      PokemonList()
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
