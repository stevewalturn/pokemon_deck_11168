import 'package:flutter/material.dart';
import 'package:pokemon_deck/utils/sorting/pokemon_sorter.dart';

class DeckSortButton extends StatelessWidget {
  final PokemonSortCriteria currentCriteria;
  final bool ascending;
  final Function(PokemonSortCriteria, bool) onSortChanged;

  const DeckSortButton({
    required this.currentCriteria,
    required this.ascending,
    required this.onSortChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PokemonSortCriteria>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sort),
          Icon(
            ascending ? Icons.arrow_upward : Icons.arrow_downward,
            size: 16,
          ),
        ],
      ),
      onSelected: (criteria) {
        if (criteria == currentCriteria) {
          onSortChanged(criteria, !ascending);
        } else {
          onSortChanged(criteria, true);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: PokemonSortCriteria.name,
          child: Text('Sort by Name'),
        ),
        const PopupMenuItem(
          value: PokemonSortCriteria.hp,
          child: Text('Sort by HP'),
        ),
        const PopupMenuItem(
          value: PokemonSortCriteria.type,
          child: Text('Sort by Type'),
        ),
      ],
    );
  }
}
