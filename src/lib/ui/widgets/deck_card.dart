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
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline, size: 100),
                  ),
                ),
                Text(
                  pokemon.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'HP: ${pokemon.hp}',
                  style: const TextStyle(fontSize: 14),
                ),
                Text(
                  'Type: ${pokemon.type}',
                  style: const TextStyle(fontSize: 14),
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
}
