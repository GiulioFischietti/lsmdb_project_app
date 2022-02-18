// ignore_for_file: file_names

import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> getPersonalProfile() async {
  UserModel user;
  var prefs = await SharedPreferences.getInstance();

  var jsonUser;
  // if (prefs.getString('user') != null) {
  //   String userLocal = prefs.getString("user");
  //   jsonUser = json.decode(userLocal);
  //   user = UserModel.fromJson(jsonUser);
  // }
  // else {
  String response = await Request.get('user');
  if (response != "error") {
    jsonUser = json.decode(response);
    user = UserModel.fromJson(jsonUser);
  }
  // }
  return user;
}
