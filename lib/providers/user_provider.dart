import 'dart:convert';

import 'package:eventi_in_zona/models/app_user.dart';
import 'package:eventi_in_zona/models/club.dart';
import 'package:eventi_in_zona/models/customer.dart';
import 'package:eventi_in_zona/models/entity.dart';
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
import 'package:eventi_in_zona/repositories/entity_repo.dart' as entityRepo;

import 'package:flutter/material.dart';
import 'package:objectid/objectid.dart';

class UserProvider extends ChangeNotifier {
  bool loading = false;
  bool loadingMoreFollowers = false;

  AppUser user = AppUser({});
  AppUser otherUser = AppUser({});
  bool usernameTaken = false;
  late EntityManager manager;
  late Club entityOfManager;
  List<Order> orders = [];

  List<UserMinimal> suggestedFriends = [];
  List<UserMinimal> suggestedFriendsOfUser = [];

  List<UserMinimal> entityFollowers = [];
  List<UserMinimal> followers = [];
  List<EntityMinimal> followings = [];
  List<EventMinimal> likedEvents = [];

  List<EntityMinimal> suggestedArtists = [];

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

  void getSuggestedArtists() async {
    var data = await entityRepo.getSuggestedArtists(manager.managedEntity, 0);
    suggestedArtists =
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();
    notifyListeners();
  }

  void getMoreSuggestedArtists() async {
    var data = await entityRepo.getSuggestedArtists(
        manager.managedEntity, suggestedArtists.length);
    suggestedArtists = suggestedArtists +
        (data['data'] as List).map((item) => EntityMinimal(item)).toList();
    notifyListeners();
  }

  void getUserById(ObjectId userId) async {
    var data = await userRepo.getUser(userId);
    otherUser = AppUser(data['data']);
    notifyListeners();
  }

  void getManagedEntity() async {
    loading = true;
    notifyListeners();
    var data = await entityRepo.getEntityByIdJson(
        manager.managedEntity.hexString, manager.id.hexString);
    entityOfManager = Club(data['data']);

    loading = false;
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
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMoreFollowers(ObjectId userId) async {
    loadingMoreFollowers = true;
    notifyListeners();

    var data = await userRepo.followersOfUser(userId, followers.length);
    followers = followers +
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

    loadingMoreFollowers = false;
    notifyListeners();
  }

  void getEntityFollowers(ObjectId userId) async {
    loading = true;
    notifyListeners();

    var data = await entityRepo.getFollowers(userId, 0);
    entityFollowers =
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void getMoreEntityFollowers(ObjectId userId) async {
    loadingMoreFollowers = true;
    notifyListeners();

    var data = await entityRepo.getFollowers(userId, entityFollowers.length);
    entityFollowers = entityFollowers +
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

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

  void getSuggestedFriendsOfUser() async {
    loading = true;
    notifyListeners();
    var data =
        await userRepo.getSuggestedFriendsOfUser(otherUser.id, user.id, 0);
    suggestedFriendsOfUser =
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

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
        (data['data'] as List).map((item) => UserMinimal(item)).toList();

    loading = false;
    notifyListeners();
  }

  void updateMyEntity() async {
    notifyListeners();
    updateEntity(manager.id, entityOfManager);
    notifyListeners();
  }

  Future updateUser() async {
    loading = true;
    notifyListeners();
    await userRepo.editUser(user);
    loading = false;
    notifyListeners();
  }
}
