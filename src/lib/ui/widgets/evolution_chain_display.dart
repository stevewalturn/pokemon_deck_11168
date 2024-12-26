import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/models/pokemon_evolution.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';

class EvolutionChainDisplay extends StatelessWidget {
  final List<PokemonEvolution> evolutions;
  final Pokemon currentPokemon;
  final Function(PokemonEvolution) onEvolutionTap;

  const EvolutionChainDisplay({
    required this.evolutions,
    required this.currentPokemon,
    required this.onEvolutionTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (evolutions.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'This Pokémon does not evolve.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evolution Chain',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...evolutions.map((evolution) => _buildEvolutionStep(evolution)),
          ],
        ),
      ),
    );
  }

  Widget _buildEvolutionStep(PokemonEvolution evolution) {
    final isCurrentPokemon = evolution.fromPokemonId == currentPokemon.id;
    final backgroundColor = isCurrentPokemon
        ? pokemonTypeColors[currentPokemon.type]?.withOpacity(0.2)
        : Colors.transparent;

    return InkWell(
      onTap: () => onEvolutionTap(evolution),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              evolution.isComplete
                  ? Icons.check_circle
                  : Icons.arrow_forward_ios,
              color: evolution.isComplete ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level ${evolution.requiredLevel}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Trigger: ${evolution.evolutionTrigger}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
