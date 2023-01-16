import 'dart:convert';

import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/product.dart';

class Organizer extends Entity {
  Organizer(data) : super(data) {}

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(super.toJson());
    return result;
  }
}
