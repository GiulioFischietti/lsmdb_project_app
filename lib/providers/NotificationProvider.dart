// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseNotificationsModel.dart';
import 'package:project_app/services/NotificationServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationProvider extends ChangeNotifier {
  ShowcaseNotificationsModel notifications =
      new ShowcaseNotificationsModel(null);

  loadNotificationsFromStorage() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('notifications') != null) {
      String localNotifications = prefs.getString('notifications');
      var jsonNotifications = json.decode(localNotifications);
      notifications = ShowcaseNotificationsModel.fromJson(jsonNotifications);
    }
    notifyListeners();
  }

  loadNotifications() async {
    var prefs = await SharedPreferences.getInstance();
    var jsonNotifications;

    String response = await Request.get('notifications');
    prefs.setString('notifications', response);
    jsonNotifications = json.decode(response);
    notifications = ShowcaseNotificationsModel.fromJson(jsonNotifications);
    notifyListeners();
  }

  deleteNotification(int id) async {
    String response =
        await Request.delete('removenotification/' + id.toString());
  }
}
