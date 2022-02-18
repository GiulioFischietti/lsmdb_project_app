import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseLiveModel.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/View/Items/ShowcaseEvents.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/NotificationProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: file_names

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

SharedPreferences prefs;
Position currentPosition;
ShowcaseEventsModel showcase;
ShowcaseLiveModel showcase_live;
UserModel user;
var flutterLocalNotificationsPlugin;

class _HomeState extends State<Home> {
  bool locationDisabled = false;

  Future<void> _getHome() async {
    prefs = await SharedPreferences.getInstance();

    _nearYou();
  }

  Future<void> _nearYou() async {
    await _determinePosition();

    String response = await Request.get('nearyou/' +
        currentPosition.latitude.toString() +
        '/' +
        currentPosition.longitude.toString());

    setState(() {
      showcase = ShowcaseEventsModel.fromJson(jsonDecode(response));
    });
  }

  Future<void> _live() async {
    String response = await Request.get('live');

    setState(() {
      showcase_live = ShowcaseLiveModel.fromJson(jsonDecode(response));
    });
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        locationDisabled = true;
      });
      return Future.error('Location services are disabled.');
    } else {
      setState(() {
        locationDisabled = false;
      });
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
          desiredAccuracy: LocationAccuracy.high);
      print(currentPosition.latitude);
    }
  }

  @override
  void initState() {
    _live();
    _getHome();
    final userMdl = Provider.of<UserProvider>(context, listen: false);
    userMdl.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Consumer2<UserProvider, LanguageProvider>(
            builder: (context, userProvider, languageProvider, child) {
          return Container(
            height: size.height,
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                    left: 20, top: 0, bottom: 20),
                                child: Text('Needfy',
                                    style: TextStyle(
                                        color: Color(0xFFf9b701),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 34)))),
                        (userProvider.user != null)
                            ? Container(
                                alignment: Alignment.centerRight,
                                margin: EdgeInsets.only(
                                    right: 10, top: 10, bottom: 20),
                                child: TextButton(
                                    style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50))),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => User(
                                                  user: userProvider.user,
                                                  slug: userProvider
                                                      .user.username,
                                                  image: userProvider
                                                      .user.image)));
                                    },
                                    child: Hero(
                                        tag: 'propic',
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      userProvider.user.image)),
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          height: 40,
                                          width: 40,
                                        ))))
                            : InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    child: Text(
                                        languageProvider.text.login.login,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20))))
                      ],
                    )),
                showcase != null
                    ? locationDisabled
                        ? Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              "Servizi di geolocalizzazione disattivati. Attivali per vedere gli eventi vicini a te",
                              style: Theme.of(context).textTheme.bodyText1,
                            ))
                        : ShowcaseEvents(data: showcase)
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }));
  }
}
