// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';
import 'dart:io';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseArtistsModel.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseOrganizersModel.dart';
import 'package:project_app/Model/ShowcaseReviewsModel.dart';
import 'package:project_app/Model/UploadImageResponse.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/BottomTab/BottomTabContainer.dart';
import 'package:project_app/View/BottomTab/Home.dart';
import 'package:project_app/View/Other/ResponseData.dart';
import 'package:project_app/services/UserServices.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel user;
  bool usernameTaken = false;
  bool loading = false;
  bool passwordsNotEqual = false;
  Future<void> login(String email, String psw, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    loading = true;

    String response =
        await Request.post('login', {"email": email, "password": psw});

    dynamic loginResponse = jsonDecode(response);

    loading = false;
    user = UserModel.fromJson(loginResponse['data']);
    await prefs.setString("user_id", loginResponse['data']['_id']);
    notifyListeners();
    if (loginResponse['success']) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => BottomTabContainer()));
    }
  }

  Future<dynamic> signup(dynamic body) async {
    passwordsNotEqual = (body['password'] != body['repeat_password']);
    notifyListeners();
    if (!passwordsNotEqual) {
      final response = await Request.post('signup', body);
      dynamic responseData = jsonDecode(response);
      return responseData;
    } else {
      return null;
    }
  }

  getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    user = await getPersonalProfile(prefs.getString("user_id"));
    notifyListeners();
  }
}
