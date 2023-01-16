import 'dart:convert';

import 'package:eventi_in_zona/models/entity.dart';

class Artist extends Entity {
  Artist(data) : super(data) {}

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    super.toJson();

    return result;
  }
}
