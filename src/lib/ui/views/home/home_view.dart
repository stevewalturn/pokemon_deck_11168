import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/views/home/home_viewmodel.dart';
import 'package:pokemon_deck/ui/widgets/pokemon_card.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Collection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sports_mma),
            onPressed: viewModel.navigateToBattle,
          ),
          IconButton(
            icon: const Icon(Icons.view_agenda),
            onPressed: viewModel.navigateToDeck,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(child: CircularProgressIndicator())
          : viewModel.hasError
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      viewModel.modelError.toString(),
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: viewModel.pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = viewModel.pokemons[index];
                      return PokemonCard(
                        pokemon: pokemon,
                        onTap: () async {
                          if (!pokemon.inDeck && !viewModel.isDeckFull) {
                            await viewModel.addToDeck(pokemon);
                          } else {
                            viewModel.navigateToPokemonDetail(pokemon.id);
                          }
                        },
                      );
                    },
                  ),
                ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
