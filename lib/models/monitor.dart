import 'dart:convert';

import 'package:eventi_in_zona/models/product.dart';

class Monitor extends Product {
  late int id;
  late int productId;
  late int refreshRate;
  late String specialFeatures;
  late double screenSize;
  late String resolution;

  Monitor(data) : super(data) {
    id = data['id'] ?? 0;
    productId = data['product_id'] ?? 0;
    refreshRate = data['refresh_rate'] ?? 0;
    specialFeatures = data['special_features'] ?? "";
    screenSize = double.parse((data['screen_size'] ?? "0").toString());
    resolution = data['resolution'] ?? "";
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
    result.addAll({'refresh_rate': refreshRate});
    result.addAll({'special_features': specialFeatures});
    result.addAll({'screen_size': screenSize});
    result.addAll({'resolution': resolution});

    return result;
  }

  factory Monitor.fromJson(String source) =>
      Monitor.fromJson(json.decode(source));
}
