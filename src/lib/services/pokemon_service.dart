import 'dart:math';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/models/pokemon_evolution.dart';
import 'package:pokemon_deck/utils/const/pokemon_constants.dart';
import 'package:stacked/stacked.dart';

class PokemonService implements InitializableDependency {
  final List<Pokemon> _pokemons = [];
  final List<Pokemon> _deck = [];
  List<Pokemon> _opponentDeck = [];
  final List<PokemonEvolution> _evolutions = [];
  final _random = Random();

  List<Pokemon> get pokemons => _pokemons;
  List<Pokemon> get deck => _deck;
  List<Pokemon> get opponentDeck => _opponentDeck;
  bool get isDeckFull => _deck.length >= PokemonConstants.maxDeckSize;

  @override
  Future<void> init() async {
    await initializePokemon();
  }

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
            attack: _random.nextInt(100) + 50,
            defense: _random.nextInt(100) + 30,
            speed: _random.nextInt(100) + 40,
            specialAttack: _random.nextInt(100) + 60,
            specialDefense: _random.nextInt(100) + 40,
            level: _random.nextInt(50) + 1,
          ),
        );
      }
      _initializeEvolutions();
    }
  }

  void _initializeEvolutions() {
    for (int i = 0; i < _pokemons.length - 1; i += 3) {
      if (i + 2 < _pokemons.length) {
        // First evolution
        _evolutions.add(
          PokemonEvolution(
            fromPokemonId: _pokemons[i].id,
            toPokemonId: _pokemons[i + 1].id,
            requiredLevel: PokemonConstants.baseEvolutionLevel,
            evolutionTrigger: PokemonConstants.evolutionTriggers[
                _random.nextInt(PokemonConstants.evolutionTriggers.length)],
            isComplete:
                _pokemons[i].level >= PokemonConstants.baseEvolutionLevel,
          ),
        );

        // Second evolution
        _evolutions.add(
          PokemonEvolution(
            fromPokemonId: _pokemons[i + 1].id,
            toPokemonId: _pokemons[i + 2].id,
            requiredLevel: PokemonConstants.secondEvolutionLevel,
            evolutionTrigger: PokemonConstants.evolutionTriggers[
                _random.nextInt(PokemonConstants.evolutionTriggers.length)],
            isComplete:
                _pokemons[i + 1].level >= PokemonConstants.secondEvolutionLevel,
          ),
        );
      }
    }
  }

  List<PokemonEvolution> getEvolutionsForPokemon(String pokemonId) {
    return _evolutions
        .where((evolution) =>
            evolution.fromPokemonId == pokemonId ||
            evolution.toPokemonId == pokemonId)
        .toList();
  }

  Pokemon? getPokemon(String id) {
    try {
      return _pokemons.firstWhere((pokemon) => pokemon.id == id);
    } catch (e) {
      return null;
    }
  }

  // Rest of the existing methods remain unchanged...
  // Keeping all battle-related and deck management methods

  Future<void> initializeBattle() async {
    if (_deck.isEmpty) {
      throw Exception('Your deck is empty! Please add some Pokémon first.');
    }
    _opponentDeck = generateOpponentDeck();

    for (var pokemon in _deck) {
      pokemon = pokemon.copyWith(currentHp: pokemon.hp);
    }
    for (var pokemon in _opponentDeck) {
      pokemon = pokemon.copyWith(currentHp: pokemon.hp);
    }
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
    for (var pokemon in _deck) {
      pokemon = pokemon.copyWith(currentHp: pokemon.hp);
    }
  }
}
