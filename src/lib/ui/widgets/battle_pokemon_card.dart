import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class BattlePokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isOpponent;

  const BattlePokemonCard({
    required this.pokemon,
    required this.isSelected,
    required this.onTap,
    this.isOpponent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pokemon.isDead ? null : onTap,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.yellow : Colors.transparent,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Card(
          color: pokemon.isDead
              ? Colors.grey.withOpacity(0.5)
              : (pokemonTypeColors[pokemon.type] ?? Colors.grey)
                  .withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Image.network(
                      pokemon.imageUrl,
                      height: 60,
                      width: 60,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_outline, size: 60),
                    ),
                    if (pokemon.isDead)
                      const Positioned.fill(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                  ],
                ),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                LinearProgressIndicator(
                  value: pokemon.healthPercentage,
                  backgroundColor: Colors.grey[300],
                  color: pokemon.healthPercentage > 0.5
                      ? Colors.green
                      : pokemon.healthPercentage > 0.2
                          ? Colors.orange
                          : Colors.red,
                ),
                Text(
                  'HP: ${pokemon.currentHp}/${pokemon.hp}',
                  style: TextStyle(
                    fontSize: 10,
                    color: pokemon.isDead ? Colors.red : Colors.black,
                  ),
                ),
                const Divider(),
                _buildStatRow('ATK', pokemon.attack),
                _buildStatRow('DEF', pokemon.defense),
                _buildStatRow('SPD', pokemon.speed),
                _buildStatRow('SP.A', pokemon.specialAttack),
                _buildStatRow('SP.D', pokemon.specialDefense),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
