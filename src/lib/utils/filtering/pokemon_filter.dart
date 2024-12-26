import 'package:pokemon_deck/models/pokemon.dart';

class PokemonFilter {
  static List<Pokemon> filterByType(List<Pokemon> pokemons, String type) {
    if (type.isEmpty) return pokemons;
    return pokemons.where((pokemon) => pokemon.type == type).toList();
  }

  static List<Pokemon> filterByName(List<Pokemon> pokemons, String query) {
    if (query.isEmpty) return pokemons;
    return pokemons
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static List<Pokemon> filterByHpRange(
      List<Pokemon> pokemons, int minHp, int maxHp) {
    return pokemons
        .where((pokemon) => pokemon.hp >= minHp && pokemon.hp <= maxHp)
        .toList();
  }
}
