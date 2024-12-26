import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback onTap;
  final bool showAddButton;

  const PokemonCard({
    required this.pokemon,
    required this.onTap,
    this.showAddButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: pokemonTypeColors[pokemon.type]?.withOpacity(0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Center(
                    child: Image.network(
                      pokemon.imageUrl,
                      height: 120,
                      width: 120,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_outline, size: 120),
                    ),
                  ),
                  if (showAddButton && !pokemon.inDeck)
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.add_circle,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                  if (pokemon.inDeck)
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                ],
              ),
              Text(
                pokemon.name,
                style: const TextStyle(
                  fontSize: 18,
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
      ),
    );
  }
}
