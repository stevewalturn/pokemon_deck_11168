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
                      height: 100,
                      width: 100,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error_outline, size: 100),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              _buildStatRow('HP', pokemon.hp),
              _buildStatRow('Attack', pokemon.attack),
              _buildStatRow('Defense', pokemon.defense),
              _buildStatRow('Speed', pokemon.speed),
              _buildStatRow('Sp.Atk', pokemon.specialAttack),
              _buildStatRow('Sp.Def', pokemon.specialDefense),
              const SizedBox(height: 4),
              Text(
                'Type: ${pokemon.type}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
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
