class PokerPlayer {
  /// Список текущих карт в руке у игрока
  List<String> _currentHand = ['King of clubs', 'Nine of hearts'];

  /// Субъективная оценка выигрыша
  double _surenessInWin = 0;

  /// Вычислить шансы на выигрыш
  void calculateProbabilities(
      List<String> cardOnDesk,

      /// Это часть первого задания. [Strategy] пока не сущестивует.
      ///
      /// Опишите его.
      Strategy strategy,
      ) =>
      _surenessInWin = strategy(cardOnDesk, _currentHand);
}

/// определение типа Strategy
typedef Strategy = double Function (List<String>, List<String>);

void main() {
  final opponent = PokerPlayer();

  /// Это часть первого задания. [Strategy] пока не сущестивует.
  ///
  /// Опишите его.
  final Strategy fakeStrategy = (p0, p1) {
    /// Ваш код - здесь

    /// Получение рангов карт
    String cardRank(String hand){
      int startIndex = 0, indexOfSpace;

      indexOfSpace = hand.indexOf(' ', startIndex);
      if(indexOfSpace == -1){
        return hand;
      }
      startIndex = indexOfSpace + 1;

      return hand.substring(0, indexOfSpace);
    }

    /// получение мастей карт (не использовался)
    // String cardSuit(String hand){
    //   int startIndex = hand.length-1, indexOfSpace;
    //
    //   indexOfSpace = hand.indexOf(' ', startIndex);
    //   if(indexOfSpace == -1){
    //     return hand;
    //   }
    //   startIndex = indexOfSpace - 1;
    //
    //   return hand.substring(0, indexOfSpace);
    // }

    /// требование задания
    print("Opponent's cards are:\n");
    print("Hand:");
    print(p1[0]);
    print(p1[1]);

    print("\nDesk:");
    print(p0[0]);
    print(p0[1]);

    /// кусок реализации подсчёта шанса выигрыша с учётом комбинации карт
    /// не работает, т.к. написание King на столе отличается от руки
    if(cardRank(p0.elementAt(0))==cardRank(p1.elementAt(1)) &&
        cardRank(p0.elementAt(1))==cardRank(p1.elementAt(0))){
      return 0.8;
    }
    else{
      return 0.5;
    }
  };

  opponent.calculateProbabilities(
    ['Nine of diamonds', 'king of hearts'],
    fakeStrategy,
  );
}