import 'package:eventi_in_zona/models/product.dart';

class ProductOrder extends Product {
  int id = 0;
  late double total = 0;
  late double quantity = 0;
  late int orderId = 0;
  late int productId = 0;

  ProductOrder(jsonMap) : super(jsonMap) {
    id = jsonMap['id'] ?? 0;
    productId = jsonMap['product_id'];
    total = jsonMap['total'] != null ? jsonMap['total'].toDouble() : 0.0;
    quantity =
        jsonMap['quantity'] != null ? jsonMap['quantity'].toDouble() : 0.0;
  }

  @override
  Map<String, dynamic> toJson() => {
        'price': price,
        'quantity': quantity,
        'product_id': productId,
      };
}
