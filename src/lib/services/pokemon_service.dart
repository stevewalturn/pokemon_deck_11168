import 'dart:math';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/utils/const/pokemon_constants.dart';
import 'package:stacked/stacked.dart';

class PokemonService {
  final List<Pokemon> _pokemons = [];
  final List<Pokemon> _deck = [];
  List<Pokemon> _opponentDeck = [];
  final _random = Random();

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get deck => _deck
      .map((p) => p.copyWith(
            currentHp: p.hp,
          ))
      .toList();
  List<Pokemon> get opponentDeck => _opponentDeck;

  bool get isDeckFull => _deck.length >= PokemonConstants.maxDeckSize;

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
            currentHp: _random.nextInt(100) + 50,
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

  Future<void> initializeBattle() async {
    if (_deck.isEmpty) {
      throw Exception('Your deck is empty! Please add some Pokémon first.');
    }
    _opponentDeck = generateOpponentDeck();
  }

  List<Pokemon> generateOpponentDeck() {
    final availablePokemon = _pokemons
        .where((p) => !_deck.any((deckPokemon) => deckPokemon.id == p.id))
        .toList();

    if (availablePokemon.isEmpty) {
      throw Exception('No Pokémon available for opponent deck!');
    }

    final deckSize = min(PokemonConstants.maxDeckSize, availablePokemon.length);
    final newOpponentDeck = <Pokemon>[];

    for (var i = 0; i < deckSize; i++) {
      final randomIndex = _random.nextInt(availablePokemon.length);
      final selectedPokemon = availablePokemon[randomIndex];
      newOpponentDeck.add(selectedPokemon.copyWith(
        currentHp: selectedPokemon.hp,
      ));
      availablePokemon.removeAt(randomIndex);
    }

    return newOpponentDeck;
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
          'Your deck is full! Remove a Pokémon before adding a new one.');
    }

    final pokemon = getPokemon(pokemonId);
    if (pokemon == null) {
      throw Exception('Pokémon not found!');
    }

    if (_deck.any((p) => p.id == pokemonId)) {
      throw Exception('This Pokémon is already in your deck!');
    }

    _deck.add(pokemon.copyWith(inDeck: true));
    return true;
  }

  bool removeFromDeck(String pokemonId) {
    final index = _deck.indexWhere((pokemon) => pokemon.id == pokemonId);
    if (index == -1) {
      throw Exception('Pokémon not found in deck!');
    }

    _deck.removeAt(index);
    return true;
  }

  void clearDeck() {
    _deck.clear();
  }

  void resetBattle() {
    _opponentDeck = [];
  }
}
