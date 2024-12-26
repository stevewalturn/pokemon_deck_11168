import 'package:pokemon_deck/app/app.locator.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/services/pokemon_service.dart';
import 'package:pokemon_deck/utils/sorting/pokemon_sorter.dart';
import 'package:pokemon_deck/utils/filtering/pokemon_filter.dart';
import 'package:stacked/stacked.dart';

class DeckViewModel extends BaseViewModel {
  final _pokemonService = locator<PokemonService>();

  PokemonSortCriteria _currentSortCriteria = PokemonSortCriteria.name;
  bool _sortAscending = true;
  String _currentTypeFilter = '';

  List<Pokemon> get deck => _pokemonService.deck;
  bool get isDeckEmpty => deck.isEmpty;
  bool get isDeckFull => _pokemonService.isDeckFull;

  PokemonSortCriteria get currentSortCriteria => _currentSortCriteria;
  bool get sortAscending => _sortAscending;
  String get currentTypeFilter => _currentTypeFilter;

  List<Pokemon> get filteredDeck {
    List<Pokemon> filtered = deck;

    if (_currentTypeFilter.isNotEmpty) {
      filtered = PokemonFilter.filterByType(filtered, _currentTypeFilter);
    }

    return PokemonSorter.sort(
      filtered,
      _currentSortCriteria,
      ascending: _sortAscending,
    );
  }

  void sortDeck(PokemonSortCriteria criteria, bool ascending) {
    _currentSortCriteria = criteria;
    _sortAscending = ascending;
    rebuildUi();
  }

  void filterByType(String type) {
    _currentTypeFilter = type;
    rebuildUi();
  }

  void removeFromDeck(String pokemonId) {
    try {
      _pokemonService.removeFromDeck(pokemonId);
      rebuildUi();
    } catch (e) {
      setError('Failed to remove Pokémon from deck: ${e.toString()}');
    }
  }

  void clearDeck() {
    try {
      _pokemonService.clearDeck();
      rebuildUi();
    } catch (e) {
      setError('Failed to clear deck: ${e.toString()}');
    }
  }
}
