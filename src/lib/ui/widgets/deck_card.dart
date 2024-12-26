import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class DeckCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onRemove;

  const DeckCard({
    required this.pokemon,
    required this.onRemove,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: pokemonTypeColors[pokemon.type]?.withOpacity(0.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    pokemon.imageUrl,
                    height: 80,
                    width: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline, size: 80),
                  ),
                ),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                _buildStatRow('HP', pokemon.hp),
                _buildStatRow('ATK', pokemon.attack),
                _buildStatRow('DEF', pokemon.defense),
                _buildStatRow('SPD', pokemon.speed),
                _buildStatRow('SP.A', pokemon.specialAttack),
                _buildStatRow('SP.D', pokemon.specialDefense),
                const SizedBox(height: 4),
                Text(
                  'Type: ${pokemon.type}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.remove_circle),
              color: Colors.red,
              onPressed: onRemove,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
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
