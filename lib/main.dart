import 'package:flutter/material.dart';
import 'package:flying_pokemon/utility/router.dart';
import 'package:flying_pokemon/widgets/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flying Pokemons',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          subtitle1: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomePage(title: 'Flying Pokemons'),
      onGenerateRoute: Router.generateRoute,
    );
  }
}
