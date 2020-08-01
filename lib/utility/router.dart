import 'package:flutter/material.dart';
import 'package:flying_pokemon/widgets/favoritePage.dart';

const String favoritePageRoute = '/favoritePage';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case favoritePageRoute:
        var pokemons = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => FavoritePage(pokemons: pokemons));
      default:
        return MaterialPageRoute(
            maintainState: false,
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('no route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
