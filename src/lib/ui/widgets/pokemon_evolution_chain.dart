import 'package:flutter/material.dart';
import 'package:pokemon_deck/models/pokemon.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';
import 'package:pokemon_deck/ui/widgets/evolution_arrow.dart';

class PokemonEvolutionChain extends StatelessWidget {
  final List<Pokemon> evolutionChain;
  final Pokemon currentPokemon;

  const PokemonEvolutionChain({
    required this.evolutionChain,
    required this.currentPokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evolution Chain',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildEvolutionChain(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEvolutionChain() {
    final List<Widget> chainWidgets = [];

    for (int i = 0; i < evolutionChain.length; i++) {
      final pokemon = evolutionChain[i];

      // Add Pokemon card
      chainWidgets.add(
        Container(
          decoration: BoxDecoration(
            border: pokemon.id == currentPokemon.id
                ? Border.all(color: Colors.yellow, width: 2)
                : null,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Card(
            color: pokemonTypeColors[pokemon.type]?.withOpacity(0.2),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.network(
                    pokemon.imageUrl,
                    height: 80,
                    width: 80,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.error_outline, size: 80),
                  ),
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Level ${pokemon.level}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Add arrow if not the last Pokemon
      if (i < evolutionChain.length - 1) {
        chainWidgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: EvolutionArrow(
              requiredLevel: evolutionChain[i + 1].evolutionStage * 20,
            ),
          ),
        );
      }
    }

    return chainWidgets;
  }
}
