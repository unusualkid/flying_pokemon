/* This class is used to retrive the pokemons of a specific type
  from https://pokeapi.co/
 */

class PokemonType {
  final String title; // the type can be 'normal', 'fighting', 'flying'...
  final List<dynamic> pokemons; // all the pokemons that belong to the type

  PokemonType({this.pokemons, this.title});

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    return PokemonType(
      pokemons: json['pokemon'],
      title: json['name'],
    );
  }
}
