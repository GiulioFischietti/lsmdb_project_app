// ignore: file_names
// ignore: file_names
// ignore_for_file: unnecessary_this, file_names
//
import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Engine/Utility.dart/DefaultLanguage.dart';
import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseNotificationsModel.dart';
import 'package:project_app/services/NotificationServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider extends ChangeNotifier {
  bool loading = false;
  bool locationDisabled = false;
  Position currentPosition;

  ShowcaseEventsModel searchedevents;
  ShowcaseClubModel searchedclubs;

  Future<void> searchEvents(List<String> genres, double distance,
      dynamic position, DateTime start) async {
    if (position['lat'] == null) await determinePosition();

    var params = {
      "lat": position['lat'] ?? currentPosition.latitude,
      "lon": position['lon'] ?? currentPosition.longitude,
      "max_distance": distance * 1000,
      "start": start.toIso8601String()
    };

    if (genres[0] != "Tutti gli eventi") {
      params['genres'] = genres;
    }
    String response = await Request.post('searchevents', params);

    searchedevents = ShowcaseEventsModel.fromJson(jsonDecode(response));
    notifyListeners();
  }

  determinePosition() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('current_position')) {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationDisabled = true;

        return Future.error('Location services are disabled.');
      } else {
        locationDisabled = false;

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.deniedForever) {
            return Future.error(
                'Location permissions are permanently denied, we cannot request permissions.');
          }

          if (permission == LocationPermission.denied) {
            return Future.error('Location permissions are denied');
          }
        }

        currentPosition = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.medium);
        notifyListeners();
        prefs.setString("current_poisition", jsonEncode(currentPosition));
      }
    } else {
      var pos = jsonDecode(prefs.getString('current_position'));
      currentPosition =
          Position(latitude: pos['latitude'], longitude: pos['longitude']);
    }
  }
}
