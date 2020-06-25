import 'package:flutter/material.dart';
import 'package:poke_fly/providers/auth_provider.dart';
import 'package:poke_fly/providers/pokemons_provider.dart';
import 'package:poke_fly/routes.dart';
import 'package:poke_fly/screens/auth_screen.dart';
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
        ),
        ChangeNotifierProvider(
          create: (buildContext) => AuthProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          accentColor: Color(0xffF4F5F6),
          primaryColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: AuthScreen(),
        routes: routes,
      ),
    );
  }
}
