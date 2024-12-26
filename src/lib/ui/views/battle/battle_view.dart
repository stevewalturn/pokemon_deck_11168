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
    if (viewModel.isBusy) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

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
      body: Column(
        children: [
          if (viewModel.modelError != null)
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.red.withOpacity(0.2),
              child: Text(
                viewModel.modelError.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BattleArena(
                playerDeck: viewModel.playerDeck,
                opponentDeck: viewModel.opponentDeck,
                selectedPlayerPokemon: viewModel.selectedPlayerPokemon,
                selectedOpponentPokemon: viewModel.selectedOpponentPokemon,
                onPlayerPokemonSelected: viewModel.selectPlayerPokemon,
                onOpponentPokemonSelected: viewModel.selectOpponentPokemon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BattleViewModel viewModelBuilder(BuildContext context) => BattleViewModel();

  @override
  void onViewModelReady(BattleViewModel viewModel) => viewModel.initialize();
}
