import 'package:flutter/material.dart';
import 'package:poke_fly/providers/pokemons_provider.dart';
import 'package:poke_fly/routes.dart';
import 'package:poke_fly/screens/detail_screen.dart';
import 'package:poke_fly/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (buildContext) => PokemonsProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Color(0xff959597),
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: routes,
      ),
    );
  }
}
