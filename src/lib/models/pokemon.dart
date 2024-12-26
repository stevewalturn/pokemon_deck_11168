import 'package:equatable/equatable.dart';

class Pokemon extends Equatable {
  final String id;
  final String name;
  final String imageUrl;
  final int hp;
  final String type;
  final List<String> moves;
  final bool inDeck;

  const Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.hp,
    required this.type,
    required this.moves,
    this.inDeck = false,
  });

  Pokemon copyWith({
    String? id,
    String? name,
    String? imageUrl,
    int? hp,
    String? type,
    List<String>? moves,
    bool? inDeck,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      hp: hp ?? this.hp,
      type: type ?? this.type,
      moves: moves ?? this.moves,
      inDeck: inDeck ?? this.inDeck,
    );
  }

  @override
  List<Object?> get props => [id, name, imageUrl, hp, type, moves, inDeck];
}
