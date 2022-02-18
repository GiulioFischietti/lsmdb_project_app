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
import 'package:project_app/View/Other/Settings.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_app/services/ProfileServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  String image;

  String slug;
  @override
  _ProfileState createState() => _ProfileState();

  Profile({this.slug, this.image});
}

class _ProfileState extends State<Profile> {
  UserModel user;
  ShowcaseClubModel showcaseclubsfollowed;
  ShowcaseOrganizersModel showcaseorganizersfollowed;
  ShowcaseEventsModel showcaseeventssaved;
  ShowcaseArtistsModel showcaseartistsfollowed;
  ShowcaseReviewsModel showcasereviews;
  SharedPreferences prefs;
  // UserModel user;

  int _index = 0;
  void _selectIndex(int value) {
    setState(() {
      _index = value;
    });
  }

  @override
  void initState() {
    loadUser();
    loadClubsFollowed();
    loadOrganizersFollowed();
    loadArtistsFollowed();
    loadEventsSaved();
    loadReviews();
    // _getSavedEvents();
  }

  void loadUser() async {
    user = await getUser(widget.slug);
    setState(() {});
  }

  void loadClubsFollowed() async {
    showcaseclubsfollowed = await getFollowedClubs(widget.slug);
    setState(() {});
  }

  void loadOrganizersFollowed() async {
    showcaseorganizersfollowed = await getFollowedOrganizers(widget.slug);
    setState(() {});
  }

  void loadArtistsFollowed() async {
    showcaseartistsfollowed = await getFollowedArtists(widget.slug);
    setState(() {});
  }

  void loadEventsSaved() async {
    showcaseeventssaved = await getSavedEvents(widget.slug);
    setState(() {});
  }

  void loadReviews() async {
    showcasereviews = await getReviews(widget.slug);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
      return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColorDark,
            title: Text(languageProvider.text.profileText.profile),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          body: SingleChildScrollView(
              child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                    tag: 'propic',
                    child: Container(
                        margin: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 10),
                        height: size.width / 4,
                        width: size.width / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                image: NetworkImage(widget.image ?? ""),
                                fit: BoxFit.cover)))),
                Flexible(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Text(user?.username ?? "",
                            style: TextStyle(
                                color: Color(0xFFCCCCCC),
                                fontWeight: FontWeight.w700,
                                fontSize: 18))),
                    Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: Text(
                            (user?.name ?? "") + ' ' + (user?.surname ?? ""),
                            style: TextStyle(
                                color: Color(0xFF999999),
                                fontWeight: FontWeight.w700,
                                fontSize: 14))),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            '"' + (user?.motto ?? "") + '"',
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Color(0xFF999999)),
                          ),
                        ))
                  ],
                )),
              ],
            ),
            Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Container(
                              child: TextButton(
                                  onPressed: () {
                                    // _getSavedEvents();
                                    setState(() {
                                      _index = 0;
                                    });
                                  },
                                  child: Container(
                                      child: Icon(Icons.calendar_today_outlined,
                                          color: _index == 0
                                              ? Color(0xFFf9b701)
                                              : Theme.of(context)
                                                  .primaryColorDark))))),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark),
                                      left: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark))),
                              child: TextButton(
                                  onPressed: () {
                                    // _getFollowedClubs();
                                    // _getFollowedOrganizers();
                                    // _getFollowedArtists();
                                    setState(() {
                                      _index = 1;
                                    });
                                  },
                                  child: Container(
                                      child: Icon(Icons.remove_red_eye_outlined,
                                          color: _index == 1
                                              ? Color(0xFFf9b701)
                                              : Theme.of(context)
                                                  .primaryColorDark))))),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              // _getReviews();
                              setState(() {
                                _index = 2;
                              });
                            },
                            child: Container(
                                child: Icon(Icons.rate_review,
                                    color: _index == 2
                                        ? Color(0xFFf9b701)
                                        : Theme.of(context).primaryColorDark))),
                      )
                    ])),
            Container(
              child: _index == 0
                  ? Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          showcaseeventssaved != null
                              ? ShowcaseEvents(
                                  data: showcaseeventssaved,
                                )
                              : Container(
                                  width: size.width,
                                  margin: EdgeInsets.only(top: 135),
                                  child: Center(
                                      child: CircularProgressIndicator())),
                        ],
                      ))
                  : _index == 1
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              showcaseclubsfollowed != null
                                  ? ShowcaseClubs(
                                      data: showcaseclubsfollowed,
                                    )
                                  : Container(
                                      width: size.width,
                                      margin: EdgeInsets.only(top: 135),
                                      child: Center(
                                          child: CircularProgressIndicator())),
                              showcaseorganizersfollowed != null
                                  ? ShowcaseOrganizers(
                                      data: showcaseorganizersfollowed,
                                    )
                                  : Container(
                                      width: size.width,
                                      margin: EdgeInsets.only(top: 135),
                                      child: Center(
                                          child: CircularProgressIndicator())),
                              showcaseartistsfollowed != null
                                  ? ShowcaseArtists(
                                      data: showcaseartistsfollowed,
                                    )
                                  : Container(
                                      width: size.width,
                                      margin: EdgeInsets.only(top: 135),
                                      child: Center(
                                          child: CircularProgressIndicator())),
                            ])
                      : Column(
                          children: [
                            showcasereviews != null
                                ? ShowcaseReviews(
                                    languagePack: languageProvider.text,
                                    data: showcasereviews,
                                  )
                                : Container(
                                    width: size.width,
                                    margin: EdgeInsets.only(top: 135),
                                    child: Center(
                                        child: CircularProgressIndicator())),
                          ],
                        ),
            )
            // _returnScreen(_index)
          ])));
    });
  }
}
