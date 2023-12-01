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
  Product(this.id, this.category, this.name, this.price, this.stock);

  final int id;
  final String category;
  final String name;
  final int price;
  final int stock;

  // вывод атрибутов товара в консоль
  @override
  String toString() => '\n$id\t$category\t$name\t$price рублей\t$stock шт';
}

// функция фильтрации, получает на вход список товаров и интерфейс фильтрации
void applyFilter(List<Product> products, Filter filter) {
  final filteredProducts = products.where((product) => filter.apply(product));
  print(filteredProducts);
}

// инициализация интерфейса Filter
abstract class Filter {
  bool apply(Product product);
}

// функция конвертации строки товаров в список типа "product" с промежуточным списком
void articlesToProducts(String articles, List<Product> products) {
  List<String> goods = [];
  final lines = '\n'.allMatches(articles).length;
  int temp = 0;
  int tempPos = 0;
  for (int a=0; a<lines; a++){
    tempPos = temp;
    for (int b=temp; ; b++){
      ++temp;
      if (articles[b] == '\n') {
        goods.add(articles.substring(tempPos, temp));
        break;
      }
    }
  }
  for (int a=0; a<goods.length; a++){ // перебор строк списка товаров
    int temp = 0;
    int tempPos = 0;
    String tempString = goods[a];
    int counter = 0;
    int? id;
    String category = "";
    String name = "";
    int price = 0;
    int stock = 0;
    for (int b=0; b<tempString.length; b++){ // посимвольное чтение строки
      ++temp;
      if (tempString[b] == ',' && counter == 0) { // проверка нахождения в нужном сегменте строки по запятым
        id = int.parse(tempString.substring(tempPos, temp-1)); // запись значения сегмента строки во временную переменную, значение которой позже будет присвоено атрибуту товара
        tempPos = temp;
        counter++;
        b++;
      }
      if (tempString[b] == ',' && counter == 1) {
        category = tempString.substring(tempPos, temp);
        tempPos = temp+1;
        counter++;
        b++;
      }
      if (tempString[b] == ',' && counter == 2) {
        name = tempString.substring(tempPos, temp+1);
        tempPos = temp+2;
        counter++;
        b++;
      }
      if (tempString[b] == ',' && counter == 3) {
        price = int.parse(tempString.substring(tempPos, temp+2));
        tempPos = temp+3;
        counter++;
        b++;
      }
      if (tempString[b] == '\n' && counter == 4) {
        stock = int.parse(tempString.substring(tempPos, temp+3));
        products.add(Product(id!, category, name, price, stock)); // внесение значений временных переменных в список товаров
      }
    }
  }
}

// реализация интерфейса для филтрации по категориям (равно фильтрующему значению)
class CategoryFilter implements Filter {
  final String category;

  CategoryFilter(this.category);

  // проверка соответствия условию
  bool apply(Product product) {
    return product.category == category;
  }
}

// реализация интерфейса для филтрации по цене (меньше или равно фильтрующему значению)
class PriceFilter implements Filter {
  final int price;

  PriceFilter(this.price);

  bool apply(Product product) {
    return product.price <= price;
  }
}

// реализация интерфейса для филтрации по остаткам на складе (меньше фильтрующего значения)
class StockFilter implements Filter {
  final int stock;

  StockFilter(this.stock);

  bool apply(Product product) {
    return product.stock < stock;
  }
}

void main() {
  List<Product> products = [];
  articlesToProducts(articles, products);

  print('Фильтрация по типу (вода):');
  applyFilter(products, CategoryFilter('вода'));

  print('\nФильтрация по цене (не более 200 рублей):');
  applyFilter(products, PriceFilter(200));

  print('\nФильтрация по остаткам на складе (меньше 6 шт):');
  applyFilter(products, StockFilter(6));
}
