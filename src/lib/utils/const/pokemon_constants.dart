class PokemonConstants {
  static const maxDeckSize = 6;

  static const List<String> types = [
    'Normal',
    'Fire',
    'Water',
    'Electric',
    'Grass',
    'Ice',
    'Fighting',
    'Poison',
    'Ground',
    'Flying',
    'Psychic',
    'Bug',
    'Rock',
    'Ghost',
    'Dragon',
    'Dark',
    'Steel',
    'Fairy',
  ];

  static const Map<String, String> typeImages = {
    'Normal': 'assets/types/normal.png',
    'Fire': 'assets/types/fire.png',
    'Water': 'assets/types/water.png',
    'Electric': 'assets/types/electric.png',
    'Grass': 'assets/types/grass.png',
    'Ice': 'assets/types/ice.png',
    'Fighting': 'assets/types/fighting.png',
    'Poison': 'assets/types/poison.png',
    'Ground': 'assets/types/ground.png',
    'Flying': 'assets/types/flying.png',
    'Psychic': 'assets/types/psychic.png',
    'Bug': 'assets/types/bug.png',
    'Rock': 'assets/types/rock.png',
    'Ghost': 'assets/types/ghost.png',
    'Dragon': 'assets/types/dragon.png',
    'Dark': 'assets/types/dark.png',
    'Steel': 'assets/types/steel.png',
    'Fairy': 'assets/types/fairy.png',
  };

  static const List<String> commonMoves = [
    'Tackle',
    'Quick Attack',
    'Scratch',
    'Pound',
    'Slam',
    'Body Slam',
    'Take Down',
    'Double Edge',
    'Headbutt',
    'Growl',
    'Roar',
  ];

  static const List<String> evolutionTriggers = [
    'Level Up',
    'Trade',
    'Stone',
    'Friendship',
  ];

  static const int baseEvolutionLevel = 16;
  static const int secondEvolutionLevel = 36;
}
