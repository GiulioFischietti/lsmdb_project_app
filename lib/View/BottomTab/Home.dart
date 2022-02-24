import 'dart:convert';

import 'package:project_app/Engine/Communication/request.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseLiveModel.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/BottomTab/Search.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/View/Items/ShowcaseClubs.dart';
import 'package:project_app/View/Items/ShowcaseEvents.dart';
import 'package:project_app/providers/HomeProvider.dart';
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

ShowcaseEventsModel showcase;
ShowcaseLiveModel showcase_live;
UserModel user;
var flutterLocalNotificationsPlugin;

class _HomeState extends State<Home> {
  bool locationDisabled = false;

  @override
  void initState() {
    // final userMdl = Provider.of<UserProvider>(context, listen: false);
    loadHome();
    // userMdl.getUserData(context);
  }

  void loadHome() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final userMdl = Provider.of<UserProvider>(context, listen: false);
    await userMdl.getUserData();
    await homeProvider.nearYou();
    await homeProvider.nearClubs();
    await homeProvider.electronicEvents();
    await homeProvider.popRockEvents();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Consumer2<UserProvider, HomeProvider>(
            builder: (context, userProvider, homeProvider, child) {
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
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) => User(
                                      //             user: userProvider.user,
                                      //             slug: userProvider
                                      //                 .user.username,
                                      //             image: userProvider
                                      //                 .user.image)));

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Search()));
                                    },
                                    child: Hero(
                                        tag: 'propic',
                                        child: Container(
                                          child: Icon(Icons.search,
                                              color: Colors.white),
                                          height: 40,
                                          width: 40,
                                        ))))
                            : InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Container(
                                    margin: EdgeInsets.all(20),
                                    child: Text("Accedi",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20))))
                      ],
                    )),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Eventi vicino a te",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ))),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_forward, color: Colors.white))
                ]),
                Container(height: 10),
                homeProvider.nearyouevents != null
                    ? ShowcaseEvents(data: homeProvider.nearyouevents)
                    : Center(child: CircularProgressIndicator()),
                Container(height: 30),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Club vicino a te",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ))),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_forward, color: Colors.white))
                ]),
                homeProvider.nearyouclubs != null
                    ? ShowcaseClubs(data: homeProvider.nearyouclubs)
                    : Center(child: CircularProgressIndicator()),
                Container(height: 30),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Il meglio dell'Elettronica",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ))),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_forward, color: Colors.white))
                ]),
                Container(height: 10),
                homeProvider.electronicevents != null
                    ? ShowcaseEvents(data: homeProvider.electronicevents)
                    : Center(child: CircularProgressIndicator()),
                Container(height: 30),
                Row(children: [
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Il meglio del Rock",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ))),
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.arrow_forward, color: Colors.white))
                ]),
                Container(height: 10),
                homeProvider.poprockevents != null
                    ? ShowcaseEvents(data: homeProvider.poprockevents)
                    : Center(child: CircularProgressIndicator()),
                Container(height: 30),
              ],
            ),
          );
        }));
  }
}
