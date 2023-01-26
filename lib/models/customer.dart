import 'dart:convert';

import 'package:objectid/objectid.dart';

import 'package:eventi_in_zona/models/user.dart';

class Customer extends User {
  late String phone;

  Customer(data) : super(data) {
    phone = data['phone'] ?? "";
  }

  @override
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll(super.toJson());
    result.addAll({'phone': phone});

    return result;
  }
}
