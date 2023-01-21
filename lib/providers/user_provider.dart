import 'dart:convert';

import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/order_repo.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/repositories/user_repo.dart' as userRepo;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:objectid/objectid.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  late Customer user;
  late Manager manager;
  List<Order> orders = [];
  List<ProductOrder> productOrders = [];
  List<ProductOrder> cartProducts = [];

  void addReviewedEntity(ObjectId entityId) {
//  user.reviewedEntities.add(entityId);
  }

  Future<bool> logIn(String username, String password) async {
    var data = await logInData(username, password);
    user = Customer(data['data']);
    notifyListeners();
    return data['success'];
  }
}
