import 'dart:math';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/utils/const/pokemon_constants.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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

  Future<void> init() async {
    await initializePokemon();
  }

  Future<void> initializePokemon() async {
    if (_pokemons.isEmpty) {
      for (int i = 1; i <= 20; i++) {
        String? evolvesFromId;
        String? evolvesToId;
        int evolutionStage = 1;

        // Find evolution chain for this Pokemon
        for (var chain in PokemonConstants.evolutionChains.entries) {
          final chainIndex = chain.value.indexOf(i.toString());
          if (chainIndex != -1) {
            evolutionStage = chainIndex + 1;
            evolvesFromId = chainIndex > 0 ? chain.value[chainIndex - 1] : null;
            evolvesToId = chainIndex < chain.value.length - 1
                ? chain.value[chainIndex + 1]
                : null;
            break;
          }
        }

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
            evolvesFromId: evolvesFromId,
            evolvesToId: evolvesToId,
            evolutionStage: evolutionStage,
            level: evolutionStage * 15 + _random.nextInt(10),
          ),
        );
      }
    }
  }

  List<Pokemon> getEvolutionChain(String pokemonId) {
    try {
      String? chainKey;
      for (var entry in PokemonConstants.evolutionChains.entries) {
        if (entry.value.contains(pokemonId)) {
          chainKey = entry.key;
          break;
        }
      }

      if (chainKey == null) {
        return [getPokemon(pokemonId)!];
      }

      final chain = PokemonConstants.evolutionChains[chainKey]!;
      return chain.map((id) => getPokemon(id)).whereType<Pokemon>().toList();
    } catch (e) {
      throw Exception('Failed to load evolution chain for this Pokémon.');
    }
  }

  Future<void> initializeBattle() async {
    if (_deck.isEmpty) {
      throw Exception('Your deck is empty! Please add some Pokémon first.');
    }
    _opponentDeck = generateOpponentDeck();

    // Reset health for all Pokémon at battle start
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
    for (var pokemon in _deck) {
      pokemon = pokemon.copyWith(currentHp: pokemon.hp);
    }
  }
}
