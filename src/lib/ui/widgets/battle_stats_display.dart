import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class BattleStatsDisplay extends StatelessWidget {
  final Pokemon playerPokemon;
  final Pokemon opponentPokemon;

  const BattleStatsDisplay({
    required this.playerPokemon,
    required this.opponentPokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildPokemonStats(playerPokemon, isPlayer: true),
          const Text(
            'VS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildPokemonStats(opponentPokemon, isPlayer: false),
        ],
      ),
    );
  }

  Widget _buildPokemonStats(Pokemon pokemon, {required bool isPlayer}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color:
            (pokemonTypeColors[pokemon.type] ?? Colors.grey).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            pokemon.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text('HP: ${pokemon.currentHp}/${pokemon.hp}'),
          const SizedBox(height: 4),
          _buildStatRow('Attack', pokemon.attack),
          _buildStatRow('Defense', pokemon.defense),
          _buildStatRow('Speed', pokemon.speed),
          _buildStatRow('Sp.Atk', pokemon.specialAttack),
          _buildStatRow('Sp.Def', pokemon.specialDefense),
          const SizedBox(height: 4),
          Text('Type: ${pokemon.type}'),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label:',
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(width: 8),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
