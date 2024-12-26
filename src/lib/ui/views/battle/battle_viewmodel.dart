import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BattleViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();
  final _navigationService = locator<NavigationService>();

  List<Pokemon> get playerDeck => _pokemonService.deck;
  List<Pokemon> get opponentDeck => _pokemonService.opponentDeck;

  Pokemon? _selectedPlayerPokemon;
  Pokemon? _selectedOpponentPokemon;

  Pokemon? get selectedPlayerPokemon => _selectedPlayerPokemon;
  Pokemon? get selectedOpponentPokemon => _selectedOpponentPokemon;

  Future<void> initialize() async {
    setBusy(true);
    try {
      if (_pokemonService.deck.isEmpty) {
        setError(
            'Your deck is empty! Add some Pokémon before starting a battle.');
        return;
      }
      await _pokemonService.initializeBattle();
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

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
    setBusy(true);
    _selectedPlayerPokemon = null;
    _selectedOpponentPokemon = null;
    _pokemonService.resetBattle();
    initialize();
  }

  void clearSelections() {
    _selectedPlayerPokemon = null;
    _selectedOpponentPokemon = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _pokemonService.resetBattle();
    super.dispose();
  }
}
