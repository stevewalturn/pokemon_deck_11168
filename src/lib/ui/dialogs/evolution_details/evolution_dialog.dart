import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';
import 'package:pokemon_deck/ui/dialogs/evolution_details/evolution_dialog_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EvolutionDialog extends StackedView<EvolutionDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EvolutionDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EvolutionDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Evolution Progress',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPokemonInfo(viewModel.fromPokemon, 'Current'),
                const Icon(Icons.arrow_forward),
                _buildPokemonInfo(viewModel.toPokemon, 'Evolution'),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    'Requirements:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Level: ${viewModel.evolution.requiredLevel}'),
                  Text('Trigger: ${viewModel.evolution.evolutionTrigger}'),
                  if (viewModel.evolution.isComplete)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 30,
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => completer(DialogResponse(confirmed: true)),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonInfo(Pokemon pokemon, String label) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: pokemonTypeColors[pokemon.type]?.withOpacity(0.2),
            borderRadius: BorderRadius.circular(8),
          ),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Level: ${pokemon.level}'),
            ],
          ),
        ),
      ],
    );
  }

  @override
  EvolutionDialogModel viewModelBuilder(BuildContext context) {
    final model = EvolutionDialogModel();
    model.initialize(request.data as Map<String, dynamic>);
    return model;
  }
}
