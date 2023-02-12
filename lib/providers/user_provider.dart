import 'dart:convert';

import 'package:eventi_in_zona/models/app_user.dart';
import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/entity_manager.dart';
import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/models/manager.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/models/user_minimal.dart';
import 'package:eventi_in_zona/repositories/auth_repo.dart';
import 'package:eventi_in_zona/repositories/entity_repo.dart';
import 'package:eventi_in_zona/repositories/user_repo.dart' as userRepo;
import 'package:eventi_in_zona/repositories/auth_repo.dart' as authRepo;
import 'package:eventi_in_zona/repositories/event_repo.dart' as eventRepo;

import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  bool loadingMoreFollowers = false;

  AppUser user = AppUser({});
  bool usernameTaken = false;
  late EntityManager manager;
  List<Order> orders = [];

  List<EntityMinimal> suggestedFriends = [];

  List<EntityMinimal> followers = [];
  List<EntityMinimal> followings = [];
  List<EventMinimal> likedEvents = [];

  List<ProductOrder> productOrders = [];
  List<ProductOrder> cartProducts = [];

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

  void getAppUser() async {
    var data = await userRepo.getUser(user.id);
    if (data['data']['role'] == "user") {
      user = AppUser(data['data']);
    } else {
      manager = EntityManager(data['data']);
    }
    notifyListeners();
  }

  void getManager() async {
    var data = await userRepo.getUser(manager.id);
    if (data['data']['role'] == "user") {
      user = AppUser(data['data']);
    } else {
      manager = EntityManager(data['data']);
    }
    notifyListeners();
  }

  void getFollowers(ObjectId userId) async {
    loading = true;
    notifyListeners();

    var data = await userRepo.followersOfUser(userId, 0);
    followers =
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMoreFollowers(ObjectId userId) async {
    loadingMoreFollowers = true;
    notifyListeners();

    var data = await userRepo.followersOfUser(userId, followers.length);
    followers = followers +
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();

    loadingMoreFollowers = false;
    notifyListeners();
  }

  void getLikedEvents(ObjectId userId) async {
    loading = true;
    notifyListeners();

    var data = await userRepo.likedEvents(0, userId);
    likedEvents =
        (data['data'] as List).map((item) => EventMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMoreLikedEvents(ObjectId userId) async {
    loadingMoreFollowers = true;
    notifyListeners();

    var data = await userRepo.likedEvents(likedEvents.length, userId);
    likedEvents = likedEvents +
        (data['data'] as List).map((item) => EventMinimal(item)).toList();

    loadingMoreFollowers = false;
    notifyListeners();
  }

  void getFollowings(ObjectId userId) async {
    loading = true;
    notifyListeners();

    var data = await userRepo.followingsOfUser(userId, 0);
    followings =
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMoreFollowings(ObjectId userId) async {
    loadingMoreFollowers = true;
    notifyListeners();

    var data = await userRepo.followingsOfUser(userId, followings.length);
    followings = followings +
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();

    loadingMoreFollowers = false;
    notifyListeners();
  }

  void getSuggestedFriendsBasedOnLikes() async {
    loading = true;
    notifyListeners();

    var data = await userRepo.getSuggestedFriendsBasedOnLikes(user.id, 0);
    suggestedFriends =
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void updateMyEntity() async {
    notifyListeners();
    updateEntity(manager.id, manager.managedEntity);
    notifyListeners();
  }

  void updateUser() {}
}
