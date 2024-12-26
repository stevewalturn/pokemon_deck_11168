import 'package:equatable/equatable.dart';

class PokemonEvolution extends Equatable {
  final String fromPokemonId;
  final String toPokemonId;
  final int requiredLevel;
  final String evolutionTrigger;
  final bool isComplete;

  const PokemonEvolution({
    required this.fromPokemonId,
    required this.toPokemonId,
    required this.requiredLevel,
    required this.evolutionTrigger,
    this.isComplete = false,
  });

  PokemonEvolution copyWith({
    String? fromPokemonId,
    String? toPokemonId,
    int? requiredLevel,
    String? evolutionTrigger,
    bool? isComplete,
  }) {
    return PokemonEvolution(
      fromPokemonId: fromPokemonId ?? this.fromPokemonId,
      toPokemonId: toPokemonId ?? this.toPokemonId,
      requiredLevel: requiredLevel ?? this.requiredLevel,
      evolutionTrigger: evolutionTrigger ?? this.evolutionTrigger,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  @override
  List<Object?> get props => [
        fromPokemonId,
        toPokemonId,
        requiredLevel,
        evolutionTrigger,
        isComplete,
      ];
}
