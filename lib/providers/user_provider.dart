import 'dart:convert';

import 'package:eventi_in_zona/models/app_user.dart';
import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/entity_manager.dart';
import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/entity_repo.dart';
import 'package:eventi_in_zona/repositories/user_repo.dart' as userRepo;
import 'package:eventi_in_zona/repositories/auth_repo.dart' as authRepo;
import 'package:eventi_in_zona/repositories/event_repo.dart' as eventRepo;

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  AppUser user = AppUser({});
  bool usernameTaken = false;
  late EntityManager manager;
  List<Order> orders = [];
  List<ProductOrder> productOrders = [];
  List<ProductOrder> cartProducts = [];

  void createEvent(Event event) async {
    loading = true;
    notifyListeners();
    await eventRepo.createEvent(event);
    // getEventsByEntity(entityId, skip)

    loading = false;
    notifyListeners();
  }

  Future<bool> logIn(String username, String password) async {
    var data = await logInData(username, password);
    if (data['data']['role'] == "user") {
      user = AppUser(data['data']);
    } else {
      manager = EntityManager(data['data']);
    }

    notifyListeners();
    return data['success'];
  }

  Future<bool> signUpAsAManager(
      EntityManager entityManager, String facebookLink) async {
    var json = await authRepo.signUpAsManager(entityManager.username,
        entityManager.password, entityManager.name, facebookLink);

    manager = EntityManager(json['data']);
    notifyListeners();
    return json['success'];
  }

  void usernameExists(String username) async {
    var data = await authRepo.usernameExists(username);
    usernameTaken = data['data'];
    notifyListeners();
  }

  void getUser() async {
    var data = await userRepo.getUser(manager.id);
    if (data['data']['role'] == "user") {
      user = AppUser(data['data']);
    } else {
      manager = EntityManager(data['data']);
    }
    notifyListeners();
  }

  void updateMyEntity() async {
    notifyListeners();
    updateEntity(manager.id, manager.managedEntity);
    notifyListeners();
  }

  void updateUser() {}
}
