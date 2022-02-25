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

class HomeProvider extends ChangeNotifier {
  bool loading = false;
  bool locationDisabled = false;
  Position currentPosition;

  ShowcaseEventsModel poprockevents;
  ShowcaseEventsModel nearyouevents;
  ShowcaseClubModel nearyouclubs;
  ShowcaseEventsModel electronicevents;

  Future<void> nearYou() async {
    await determinePosition();

    String response = await Request.post('nearevents', {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "max_distance": 100000
    });

    nearyouevents = ShowcaseEventsModel.fromJson(jsonDecode(response));
    notifyListeners();
  }

  Future<void> popRockEvents() async {
    await determinePosition();

    String response = await Request.post('searchevents', {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "max_distance": 100000,
      "genres": ['Pop', "Rock", "Metal", "Blues"]
    });

    poprockevents = ShowcaseEventsModel.fromJson(jsonDecode(response));
    notifyListeners();
  }

  Future<void> nearClubs() async {
    await determinePosition();

    String response = await Request.post('nearclubs', {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "max_distance": 100000
    });

    nearyouclubs = ShowcaseClubModel.fromJson(jsonDecode(response));
    notifyListeners();
  }

  Future<void> electronicEvents() async {
    await determinePosition();

    String response = await Request.post('searchevents', {
      "lat": currentPosition.latitude,
      "lon": currentPosition.longitude,
      "max_distance": 100000,
      "genres": ["House"]
    });

    electronicevents = ShowcaseEventsModel.fromJson(jsonDecode(response));
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
      print(currentPosition.latitude);
    } else {
      var pos = jsonDecode(prefs.getString('current_position'));
      currentPosition =
          Position(latitude: pos['latitude'], longitude: pos['longitude']);
    }
  }
}
