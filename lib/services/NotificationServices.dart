// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseNotificationsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ShowcaseNotificationsModel> getNotifications() async {
  ShowcaseNotificationsModel notifications;

  var jsonNotifications;
  String response = await Request.get('notifications');
  print(response);
  jsonNotifications = json.decode(response);
  notifications = ShowcaseNotificationsModel.fromJson(jsonNotifications);

  return notifications;
}
