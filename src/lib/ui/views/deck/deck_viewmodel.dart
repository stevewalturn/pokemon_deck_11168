import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';

class DeckViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();

  List<Pokemon> get deck => _pokemonService.deck;
  bool get isDeckEmpty => deck.isEmpty;
  bool get isDeckFull => _pokemonService.isDeckFull;

  void removeFromDeck(String pokemonId) {
    try {
      _pokemonService.removeFromDeck(pokemonId);
      rebuildUi();
    } catch (e) {
      setError(e.toString());
    }
  }

  void clearDeck() {
    _pokemonService.clearDeck();
    rebuildUi();
  }
}
