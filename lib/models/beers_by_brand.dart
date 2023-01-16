import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/product.dart';

class BeersByBrand {
  late List<Beer> beer = [];
  late String brand;

  BeersByBrand(data) {
    brand = data['brand'];

    for (var item in data['beer']) {
      // print(item);
      beer.add(Beer(item));
    }
  }
}
