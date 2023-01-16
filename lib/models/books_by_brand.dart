import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/product.dart';

class BooksByBrand {
  late List<Book> books = [];
  late String brand;

  BooksByBrand(data) {
    brand = data['brand'];

    for (var item in data['books']) {
      // print(item);
      books.add(Book(item));
    }
  }
}
