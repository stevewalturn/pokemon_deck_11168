import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class PokemonDetailViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();
  final _navigationService = locator<NavigationService>();

  Pokemon? _pokemon;
  Pokemon? get pokemon => _pokemon;

  void initialize(String pokemonId) {
    try {
      _pokemon = _pokemonService.getPokemon(pokemonId);
      if (_pokemon == null) {
        throw Exception('Pokemon not found!');
      }
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

  void goBack() {
    _navigationService.back();
  }
}
