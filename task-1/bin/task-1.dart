enum Countries { brazil, russia, turkish, spain, japan }

class Territory {
  int areaInHectare;
  List<String> crops;
  List<AgriculturalMachinery> machineries;

  Territory(
      this.areaInHectare,
      this.crops,
      this.machineries,
      );
}

class AgriculturalMachinery {
  final String id;
  final DateTime releaseDate;

  AgriculturalMachinery(
      this.id,
      this.releaseDate,
      );

  // Переопределяем оператор "==", что бы сравнивать объекты по значению
  @override
  bool operator ==(Object? other) {
    if (other is! AgriculturalMachinery) return false;
    if (other.id == id && other.releaseDate == releaseDate) return true;

    return false;
  }

  @override
  int get hashCode => id.hashCode ^ releaseDate.hashCode;
}

final mapBefore2010 = <Countries, List<Territory>>{
  Countries.brazil: [
    Territory(
      34,
      ['Кукуруза'],
      [
        AgriculturalMachinery(
          'Трактор Степан',
          DateTime(2001),
        ),
        AgriculturalMachinery(
          'Культиватор Сережа',
          DateTime(2007),
        ),
      ],
    ),
  ],
  Countries.russia: [
    Territory(
      14,
      ['Картофель'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Гранулятор Антон',
          DateTime(2009),
        ),
      ],
    ),
    Territory(
      19,
      ['Лук'],
      [
        AgriculturalMachinery(
          'Трактор Гена',
          DateTime(1993),
        ),
        AgriculturalMachinery(
          'Дробилка Маша',
          DateTime(1990),
        ),
      ],
    ),
  ],
  Countries.turkish: [
    Territory(
      43,
      ['Хмель'],
      [
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
        AgriculturalMachinery(
          'Сепаратор Марк',
          DateTime(2005),
        ),
      ],
    ),
  ],
};

final mapAfter2010 = {
  Countries.turkish: [
    Territory(
      22,
      ['Чай'],
      [
        AgriculturalMachinery(
          'Каток Кирилл',
          DateTime(2018),
        ),
        AgriculturalMachinery(
          'Комбаин Василий',
          DateTime(1998),
        ),
      ],
    ),
  ],
  Countries.japan: [
    Territory(
      3,
      ['Рис'],
      [
        AgriculturalMachinery(
          'Гидравлический молот Лена',
          DateTime(2014),
        ),
      ],
    ),
  ],
  Countries.spain: [
    Territory(
      29,
      ['Арбузы'],
      [
        AgriculturalMachinery(
          'Мини-погрузчик Максим',
          DateTime(2011),
        ),
      ],
    ),
    Territory(
      11,
      ['Табак'],
      [
        AgriculturalMachinery(
          'Окучник Саша',
          DateTime(2010),
        ),
      ],
    ),
  ],
};



// Здесь начинается мой код

void main (){
  final currentYear = DateTime.now().year; // Получение текущего года
  double average;
  int ageSum = 0;
  var allAge = [];
  Map<String, int> machinery = {}; // Объявление новой мапы (техника: год выпуска)

  // Заполнение мапы
  void fillMachinery(element){
    for (final territory in element){
      for (final vehicles in territory.machineries) {
        machinery[vehicles.id] = vehicles.releaseDate.year;
      }
    }
  }

  // Сортировка дат производства пузырьком, по нарастанию
  void sortAge() {
    for (int x = 0; x < allAge.length; x++) {
      for (int y = 0; y < allAge.length - x - 1; y++) {
        if (allAge[y] > allAge[y + 1]) {
          int num = allAge[y];
          allAge[y] = allAge[y + 1];
          allAge[y + 1] = num;
        }
      }
    }
    // Удаление 50% самых старых дат
    int z = (allAge.length/2).round();
    for (int x = allAge.length; x > z; x--) {
      allAge.remove(allAge[0]);
    }
  }

  // Удаление из мапы техники, чья дата производства осталась в очищенном ранее списке
  void removeNewMachinery(){
    for (int x = 0; x < machinery.length; x++) {
      for (int y = 0; y < allAge.length; y++) {
        machinery.removeWhere((key, value) => value == allAge[y]);
      }
    }
  }

  // Вызов заполнения мапы
  mapBefore2010.values.forEach((element) {
    fillMachinery(element);
  });

  mapAfter2010.values.forEach((element) {
    fillMachinery(element);
  });

  // Подсчёт суммарного срока эксплуатации техники и заполнение списка дат производства
  machinery.values.forEach((element) {
    ageSum += currentYear-element;
    allAge.add(element);
  });

  average = ageSum / machinery.length;
  print('Средний возраст всей техники: $average лет');

  sortAge();  // Вызов сортировки и очистки дат
  ageSum = 0;
  removeNewMachinery(); // Вызов удаления новой техники

  machinery.values.forEach((element) {
    ageSum += currentYear-element;
  });

  average = ageSum / machinery.length;
  print('Средний возраст 50% самой старой техники: $average лет');
}
