import 'dart:convert';
import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/models/book.dart';
import 'package:eventi_in_zona/models/monitor.dart';
import 'package:eventi_in_zona/providers/constants.dart';
import 'package:eventi_in_zona/repositories/repo.dart';
import 'package:eventi_in_zona/screens/user/BottomTabContainer.dart';
import 'package:eventi_in_zona/screens/user/Home.dart';
import 'package:http/http.dart' as http;
import 'package:eventi_in_zona/widgets/user/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> getNearClubsJson(body) async {
  return await Repo().postData("entity/search", body);
}

Future<dynamic> getEntityByIdJson(String id) async {
  return await Repo().getData("entity/entitybyid?_id=$id");
}
