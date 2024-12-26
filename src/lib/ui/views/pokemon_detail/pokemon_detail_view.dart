import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';
import 'package:pokemon_deck/ui/views/pokemon_detail/pokemon_detail_viewmodel.dart';
import 'package:pokemon_deck/ui/widgets/pokemon_evolution_chain.dart';
import 'package:pokemon_deck/ui/widgets/pokemon_stats_display.dart';
import 'package:stacked/stacked.dart';

class PokemonDetailView extends StackedView<PokemonDetailViewModel> {
  final String pokemonId;

  const PokemonDetailView({
    required this.pokemonId,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PokemonDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.pokemon?.name ?? 'Pokemon Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: viewModel.goBack,
        ),
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.hasError
              ? Center(
                  child: Text(
                    viewModel.modelError.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              : viewModel.pokemon == null
                  ? const Center(child: Text('Pokemon not found'))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: pokemonTypeColors[viewModel.pokemon!.type]
                                  ?.withOpacity(0.2),
                            ),
                            child: Image.network(
                              viewModel.pokemon!.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error_outline, size: 100),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  viewModel.pokemon!.name,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Type: ${viewModel.pokemon!.type}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                Text(
                                  'Level: ${viewModel.pokemon!.level}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 16),
                                if (viewModel.evolutionChain.isNotEmpty)
                                  PokemonEvolutionChain(
                                    evolutionChain: viewModel.evolutionChain,
                                    currentPokemon: viewModel.pokemon!,
                                  ),
                                const SizedBox(height: 16),
                                PokemonStatsDisplay(
                                    pokemon: viewModel.pokemon!),
                                const SizedBox(height: 16),
                                const Text(
                                  'Moves:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...viewModel.pokemon!.moves.map(
                                  (move) => Card(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: const Icon(Icons.flash_on),
                                      title: Text(move),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
      floatingActionButton: !viewModel.hasError && viewModel.pokemon != null
          ? FloatingActionButton.extended(
              onPressed: viewModel.addToDeck,
              label: const Text('Add to Deck'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  @override
  PokemonDetailViewModel viewModelBuilder(BuildContext context) =>
      PokemonDetailViewModel();

  @override
  void onViewModelReady(PokemonDetailViewModel viewModel) =>
      viewModel.initialize(pokemonId);
}
