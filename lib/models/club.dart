import 'dart:convert';

import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/lat_lon_location.dart';
import 'package:eventi_in_zona/models/product.dart';

class Club extends Entity {
  String address = "";
  late LatLonLocation location;
  Club(data) : super(data) {
    address = data['address'] ?? "";
    location = LatLonLocation(data['location'] ?? {});
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> result = <String, dynamic>{};
    result.addAll(super.toJson());
    result.addAll({'address': address});
    // result.addAll({'location': location});
    return result;
  }

  factory Club.fromJson(String source) => Club.fromJson(json.decode(source));
}
