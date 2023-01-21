import 'dart:convert';

import 'package:objectid/objectid.dart';

import 'package:eventi_in_zona/models/user.dart';

class Customer extends User {
  late String country;
  late String address;
  late String phone;

  Customer(data) : super(data) {
    country = data['country'] ?? "";
    address = data['address'] ?? "";
    phone = data['phone'] ?? "";
  }

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(super.toJson());
    result.addAll({'country': country});
    result.addAll({'address': address});
    result.addAll({'phone': phone});

    return result;
  }
}
