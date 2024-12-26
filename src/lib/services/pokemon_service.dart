import 'dart:math';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/utils/const/pokemon_constants.dart';
import 'package:stacked/stacked.dart';

class PokemonService {
  final List<Pokemon> _pokemons = [];
  final List<Pokemon> _deck = [];
  final _random = Random();

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get deck => _deck;

  bool get isDeckFull => _deck.length >= PokemonConstants.maxDeckSize;

  // Initialize with some mock data
  Future<void> initializePokemon() async {
    if (_pokemons.isEmpty) {
      for (int i = 1; i <= 20; i++) {
        _pokemons.add(
          Pokemon(
            id: i.toString(),
            name: 'Pokemon $i',
            imageUrl:
                'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$i.png',
            hp: _random.nextInt(100) + 50,
            type: PokemonConstants
                .types[_random.nextInt(PokemonConstants.types.length)],
            moves: List.generate(
              2,
              (index) => PokemonConstants.commonMoves[
                  _random.nextInt(PokemonConstants.commonMoves.length)],
            ),
          ),
        );
      }
    }
  }

  Pokemon? getPokemon(String id) {
    try {
      return _pokemons.firstWhere((pokemon) => pokemon.id == id);
    } catch (e) {
      return null;
    }
  }

  bool addToDeck(String pokemonId) {
    if (isDeckFull) {
      throw Exception(
          'Your deck is full! Remove a Pokemon before adding a new one.');
    }

    final pokemon = getPokemon(pokemonId);
    if (pokemon == null) {
      throw Exception('Pokemon not found!');
    }

    if (_deck.any((p) => p.id == pokemonId)) {
      throw Exception('This Pokemon is already in your deck!');
    }

    _deck.add(pokemon.copyWith(inDeck: true));
    return true;
  }

  bool removeFromDeck(String pokemonId) {
    final index = _deck.indexWhere((pokemon) => pokemon.id == pokemonId);
    if (index == -1) {
      throw Exception('Pokemon not found in deck!');
    }

    _deck.removeAt(index);
    return true;
  }

  void clearDeck() {
    _deck.clear();
  }
}
