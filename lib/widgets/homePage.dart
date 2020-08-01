import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flying_pokemon/models/pokemon.dart';
import 'package:flying_pokemon/models/pokemonType.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _biggerFont = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

  // Future to fetch
  Future<PokemonType> futurePokemonType;

  // List of all pokemons to show on homePage
  final _pokemons = <Pokemon>[];

  // Store user's favorite pokemons that he clicked on
  final _favoritePokemons = Set<Pokemon>();

  @override
  void initState() {
    super.initState();
    futurePokemonType = fetchPokemonType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _showFavorites,
          ),
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return FutureBuilder<PokemonType>(
      future: futurePokemonType,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List pokemons = snapshot.data.pokemons;
          for (var i = 0; i < pokemons.length; i++) {
            var pokemon = Pokemon(name: pokemons[i]['pokemon']['name']);
            _pokemons.add(pokemon);
          }
          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemBuilder: (context, i) {
              // If i is odd, add a divider
              if (i.isOdd)
                return Divider(
                  thickness: 2,
                );

              final index = i ~/ 2;
              return _buildRow(_pokemons[index]);
            },
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildRow(Pokemon pokemon) {
    final alreadySaved = _favoritePokemons.contains(pokemon);
    return ListTile(
      title: Text(
        // Capitalize pokemon name
        pokemon.name[0].toUpperCase() + pokemon.name.substring(1),
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.pink[200] : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _favoritePokemons.remove(pokemon);
          } else {
            _favoritePokemons.add(pokemon);
          }
        });
      },
    );
  }

  void _showFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = _favoritePokemons.map(
            (Pokemon pokemon) {
              return ListTile(
                title: Text(
                  pokemon.name,
                  style: _biggerFont,
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
        },
      ),
    );
  }

  Future<PokemonType> fetchPokemonType() async {
    final response = await http.get('https://pokeapi.co/api/v2/type/3');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return PokemonType.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
