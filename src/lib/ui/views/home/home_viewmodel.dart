import 'package:pokemon_deck/app/app.dialogs.dart';
import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/app/app.router.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _dialogService = locator<DialogService>();
  final _pokemonService = locator<PokemonService>();

  List<Pokemon> get pokemons => _pokemonService.pokemons;
  bool get isDeckFull => _pokemonService.isDeckFull;

  void navigateToDeck() {
    _navigationService.navigateToDeckView();
  }

  void navigateToPokemonDetail(String pokemonId) {
    _navigationService.navigateToPokemonDetailView(pokemonId: pokemonId);
  }

  Future<void> addToDeck(Pokemon pokemon) async {
    try {
      if (isDeckFull) {
        throw Exception('Your deck is full! Remove some Pokemon first.');
      }

      final dialogResponse = await _dialogService.showCustomDialog(
        variant: DialogType.addToDeck,
        data: pokemon,
      );

      if (dialogResponse?.confirmed ?? false) {
        _pokemonService.addToDeck(pokemon.id);
        rebuildUi();
      }
    } catch (e) {
      setError(e.toString());
    }
  }
}
