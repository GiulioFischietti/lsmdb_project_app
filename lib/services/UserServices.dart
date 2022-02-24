// ignore_for_file: file_names

import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<UserModel> getPersonalProfile(String id) async {
  UserModel user;

  String response = await Request.get('userbyid', params: {"_id": id});
  if (response != "error") {
    user = UserModel.fromJson(json.decode(response)['data']);
  }

  return user;
}
