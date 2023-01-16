import 'dart:convert';

import 'package:eventi_in_zona/models/product.dart';

class Book extends Product {
  late int id;
  late int productId;
  late int nPages;
  late String summary;
  late String language;

  Book(data) : super(data) {
    id = data['id'] ?? 0;
    productId = data['product_id'] ?? 0;
    summary = data['summary'] ?? "";
    nPages = data['n_pages'] ?? 0;
    language = data['language'] ?? "";
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
    result.addAll({'n_pages': nPages});
    result.addAll({'summary': summary});
    result.addAll({'language': language});

    return result;
  }
}
