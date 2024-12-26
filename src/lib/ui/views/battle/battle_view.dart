import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/views/battle/battle_viewmodel.dart';
import 'package:pokemon_deck/ui/widgets/battle_arena.dart';
import 'package:stacked/stacked.dart';

class BattleView extends StackedView<BattleViewModel> {
  const BattleView({super.key});

  @override
  Widget builder(
    BuildContext context,
    BattleViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Arena'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: viewModel.resetBattle,
          ),
        ],
      ),
      body: viewModel.isBusy
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    if (viewModel.modelError != null)
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.only(bottom: 16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          viewModel.modelError.toString(),
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    if (viewModel.playerDeck.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Your deck is empty! Add some Pokémon before starting a battle.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: BattleArena(
                          playerDeck: viewModel.playerDeck,
                          opponentDeck: viewModel.opponentDeck,
                          selectedPlayerPokemon:
                              viewModel.selectedPlayerPokemon,
                          selectedOpponentPokemon:
                              viewModel.selectedOpponentPokemon,
                          onPlayerPokemonSelected:
                              viewModel.selectPlayerPokemon,
                          onOpponentPokemonSelected:
                              viewModel.selectOpponentPokemon,
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  BattleViewModel viewModelBuilder(BuildContext context) => BattleViewModel();

  @override
  void onViewModelReady(BattleViewModel viewModel) => viewModel.initialize();
}
