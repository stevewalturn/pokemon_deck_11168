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
              : pokemonTypeColors[pokemon.type]?.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      pokemon.imageUrl,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_outline, size: 80),
                    ),
                    if (pokemon.isDead)
                      const Positioned.fill(
                        child: Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 60,
                        ),
                      ),
                  ],
                ),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
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
                    color: pokemon.isDead ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
