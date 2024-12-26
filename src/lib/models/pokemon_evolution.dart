import 'package:equatable/equatable.dart';

class PokemonEvolution extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int evolutionStage;
  final String? evolvesFromId;
  final String? evolvesToId;
  final int requiredLevel;

  const PokemonEvolution({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.evolutionStage,
    this.evolvesFromId,
    this.evolvesToId,
    required this.requiredLevel,
  });

  PokemonEvolution copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? evolutionStage,
    String? evolvesFromId,
    String? evolvesToId,
    int? requiredLevel,
  }) {
    return PokemonEvolution(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      evolutionStage: evolutionStage ?? this.evolutionStage,
      evolvesFromId: evolvesFromId ?? this.evolvesFromId,
      evolvesToId: evolvesToId ?? this.evolvesToId,
      requiredLevel: requiredLevel ?? this.requiredLevel,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        evolutionStage,
        evolvesFromId,
        evolvesToId,
        requiredLevel,
      ];
}
