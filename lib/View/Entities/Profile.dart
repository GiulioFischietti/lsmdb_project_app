import 'package:project_app/Engine/Communication/request.dart';
// ignore_for_file: file_names

import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/ShowcaseArtistsModel.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseOrganizersModel.dart';
import 'package:project_app/Model/ShowcaseReviewsModel.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/Items/ShowcaseArtists.dart';
import 'package:project_app/View/Items/ShowcaseClubs.dart';
import 'package:project_app/View/Items/ShowcaseEvents.dart';
import 'package:project_app/View/Items/ShowcaseOrganizers.dart';
import 'package:project_app/View/Items/showcase_reviews.dart';
import 'package:project_app/View/Other/EditProfile.dart';
import 'package:project_app/View/Other/Settings.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_app/services/ProfileServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();

  Profile();
}

class _ProfileState extends State<Profile> {
  int _index = 0;
  void _selectIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorDark,
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          return ListView(shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                    margin: EdgeInsets.only(
                        left: 30, top: 40, right: 30, bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            height: size.width / 4,
                            width: size.width / 4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      userProvider.user.image ?? ""),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  BorderRadius.circular(size.width / 4),
                            )),
                        Flexible(
                          child: Container(
                              margin: EdgeInsets.only(left: 15, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      child: Text(userProvider.user.name,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      child: Text(
                                    userProvider.user.email,
                                    style: TextStyle(
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              )),
                        )
                      ],
                    )),
                listTile(
                    Icon(Icons.edit, color: Colors.white), "Modifica Profilo",
                    () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EditProfile()));
                }),
                listTile(Icon(Icons.exit_to_app, color: Colors.white), "Esci",
                    () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pop();
                }),
              ]);
        }));
  }
}

Widget listTile(Icon image, String title, Function action) {
  return InkWell(
      onTap: () {
        action();
      },
      child: Container(
          margin: EdgeInsets.only(left: 30, top: 15, right: 30, bottom: 15),
          child: Row(
            children: [
              image != null ? Container(child: image) : Container(),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))),
              Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
            ],
          )));
}
