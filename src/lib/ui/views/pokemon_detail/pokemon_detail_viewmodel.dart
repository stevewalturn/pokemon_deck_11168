import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/models/pokemon_evolution.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PokemonDetailViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();

  Pokemon? _pokemon;
  Pokemon? get pokemon => _pokemon;

  List<PokemonEvolution> _evolutions = [];
  List<PokemonEvolution> get evolutions => _evolutions;

  void initialize(String pokemonId) {
    try {
      _pokemon = _pokemonService.getPokemon(pokemonId);
      if (_pokemon == null) {
        throw Exception('Pokemon not found!');
      }
      _evolutions = _pokemonService.getEvolutionsForPokemon(pokemonId);
      rebuildUi();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> addToDeck() async {
    if (_pokemon == null) return;

    try {
      _pokemonService.addToDeck(_pokemon!.id);
      _navigationService.back();
    } catch (e) {
      setError(e.toString());
    }
  }

  Future<void> showEvolutionDetails(PokemonEvolution evolution) async {
    try {
      final fromPokemon = _pokemonService.getPokemon(evolution.fromPokemonId);
      final toPokemon = _pokemonService.getPokemon(evolution.toPokemonId);

      if (fromPokemon == null || toPokemon == null) {
        throw Exception('Evolution details not found');
      }

      await _dialogService.showDialog(
        title: 'Evolution Details',
        description: 'View evolution progress',
        data: {
          'fromPokemon': fromPokemon,
          'toPokemon': toPokemon,
          'evolution': evolution,
        },
      );
    } catch (e) {
      setError('Failed to show evolution details: ${e.toString()}');
    }
  }

  void goBack() {
    _navigationService.back();
  }
}
