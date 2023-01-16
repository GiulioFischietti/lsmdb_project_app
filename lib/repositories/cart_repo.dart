import 'dart:convert';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:eventi_in_zona/screens/user/BottomTabContainer.dart';
import 'package:eventi_in_zona/screens/user/Home.dart';
import 'package:http/http.dart' as http;
import 'package:eventi_in_zona/widgets/user/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getUserCartData(int customer_id) async {
  return await Repo().getData("cart/getcart?id=$customer_id");
}

Future<dynamic> removeOneFromCart(int cart_item_id, int user_id) async {
  return await Repo().postData(
      "cart/removefromcart", {"id": cart_item_id, "user_id": user_id});
}

Future<dynamic> removeAllFromCart(int cart_item_id, int user_id) async {
  return await Repo().postData(
      "cart/removeallitemfromcart", {"id": cart_item_id, "user_id": user_id});
}

Future<dynamic> addToCart(
    {int? product_id,
    String? name,
    String? category,
    double? price,
    int? user_id,
    String? image_url}) async {
  return await Repo().postData("cart/addtocart", {
    "product_id": product_id,
    "name": name,
    "category": category,
    "price": price,
    "user_id": user_id,
    "image_url": image_url
  });
}
