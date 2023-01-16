import 'dart:convert';

import 'package:eventi_in_zona/models/product.dart';

class Beer extends Product {
  late int id = 0;
  late int productId = 0;
  late double alcoholPercentage = 0.0;
  late int volumeMl = 0;

  Beer(data) : super(data) {
    id = data['id'] ?? 0;
    productId = data['product_id'] ?? 0;
    alcoholPercentage = data['alcohol_percentage'] != null
        ? double.parse(data['alcohol_percentage'].toString())
        : 0.0;
    volumeMl = data['volume_ml'] ?? 0;
  }

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'short_description': shortDescription});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'brand': brand});
    result.addAll({'stock': stock});

    result.addAll({'product_id': productId});
    result.addAll({'alcohol_percentage': alcoholPercentage});
    result.addAll({'volume_ml': volumeMl});

    return result;
  }
}
