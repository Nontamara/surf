final articles = '''
1,хлеб,Бородинский,500,5
2,хлеб,Белый,200,15
3,молоко,Полосатый кот,50,53
4,молоко,Коровка,50,53
5,вода,Апельсин,25,100
6,вода,Бородинский,500,5
''';

// объявление списка товаров
class Product{
  List<String> products = [];
}

// инициализация интерфейса Filter
abstract class Filter {
  bool apply(product, filter) {
    return true;
  }
}

// реализация интерфейса для филтрации по категориям (равно фильтрующему значению)
class categoryFilter implements Filter{
  @override
  bool apply(product, filter){
    if(product == filter){
      return true;
    }
    else{
      return false;
    }
  }
}

// реализация интерфейса для филтрации по цене (меньше или равно фильтрующему значению)
class priceFilter implements Filter{
  @override
  bool apply(product, filter){
    if(product <= filter){
      return true;
    }
    else{
      return false;
    }
  }
}

// реализация интерфейса для филтрации по остаткам на складе (меньше фильтрующего значения)
class stockFilter implements Filter{
  @override
  bool apply(product, filter){
    if(product < filter){
      return true;
    }
    else{
      return false;
    }
  }
}

// функция фильтрации
// мне не нравится тот факт, что почти вся логика прописана здесь, а не в интерфейсах
// но пусть будет так
void applyFilter(products, filterType, filter) {
  switch (filterType){
    // блок фильтрации по категории
    case 'category':
      {
        for (int a=0; a<products.length; a++){ // перебор строк списка товаров
          int temp = 0;
          int tempPos = 0;
          String tempString = products[a];
          int counter = 0;
          String subString = '';
          bool printResult = false;
          for (int b=0; b<tempString.length; b++){ // посимвольное чтение строки
            ++temp;
            if (tempString[b] == ',' && counter == 1) { // проверка нахождения в нужном сегменте строки по запятым
              final categoryFilter cat = categoryFilter();
              if (cat.apply(tempString.substring(tempPos, temp-1), filter) == true){ // проверка соответствия товара фильтру
                subString += '${tempString.substring(tempPos, temp-1)}\t';
                tempPos = temp;
                counter++;
                printResult = true;
              }
            }
            // дописывание рублей в строку
            else if (tempString[b] == ',' && counter == 3) {
              subString += '${tempString.substring(tempPos, temp-1)}\t''рублей\t';
              tempPos = temp;
              counter++;
            }
            // разделение сегментов строки табами
            else if (tempString[b] == ',') {
              subString += '${tempString.substring(tempPos, temp-1)}\t';
              tempPos = temp;
              counter++;
            }
            // вывод полной строки с дописыванием шт
            else if (printResult == true && b == tempString.length-1) {
              subString += '${tempString.substring(tempPos, temp-1)}\tшт';
              print(subString);
            }
          }
        }
      }
    // блок фильтрации по цене
    case 'price':
      {
        for (int a=0; a<products.length; a++){
          int temp = 0;
          int tempPos = 0;
          String tempString = products[a];
          int counter = 0;
          String subString = '';
          bool printResult = false;
          for (int b=0; b<tempString.length; b++){
            ++temp;
            if (tempString[b] == ',' && counter == 3) {
              final priceFilter pri = priceFilter();
              if (pri.apply(int.parse(tempString.substring(tempPos, temp-1)), filter) == true){
                subString += '${tempString.substring(tempPos, temp-1)}\tрублей\t';
                tempPos = temp;
                counter++;
                printResult = true;
              }
            }
            else if (tempString[b] == ',') {
              subString += '${tempString.substring(tempPos, temp-1)}\t';
              tempPos = temp;
              counter++;
            }
            else if (printResult == true && b == tempString.length-1) {
              subString += '${tempString.substring(tempPos, temp-1)}\tшт';
              print(subString);
            }
          }
        }
      }
    // блок фильтрации по остаткам
    case "stock":
      {
        for (int a=0; a<products.length; a++){
          int temp = 0;
          int tempPos = 0;
          String tempString = products[a];
          int counter = 0;
          String subString = '';
          bool printResult = false;
          for (int b=0; b<tempString.length; b++){
            ++temp;
            if (counter == 4) {
              final stockFilter sto = stockFilter();
              if (sto.apply(int.parse(tempString.substring(tempPos, tempString.length-1)), filter) == true){
                subString += '${tempString.substring(tempPos, temp-1)}\t';
                counter++;
                printResult = true;
              }
            }
            else if (tempString[b] == ',' && counter == 3) {
              subString += '${tempString.substring(tempPos, temp-1)}\t''рублей';
              tempPos = temp;
              counter++;
            }
            else if (tempString[b] == ',') {
              subString += '${tempString.substring(tempPos, temp-1)}\t';
              tempPos = temp;
              counter++;
            }
            else if (printResult == true && b == tempString.length-1) {
              subString += '${tempString.substring(tempPos, temp-1)}\tшт';
              print(subString);
            }
          }
        }
      }
    default:
      print('Пожалуйста, введите поддерживаемый тип фильтрации (category/price/stock)');
  }
}

void main() {
  // построчная конвертация String с товарами в List
  Product goods = Product();
  final lines = '\n'.allMatches(articles).length;
  int temp = 0;
  int tempPos = 0;
  for (int a=0; a<lines; a++){
    tempPos = temp;
    for (int b=temp; ; b++){
      ++temp;
      if (articles[b] == '\n') {
        goods.products.add(articles.substring(tempPos, temp));
        break;
      }
    }
  }

  print('Фильтрация по типу (вода):');
  applyFilter(goods.products, 'category', 'вода');
  print('\nФильтрация по цене (не более 200 рублей):');
  applyFilter(goods.products, 'price', 200);
  print('\nФильтрация по остаткам на складе (меньше 6 шт):');
  applyFilter(goods.products, 'stock', 6);
  print('\nНеподдерживаемая филтрация (по вкусу):');
  applyFilter(goods.products, 'taste', 'безумно вкусно');
}
