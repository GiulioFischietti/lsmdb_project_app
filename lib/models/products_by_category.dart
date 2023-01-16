import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/product.dart';

class ProductsByCategory {
  late List<Product> products = [];
  late String category;

  ProductsByCategory(data) {
    category = data['category'];

    for (var item in data['products']) {
      // print(item);
      products.add(Product(item));
    }
  }
}
