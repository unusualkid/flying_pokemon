class Pokemon {
  String name;

  Pokemon(String name) {
    // Capitalize pokemon name
    this.name = name[0].toUpperCase() + name.substring(1);
  }
}
