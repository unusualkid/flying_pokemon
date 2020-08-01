import 'package:flutter/material.dart';
import 'package:flying_pokemon/models/pokemon.dart';

class FavoritePage extends StatefulWidget {
  final Set<Pokemon> pokemons;

  FavoritePage({this.pokemons});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    final tiles = widget.pokemons.map(
      (Pokemon pokemon) {
        return ListTile(
          title: Text(
            pokemon.name,
          ),
        );
      },
    );
    final divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Pokemons'),
      ),
      body: ListView(children: divided),
    );
  }
}
