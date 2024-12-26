import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/common/ui_helpers.dart';
import 'package:pokemon_deck/ui/views/deck/deck_viewmodel.dart';
import 'package:pokemon_deck/ui/widgets/deck_card.dart';
import 'package:pokemon_deck/ui/widgets/deck_organization_panel.dart';
import 'package:pokemon_deck/ui/views/deck/widgets/deck_filter_dialog.dart';
import 'package:stacked/stacked.dart';

class DeckView extends StackedView<DeckViewModel> {
  const DeckView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    DeckViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deck'),
        actions: [
          if (!viewModel.isDeckEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: viewModel.clearDeck,
            ),
        ],
      ),
      body: Column(
        children: [
          DeckOrganizationPanel(
            currentSortCriteria: viewModel.currentSortCriteria,
            ascending: viewModel.sortAscending,
            onSortChanged: viewModel.sortDeck,
            onFilterTap: () => showDialog(
              context: context,
              builder: (context) => DeckFilterDialog(
                currentType: viewModel.currentTypeFilter,
                onFilterByType: viewModel.filterByType,
              ),
            ),
          ),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : viewModel.hasError
                    ? Center(
                        child: Text(
                          viewModel.modelError.toString(),
                          style: const TextStyle(color: Colors.red),
                        ),
                      )
                    : viewModel.isDeckEmpty
                        ? const Center(
                            child: Text(
                              'Your deck is empty!\nAdd some Pokemon from the home screen.',
                              textAlign: TextAlign.center,
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
                              itemCount: viewModel.filteredDeck.length,
                              itemBuilder: (context, index) {
                                final pokemon = viewModel.filteredDeck[index];
                                return DeckCard(
                                  pokemon: pokemon,
                                  onRemove: () =>
                                      viewModel.removeFromDeck(pokemon.id),
                                );
                              },
                            ),
                          ),
          ),
        ],
      ),
    );
  }

  @override
  DeckViewModel viewModelBuilder(BuildContext context) => DeckViewModel();
}
