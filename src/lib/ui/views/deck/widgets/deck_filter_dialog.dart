import 'package:flutter/material.dart';
import 'package:pokemon_deck/ui/common/app_colors.dart';
import 'package:pokemon_deck/utils/const/pokemon_constants.dart';

class DeckFilterDialog extends StatefulWidget {
  final String currentType;
  final Function(String) onFilterByType;

  const DeckFilterDialog({
    required this.currentType,
    required this.onFilterByType,
    super.key,
  });

  @override
  State<DeckFilterDialog> createState() => _DeckFilterDialogState();
}

class _DeckFilterDialogState extends State<DeckFilterDialog> {
  late String selectedType;

  @override
  void initState() {
    super.initState();
    selectedType = widget.currentType;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Pokémon'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select Type:'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  label: const Text('All'),
                  selected: selectedType.isEmpty,
                  onSelected: (selected) {
                    if (selected) {
                      setState(() => selectedType = '');
                    }
                  },
                ),
                ...PokemonConstants.types.map(
                  (type) => FilterChip(
                    label: Text(type),
                    selected: selectedType == type,
                    backgroundColor:
                        pokemonTypeColors[type]?.withOpacity(0.2) ??
                            Colors.grey,
                    onSelected: (selected) {
                      setState(() => selectedType = selected ? type : '');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onFilterByType(selectedType);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
