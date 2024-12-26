import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/views/deck/widgets/deck_sort_button.dart';
import 'package:pokemon_deck/utils/sorting/pokemon_sorter.dart';

class DeckOrganizationPanel extends StatelessWidget {
  final PokemonSortCriteria currentSortCriteria;
  final bool ascending;
  final Function(PokemonSortCriteria, bool) onSortChanged;
  final VoidCallback onFilterTap;

  const DeckOrganizationPanel({
    required this.currentSortCriteria,
    required this.ascending,
    required this.onSortChanged,
    required this.onFilterTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: onFilterTap,
            tooltip: 'Filter Pokémon',
          ),
          const SizedBox(width: 8),
          DeckSortButton(
            currentCriteria: currentSortCriteria,
            ascending: ascending,
            onSortChanged: onSortChanged,
          ),
        ],
      ),
    );
  }
}
