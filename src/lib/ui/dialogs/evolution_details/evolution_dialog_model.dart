import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/models/pokemon_evolution.dart';
import 'package:stacked/stacked.dart';

class EvolutionDialogModel extends BaseViewModel {
  late final Pokemon fromPokemon;
  late final Pokemon toPokemon;
  late final PokemonEvolution evolution;

  void initialize(Map<String, dynamic> data) {
    fromPokemon = data['fromPokemon'] as Pokemon;
    toPokemon = data['toPokemon'] as Pokemon;
    evolution = data['evolution'] as PokemonEvolution;
    notifyListeners();
  }
}
