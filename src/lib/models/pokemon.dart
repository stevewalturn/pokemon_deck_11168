import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int hp;
  final int currentHp;
  final String type;
  final List<String> moves;
  final bool inDeck;
  final bool isActive;
  final int attack;
  final int defense;
  final int speed;
  final int specialAttack;
  final int specialDefense;
  final String? evolvesFromId;
  final String? evolvesToId;
  final int evolutionStage;
  final int level;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hp,
    this.currentHp = 0,
    required this.type,
    required this.moves,
    this.inDeck = false,
    this.isActive = false,
    required this.attack,
    required this.defense,
    required this.speed,
    required this.specialAttack,
    required this.specialDefense,
    this.evolvesFromId,
    this.evolvesToId,
    this.evolutionStage = 1,
    this.level = 1,
  });

  Pokemon copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? hp,
    int? currentHp,
    String? type,
    List<String>? moves,
    bool? inDeck,
    bool? isActive,
    int? attack,
    int? defense,
    int? speed,
    int? specialAttack,
    int? specialDefense,
    String? evolvesFromId,
    String? evolvesToId,
    int? evolutionStage,
    int? level,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      hp: hp ?? this.hp,
      currentHp: currentHp ?? this.currentHp,
      type: type ?? this.type,
      moves: moves ?? this.moves,
      inDeck: inDeck ?? this.inDeck,
      isActive: isActive ?? this.isActive,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      speed: speed ?? this.speed,
      specialAttack: specialAttack ?? this.specialAttack,
      specialDefense: specialDefense ?? this.specialDefense,
      evolvesFromId: evolvesFromId ?? this.evolvesFromId,
      evolvesToId: evolvesToId ?? this.evolvesToId,
      evolutionStage: evolutionStage ?? this.evolutionStage,
      level: level ?? this.level,
    );
  }

  double get healthPercentage => currentHp / hp;
  bool get isDead => currentHp <= 0;
  bool get canEvolve => evolvesToId != null && level >= evolutionStage * 20;

  @override
  List<Object?> get props => [
        id,
        name,
        imageUrl,
        hp,
        currentHp,
        type,
        moves,
        inDeck,
        isActive,
        attack,
        defense,
        speed,
        specialAttack,
        specialDefense,
        evolvesFromId,
        evolvesToId,
        evolutionStage,
        level,
      ];
}
