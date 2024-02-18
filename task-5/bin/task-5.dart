/// Базовый класс человека Person
///
/// Используется в иерархии людей, связанных с киберспортом
abstract class Person {
  final String name;

  Person({
  required this.name,
  });

  /// вывод информации о человеке
  @override
  String toString() {
    return 'Class: $Person\nName: $name\n';
  }
}

class Gamer extends Person {
  final String team;
  final String preferredGame;
  final String preferredStrategy;
  final double? winRatio;

  Gamer({
    required super.name,
    this.preferredGame = 'none',
    this.preferredStrategy = 'none',
    this.team = 'none',
    this.winRatio,
  });

  @override
  String toString() {
    return 'Class: $Gamer\nName: $name\nTeam: $team\nGame: $preferredGame\nStrategy: $preferredStrategy\n';
  }
}

class ProfessionalPlayer extends Gamer {
  final String nickname;
  final String preferredRole;
  final int matchesPlayed;

  ProfessionalPlayer({
    this.matchesPlayed = 0,
    required this.nickname,
    required super.name,
    required super.preferredGame,
    this.preferredRole = 'none',
    super.preferredStrategy = 'none',
    required super.team,
    required super.winRatio,
  });

  @override
  String toString() {
    return 'Class: $ProfessionalPlayer\nName: $name\nTeam: $team\nGame: $preferredGame\nNickname: $nickname\nRole: $preferredRole\nStrategy: $preferredStrategy\nWin Rate: $winRatio\nMatches played: $matchesPlayed\n';
  }
}

class Coach extends Gamer {
  final int trophiesWon;

  Coach({
    required super.name,
    required super.preferredGame,
    required super.team,
    this.trophiesWon = 0,
    required super.winRatio,
  });

  @override
  String toString() {
    return 'Class: $Coach\nName: $name\nTeam: $team\nGame: $preferredGame\nWin Rate: $winRatio\nTrophies Won: $trophiesWon\n';
  }
}

class Commentator extends Gamer {
  final int matchesCommented;
  
  Commentator({
    this.matchesCommented = 0,
    required super.name,
    required super.preferredGame,
  });

  @override
  String toString() {
    return 'Class: $Commentator\nName: $name\nGame: $preferredGame\nMatches Commented: $matchesCommented\n';
  }
}

void main() {
  final eve = Gamer(name: 'Eve', preferredGame: 'Tic-Tac-Toe X-tended');
  print(eve);
  final frag = ProfessionalPlayer(name: 'Alexander Bashkirov', team: 'Computerra', preferredGame: 'Game.EXE', nickname: 'Frag Sibirskiy', preferredRole: 'Writer', winRatio: 0.95, matchesPlayed: 134);
  print(frag);
  final scott = Coach(name: 'Scott', team: 'Red Renegades', preferredGame: 'Calf-Life Rematch', winRatio: 0.78, trophiesWon: 7);
  print(scott);
  final anders = Commentator(name: 'Anders Blume', preferredGame: 'Counter-Spike', matchesCommented: 65);
  print(anders);
}