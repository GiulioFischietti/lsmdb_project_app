import 'dart:convert';

import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/order_repo.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  bool loading = false;
  late Customer user;
  late Manager manager;
  List<Order> orders = [];
  List<ProductOrder> productOrders = [];
  List<ProductOrder> cartProducts = [];

  Future<dynamic> recoverPassword(String username) async {
    var data = await http.post(Uri.parse(host + '/recoverypassword'),
        body: {"username": username});
    return data;
  }

  Future<bool> logIn(String username, String password) async {
    var data = await logInData(username, password);
    user = Customer(data['data']);
    notifyListeners();
    return data['success'];
  }

  Future<void> updateUser(
      String name, String username, String phone, String address) async {
    try {
      loading = true;
      notifyListeners();
      var data =
          await updateUserData(user.userId, name, username, phone, address);
      user = Customer(data['data']);
      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> createOrder(
      {String? shipping_address,
      String? shipping_country,
      String? payment_type}) async {
    try {
      loading = true;
      notifyListeners();
      var data = await createOrderData(
          customer_id: user.id,
          payment_type: payment_type,
          shipping_address: shipping_address,
          shipping_country: shipping_country,
          total: cartProducts
              .map((e) => e.price * e.quantity)
              .reduce((a, b) => a + b),
          product_orders: cartProducts);
      // user = Customer(data['data']);
      loading = false;
      // notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> getUserOrders() async {
    loading = true;
    notifyListeners();
    var json = await getUserOrdersData(user.id);
    orders = (json['data'] as List).map((e) => Order(e)).toList();
    loading = false;
    notifyListeners();
  }

  Future<void> getUserCart() async {
    loading = true;
    notifyListeners();
    var json = await getUserCartData(user.id);
    cartProducts = (json['data'] as List).map((e) => ProductOrder(e)).toList();
    loading = false;
    notifyListeners();
  }

  Future<void> getUserOrderDetails(int order_id) async {
    var json = await getUserOrderDetailsData(order_id, user.id);
    productOrders = (json['data'] as List).map((e) => ProductOrder(e)).toList();
    notifyListeners();
  }

  Future<void> addOneToCart(int id) async {
    cartProducts.where((element) => element.productId == id).first.quantity++;
    notifyListeners();
  }

  Future<void> removeOneFromCart(int id) async {
    cartProducts.where((element) => element.productId == id).first.quantity--;
    if (cartProducts
            .where((element) => element.productId == id)
            .first
            .quantity ==
        0) {
      cartProducts.removeWhere((element) => element.productId == id);
    }
    notifyListeners();
  }

  Future<void> removeAllFromCart(int id) async {
    cartProducts.where((element) => element.productId == id).first.quantity = 0;
    notifyListeners();
  }
}
