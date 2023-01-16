import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:eventi_in_zona/models/location.dart';
import 'package:eventi_in_zona/widgets/user/custom_dialog.dart';

Future<dynamic> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permantly denied, we cannot request permissions.');
  }

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  var pos;
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
        forceAndroidLocationManager: true,
        timeLimit: Duration(seconds: 10));
    pos = {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString()
    };
  } catch (exception) {}

  return pos;
}

Future<dynamic> getStoredLocation(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.containsKey('delivery_address')) {
    var storedLocation = json.decode(prefs.getString('delivery_address')!);

    // address['address'] = storedLocation.city;
    // address['lat'] = storedLocation.latitude.toString();
    // address['lon'] = storedLocation.longitude.toString();

    return storedLocation;
  } else {
    return await getNewCurrentLocation(context);
  }
}

Future<dynamic> getNewCurrentLocation(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // var location = loc.Location();
  // bool enabled = await location.serviceEnabled();

  // if (!enabled) {
  //   print("gps not enabled");
  //   enabled = await location.requestService();
  // }
  dynamic address = await determinePosition();
  if (address != null) {
    List<geocoding.Placemark> placemarks =
        await geocoding.placemarkFromCoordinates(
            double.parse(address['lat']), double.parse(address['lon']));

    MyLocation myLocation = MyLocation(
        city: placemarks[0].locality,
        latitude: double.parse(address['lat']),
        longitude: double.parse(address['lon']));

    address['address'] = myLocation.city;
    address['lat'] = myLocation.latitude.toString();
    address['lon'] = myLocation.longitude.toString();

    changeCurrentLocation(address);
    return address;
  }
  // else {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return CustomDialog(
  //             cancelable: false,
  //             onExitButtonPress: () {
  //               Navigator.of(context).pop();
  //             },
  //             exitMessage: "Chiudi",
  //             message:
  //                 "Per usufruire dei servizi di localizzazione devi attivare il GPS dalle impostazioni.",
  //             icon: Icon(Icons.error, size: 80, color: Colors.red));
  //       });
  // }
}

Future<void> changeCurrentLocation(dynamic _address) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('delivery_address', json.encode(_address));

  return _address;
}
