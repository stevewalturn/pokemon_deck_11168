import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class PokemonStatsDisplay extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonStatsDisplay({
    required this.pokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: pokemonTypeColors[pokemon.type]?.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Base Stats',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildStatBar('HP', pokemon.hp, Colors.green),
          _buildStatBar('Attack', pokemon.attack, Colors.red),
          _buildStatBar('Defense', pokemon.defense, Colors.blue),
          _buildStatBar('Speed', pokemon.speed, Colors.yellow),
          _buildStatBar('Sp.Attack', pokemon.specialAttack, Colors.purple),
          _buildStatBar('Sp.Defense', pokemon.specialDefense, Colors.orange),
        ],
      ),
    );
  }

  Widget _buildStatBar(String label, int value, Color color) {
    const maxValue = 200.0; // Maximum possible stat value
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 14),
              ),
              Text(
                value.toString(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.grey[300],
              color: color,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
