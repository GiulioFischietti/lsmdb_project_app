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
import 'package:project_app/View/BottomTab/Home.dart';
import 'package:project_app/services/UserServices.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  UserModel user;
  bool usernameTaken = false;
  bool loading = false;

  getUserData(context) async {
    user = await getPersonalProfile();
    notifyListeners();
  }

  uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String accessToken = prefs.getString('access_token');
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    Response<Map> response = await Dio().post(
      "https://refactoring.needfy.it/api/modifyimageprofile",
      data: formData,
      options: Options(
        headers: {'Authorization': "Bearer " + accessToken},
      ),
    );
    print(response);

    user.image = response.data['image'];
    notifyListeners();
  }

  editProfile() async {
    String response = await Request.post('modifyinfoprofile', {
      "username": user.username,
      "birthday": DateFormat('yyyy-MM-dd').format(user.birthday),
      "name": user.name ?? "",
      "surname": user.surname ?? "",
      "biography": user.motto ?? "",
      "phone": user.phone ?? "",
    });
  }

  updateProfile(DateTime birthday, String name, String surname, String bio,
      String username, String phone, String gender) {
    if (birthday != null) user.birthday = birthday;
    if (name != "") user.name = name;
    if (surname != "") user.surname = surname;
    if (username != "") user.username = username;
    if (bio != "") user.motto = bio;
    if (phone != "") user.phone = phone;
    if (gender != "") user.gender = gender;
    notifyListeners();
    editProfile();
  }

  checkUsername(String username) async {
    String response = await Request.get("checkusername/" + username);
    var responseJson = json.decode(response);
    usernameTaken = responseJson['is_exist'];
    notifyListeners();
  }
}
