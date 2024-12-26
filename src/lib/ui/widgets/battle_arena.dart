import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/widgets/battle_pokemon_card.dart';
import 'package:pokemon_deck/ui/widgets/battle_stats_display.dart';

class BattleArena extends StatelessWidget {
  final List<Pokemon> playerDeck;
  final List<Pokemon> opponentDeck;
  final Pokemon? selectedPlayerPokemon;
  final Pokemon? selectedOpponentPokemon;
  final Function(Pokemon) onPlayerPokemonSelected;
  final Function(Pokemon) onOpponentPokemonSelected;

  const BattleArena({
    required this.playerDeck,
    required this.opponentDeck,
    required this.selectedPlayerPokemon,
    required this.selectedOpponentPokemon,
    required this.onPlayerPokemonSelected,
    required this.onOpponentPokemonSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (playerDeck.isEmpty) {
      return const Center(
        child: Text(
          'Add Pokémon to your deck to start battling!',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return Column(
      children: [
        // Opponent's deck
        if (opponentDeck.isNotEmpty)
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: opponentDeck.length,
              itemBuilder: (context, index) {
                final pokemon = opponentDeck[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BattlePokemonCard(
                    pokemon: pokemon,
                    isSelected: selectedOpponentPokemon?.id == pokemon.id,
                    onTap: () => onOpponentPokemonSelected(pokemon),
                    isOpponent: true,
                  ),
                );
              },
            ),
          ),

        // Battle stats display
        if (selectedPlayerPokemon != null && selectedOpponentPokemon != null)
          BattleStatsDisplay(
            playerPokemon: selectedPlayerPokemon!,
            opponentPokemon: selectedOpponentPokemon!,
          ),

        // Player's deck
        SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: playerDeck.length,
            itemBuilder: (context, index) {
              final pokemon = playerDeck[index];
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: BattlePokemonCard(
                  pokemon: pokemon,
                  isSelected: selectedPlayerPokemon?.id == pokemon.id,
                  onTap: () => onPlayerPokemonSelected(pokemon),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
