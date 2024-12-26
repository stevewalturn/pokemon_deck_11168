import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';

class BattleViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();

  List<Pokemon> get playerDeck => _pokemonService.deck;
  List<Pokemon> get opponentDeck => _pokemonService.generateOpponentDeck();

  Pokemon? _selectedPlayerPokemon;
  Pokemon? _selectedOpponentPokemon;

  Pokemon? get selectedPlayerPokemon => _selectedPlayerPokemon;
  Pokemon? get selectedOpponentPokemon => _selectedOpponentPokemon;

  void selectPlayerPokemon(Pokemon pokemon) {
    if (pokemon.isDead) {
      setError('This Pokémon has fainted and cannot battle!');
      return;
    }
    _selectedPlayerPokemon = pokemon;
    notifyListeners();
  }

  void selectOpponentPokemon(Pokemon pokemon) {
    if (pokemon.isDead) {
      setError('This Pokémon has fainted and cannot battle!');
      return;
    }
    _selectedOpponentPokemon = pokemon;
    notifyListeners();
  }

  bool get canBattle =>
      _selectedPlayerPokemon != null && _selectedOpponentPokemon != null;

  void resetBattle() {
    _selectedPlayerPokemon = null;
    _selectedOpponentPokemon = null;
    notifyListeners();
  }
}
