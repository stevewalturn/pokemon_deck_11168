import 'package:flutter/material.dart';

class EvolutionArrow extends StatelessWidget {
  final int requiredLevel;

  const EvolutionArrow({
    required this.requiredLevel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.arrow_forward,
          size: 24,
          color: Colors.grey,
        ),
        Text(
          'Level $requiredLevel',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
