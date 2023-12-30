// создание суперкласса Person
class Person {
  final String name;

  Person({
  required this.name,
  });

  // вывод информации о человеке
  @override
  String toString() {
    return 'Class: $Person\nName: $name\n';
  }
}

class Gamer extends Person {
  String team;
  String preferredGame;
  String preferredStrategy;
  double? winRatio;

  Gamer({
    required super.name,
    this.team = 'none',
    this.preferredGame = 'none',
    this.preferredStrategy = 'none',
    this.winRatio,
  });

  @override
  String toString() {
    return 'Class: $Gamer\nName: $name\nTeam: $team\nGame: $preferredGame\nStrategy: $preferredStrategy\n';
  }
}

class ProfessionalPlayer extends Gamer {
  String nickname;
  String preferredRole;
  int matchesPlayed;

  ProfessionalPlayer({
    required super.name,
    required super.team,
    required super.preferredGame,
    super.preferredStrategy = 'none',
    required super.winRatio,
    required this.nickname,
    this.preferredRole = 'none',
    this.matchesPlayed = 0,
  });

  @override
  String toString() {
    return 'Class: $ProfessionalPlayer\nName: $name\nTeam: $team\nGame: $preferredGame\nNickname: $nickname\nRole: $preferredRole\nStrategy: $preferredStrategy\nWin Rate: $winRatio\nMatches played: $matchesPlayed\n';
  }
}

class Coach extends Gamer {
  int trophiesWon;

  Coach({
    required super.name,
    required super.team,
    required super.preferredGame,
    required super.winRatio,
    this.trophiesWon = 0,
  });

  @override
  String toString() {
    return 'Class: $Coach\nName: $name\nTeam: $team\nGame: $preferredGame\nWin Rate: $winRatio\nTrophies Won: $trophiesWon\n';
  }
}

class Commentator extends Gamer {
  int matchesCommented;
  
  Commentator({
    required super.name,
    required super.preferredGame,
    this.matchesCommented = 0,
  });

  @override
  String toString() {
    return 'Class: $Commentator\nName: $name\nGame: $preferredGame\nMatches Commented: $matchesCommented\n';
  }
}

void main() {
  var mike = Person(name: 'Michael Travis');
  print(mike);
  var eve = Gamer(name: 'Eve', preferredGame: 'Tic-Tac-Toe X-tended');
  print(eve);
  var frag = ProfessionalPlayer(name: 'Alexander Bashkirov', team: 'Computerra', preferredGame: 'Game.EXE', nickname: 'Frag Sibirskiy', preferredRole: 'Writer', winRatio: 0.95, matchesPlayed: 134);
  print(frag);
  var scott = Coach(name: 'Scott', team: 'Red Renegades', preferredGame: 'Calf-Life Rematch', winRatio: 0.78, trophiesWon: 7);
  print(scott);
  var anders = Commentator(name: 'Anders Blume', preferredGame: 'Counter-Spike', matchesCommented: 65);
  print(anders);
}