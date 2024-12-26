import 'package:pokemon_deck/models/pokemon.dart';

enum PokemonSortCriteria {
  name,
  hp,
  type,
}

class PokemonSorter {
  static List<Pokemon> sort(
    List<Pokemon> pokemons,
    PokemonSortCriteria criteria, {
    bool ascending = true,
  }) {
    final sortedList = List<Pokemon>.from(pokemons);

    switch (criteria) {
      case PokemonSortCriteria.name:
        sortedList.sort((a, b) =>
            ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
      case PokemonSortCriteria.hp:
        sortedList.sort(
            (a, b) => ascending ? a.hp.compareTo(b.hp) : b.hp.compareTo(a.hp));
      case PokemonSortCriteria.type:
        sortedList.sort((a, b) =>
            ascending ? a.type.compareTo(b.type) : b.type.compareTo(a.type));
    }

    return sortedList;
  }
}
