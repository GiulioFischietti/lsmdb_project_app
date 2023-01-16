import 'dart:convert';

import 'package:eventi_in_zona/models/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart' as geocoding;

class LocationProvider extends ChangeNotifier {
  MyLocation? myLocation;

  Future getCityFromLat(dynamic position) async {
    String? lat = position['lat'];
    String? lon = position['lon'];
    String? address = position['address'];

    if (address == null) {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(double.parse(lat!), double.parse(lon!));

      myLocation = new MyLocation(
          city: placemarks[0].locality,
          latitude: double.parse(lat),
          longitude: double.parse(lon));
    } else {
      myLocation = new MyLocation(
          city: address,
          latitude: double.parse(lat!),
          longitude: double.parse(lon!));
    }
    notifyListeners();
  }

  Future<void> changeCurrentLocation(dynamic _address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('delivery_address', json.encode(_address));
    myLocation!.latitude = double.parse(_address['lat']);
    myLocation!.longitude = double.parse(_address['lon']);
    myLocation!.city = _address['address'];
    notifyListeners();
    return _address;
  }
}
