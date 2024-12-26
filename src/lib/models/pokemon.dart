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
    );
  }

  double get healthPercentage => currentHp / hp;

  bool get isDead => currentHp <= 0;

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
      ];
}
