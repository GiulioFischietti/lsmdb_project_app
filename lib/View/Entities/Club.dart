import 'dart:convert';
import 'dart:core';
import 'package:project_app/Engine/Communication/request.dart';
// ignore_for_file: file_names

import 'package:project_app/Engine/Utility.dart/Translate.dart';
import 'package:project_app/Model/clubModel.dart';
import 'package:project_app/Model/ReviewModel.dart';
import 'package:project_app/Model/ShowcaseReviewsModel.dart';
import 'package:project_app/Model/UserModel.dart';
import 'package:project_app/View/Entities/ReviewEditor.dart';
import 'package:project_app/View/Entities/User.dart';
import 'package:project_app/View/Items/showcase_reviews.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maps/maps.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'FullScreenImage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Club extends StatefulWidget {
  String image;
  String name;
  String tag;
  int id;
  int slug;
  Club({this.image, this.tag, this.id, this.slug, this.name});
  @override
  _ClubState createState() => _ClubState();
}

class _ClubState extends State<Club> {
  String username;
  double _height = 0;
  FocusNode myFocusNode;
  Translator text;
  ShowcaseReviewsModel showcasereviews;
  TextEditingController reviewDescription = new TextEditingController();

  Future<void> _addReview() async {
    final userMdl = Provider.of<UserProvider>(context, listen: false);
    userMdl.getUserData(context);
    var response = await Request.put('addreview', {
      "type": "club",
      "organizer": widget.slug.toString(),
      "rating": rating.toString(),
      "description": reviewDescription.text ?? ""
    });
    print(response);
    ReviewModel new_rev = new ReviewModel({
      "id": 0,
      "slug": "0",
      "username": username,
      "name": username,
      "type": "user",
      "link": "test",
      "rating": rating,
      "description": reviewDescription.text,
      "image": userMdl.user.image,
      "created_at": DateTime.now().toString()
    });
    // print(new_rev.description);
    setState(() {
      buttonvisible = false;
      showcasereviews.reviews.insert(0, new_rev);
    });

    _getReviews();
    print(showcasereviews.reviews[0].id);
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  UserModel user;
  bool buttonvisible = true;

  void getUsername() async {
    final userMdl = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      username = userMdl.user.username;
    });
  }

  Future<void> _getReviews() async {
    final response = await Request.get('clubreviews/' + widget.slug.toString());

    setState(() {
      showcasereviews = ShowcaseReviewsModel.fromJson(jsonDecode(response));
    });
    final userMdl = Provider.of<UserProvider>(context, listen: false);

    setState(() {
      username = userMdl.user.username;
    });

    for (ReviewModel review in showcasereviews.reviews) {
      if (review.username == username) {
        setState(() {
          buttonvisible = false;
        });
      }
    }
  }

  void followClub() async {
    dynamic response = await Request.put('follow',
        jsonEncode({"organizer": club.id, "follow": true, "type": "club"}));
  }

  void unfollowClub() async {
    dynamic response = await Request.put('follow',
        jsonEncode({"organizer": club.id, "follow": false, "type": "club"}));
  }

  static const AppleMapsNativeAdapter appleMapsNative =
      AppleMapsNativeAdapter();
  static const bingMapsIframe = BingMapsIframeAdapter();
  static const defaultMapAdapter = MapAdapter.platformSpecific(
    ios: appleMapsNative,
    otherwise: bingMapsIframe,
  );
  MapAdapter selectedAdapter = defaultMapAdapter;
  GeoPoint parisGeoPoint = GeoPoint(48.856613, 2.352222);
  String query;

  double zoom = 15.0;

  // Paris
  final _key = GlobalKey();
  double rating = 0;
  void onSharePress() {
    Share.share(club.name + ' ' + Request().host + club.slug.toString());
  }

  ScrollController scrollController;

  bool visiblebutton() {
    for (ReviewModel review in showcasereviews.reviews) {
      if (review.username == username) {
        return true;
      }
    }
    return false;
  }

  bool isLoading = true;
  ClubModel club;
  Translator languagePack;
  Future<void> getClub() async {
    final prefs = await SharedPreferences.getInstance();
    String text = prefs.getString('languagepack');

    String response = await Request.get('club/' + widget.slug.toString());

    setState(() {
      isLoading = false;
      languagePack = Translator.fromJson(jsonDecode(text));
      club = ClubModel.fromJson(jsonDecode(response));
      rating = club.rating;
    });
    _getReviews();
  }

  @override
  void initState() {
    super.initState();
    getUsername();
    getClub();

    myFocusNode = FocusNode();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  double expandedHight;
  double get top {
    double res = expandedHight - 35;
    if (scrollController.hasClients) {
      double offset = scrollController.offset;
      if (offset < (res - kToolbarHeight)) {
        res -= offset;
      } else {
        res = kToolbarHeight - expandedHight;
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    expandedHight = size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        children: [
          NestedScrollView(
              controller: scrollController,
              headerSliverBuilder: (context, value) {
                return [
                  SliverAppBar(
                    title: Text(
                      top < 50 ? club?.name ?? "Club" : "",
                      textAlign: TextAlign.left,
                    ),
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.share),
                        tooltip: 'Add new entry',
                        onPressed: () {
                          onSharePress();
                        },
                      ),
                    ],
                    pinned: true,
                    backgroundColor: Color(0xFF333333),
                    expandedHeight: size.width - 40,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Stack(children: [
                      Positioned(
                          child: Hero(
                              tag: 'clubimage' + widget.id.toString(),
                              child: Container(
                                height: size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(widget.image),
                                        fit: BoxFit.cover)),
                              ))),
                      Container(
                        height: size.width,
                        decoration: BoxDecoration(
                            //color: Colors.white,
                            gradient: LinearGradient(
                                begin: FractionalOffset.topCenter,
                                end: FractionalOffset.bottomCenter,
                                colors: [
                              Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.0),
                              Theme.of(context).primaryColorDark,
                            ],
                                stops: [
                              0.0,
                              1.0
                            ])),
                      ),
                      Positioned(
                          child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullScreenImage(
                                      image: widget.image, tag: 'clubimage')));
                        },
                        child: Container(
                            height: size.width - 40,
                            width: size.width,
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.name,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.ltr,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                        padding: EdgeInsets.only(bottom: 5)),
                                    onPressed: () {},
                                    child: RatingBar.builder(
                                      initialRating: rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemCount: 5,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 1.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (double rat) {
                                        print(rat);
                                        print(rating);
                                      },
                                    )),
                                Text(
                                    (club?.rating_count?.toString() ?? '') +
                                        " Reviews",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))
                              ],
                            )),
                      )),
                    ])),
                  ),
                ];
              },
              body: ListView(
                children: [
                  club != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 20),
                                child: Icon(Icons.room,
                                    color: Color(0xFFf9b701), size: 18)),
                            Flexible(
                                child: InkWell(
                                    highlightColor: Color(0xFF222222),
                                    splashColor: Color(0xFF222222),
                                    onTap: () {
                                      MapsLauncher.launchCoordinates(
                                          club.latitude, club.longitude);
                                    },
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 20, left: 10),
                                        child: Text(
                                            club.street +
                                                ", " +
                                                club.province +
                                                ',  ' +
                                                club.province_acronym,
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 18)))))
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 20),
                                child: Icon(Icons.room,
                                    color: Color(0xFFf9b701), size: 18)),
                            Container(
                              height: 20,
                              width: size.width - 60,
                              color: Color(0xFF333333),
                              margin: EdgeInsets.only(top: 20, left: 10),
                            )
                          ],
                        ),
                  // Container(
                  //     margin: EdgeInsets.all(15),
                  //     height: 300,
                  //     child: GoogleMaps.GoogleMap(
                  //       onMapCreated: _onMapCreated,
                  //       initialCameraPosition: GoogleMaps.CameraPosition(
                  //         target: _center,
                  //         zoom: 11.0,
                  //       ),
                  //     )),
                  club != null
                      ? Container(
                          margin: EdgeInsets.all(15),
                          height: size.width / 1.8,
                          child: MapWidget(
                            scrollGesturesEnabled: false,
                            zoomControlsEnabled: false,
                            zoomGesturesEnabled: false,
                            key: _key,
                            adapter: selectedAdapter,
                            location: MapLocation(
                              query: query,
                              geoPoint: GeoPoint(club.latitude, club.longitude),
                              zoom: Zoom(zoom),
                            ),
                            markers: {
                              MapMarker(
                                geoPoint:
                                    GeoPoint(club.latitude, club.longitude),
                                details: MapMarkerDetails(
                                  title: widget.name,
                                  snippet: widget.name,
                                ),
                              ),
                            },
                          ),
                        )
                      : Container(
                          color: Color(0xFF343434),
                          margin: EdgeInsets.all(15),
                          height: size.width / 1.8,
                        ),
                  club != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Icon(Icons.phone,
                                    color: Color(0xFFf9b701), size: 18)),
                            Flexible(
                                child: InkWell(
                                    onTap: () {
                                      _makePhoneCall(Uri(
                                        scheme: 'tel',
                                        path: club.phone,
                                      ).toString());
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, bottom: 10),
                                        child: Text(club.phone ?? "",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400)))))
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 30),
                                child: Icon(Icons.phone,
                                    color: Color(0xFFf9b701), size: 18)),
                            Container(
                              height: 20,
                              width: size.width - 60,
                              color: Color(0xFF333333),
                              margin: EdgeInsets.only(top: 30, left: 10),
                            )
                          ],
                        ),
                  club != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Icon(Icons.email,
                                    color: Color(0xFFf9b701), size: 18)),
                            Flexible(
                                child: InkWell(
                                    onTap: () {
                                      launch(Uri(
                                        scheme: 'mailto',
                                        path: club.email,
                                      ).toString());
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, bottom: 10),
                                        child: Text(club.email ?? "",
                                            style: TextStyle(
                                                fontSize: 18,
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400)))))
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 30),
                                child: Icon(Icons.email,
                                    color: Color(0xFFf9b701), size: 18)),
                            Container(
                              height: 20,
                              width: size.width - 60,
                              color: Color(0xFF333333),
                              margin: EdgeInsets.only(top: 30, left: 10),
                            )
                          ],
                        ),

                  club != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, bottom: 10),
                                child: Icon(Icons.edit,
                                    color: Color(0xFFf9b701), size: 18)),
                            Flexible(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: 10, left: 10, bottom: 10),
                                    child: Text(club.description ?? "",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400))))
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 10, top: 30),
                                child: Icon(Icons.edit,
                                    color: Color(0xFFf9b701), size: 18)),
                            Container(
                              height: 20,
                              width: size.width - 60,
                              color: Color(0xFF333333),
                              margin: EdgeInsets.only(top: 30, left: 10),
                            )
                          ],
                        ),
                  buttonvisible
                      ? Container(
                          decoration: BoxDecoration(
                              color: Color(0xFF333333),
                              borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          height: 50,
                          child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              splashColor: Colors.yellow,
                              onTap: () {
                                showModalBottomSheet(
                                    isScrollControlled: true,
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20))),
                                    backgroundColor: Color(0xFF222222),
                                    builder: (context) =>
                                        StatefulBuilder(builder: (BuildContext
                                                context,
                                            StateSetter
                                                setState /*You can rename this!*/) {
                                          return Container(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: ListView(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  children: [
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                            languagePack
                                                                ?.reviewText
                                                                ?.new_review,
                                                            style: TextStyle(
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Color(
                                                                    0xFFCCCCCC)))),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            top: 20, bottom: 0),
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child:
                                                            RatingBar.builder(
                                                          unratedColor:
                                                              Color(0xFF999999),
                                                          initialRating: 0,
                                                          minRating: 1,
                                                          direction:
                                                              Axis.horizontal,
                                                          allowHalfRating:
                                                              false,
                                                          itemCount: 5,
                                                          itemPadding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      1.0),
                                                          itemBuilder:
                                                              (context, _) =>
                                                                  Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                          ),
                                                          onRatingUpdate:
                                                              (double r) {
                                                            myFocusNode
                                                                .requestFocus();
                                                            setState(() {
                                                              _height = 50;
                                                              rating = r;
                                                            });
                                                            print('aaaaa');
                                                          },
                                                        )),
                                                    AnimatedContainer(
                                                        height: _height,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 40,
                                                                vertical: 20),
                                                        curve: Curves
                                                            .fastOutSlowIn,
                                                        child: TextFormField(
                                                          controller:
                                                              reviewDescription,
                                                          focusNode:
                                                              myFocusNode,
                                                          maxLines: 3,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .sentences,
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFFcccccc),
                                                              fontSize: 16),
                                                          cursorHeight: 20,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              hintStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Color(
                                                                      0xFF999999)),
                                                              hintText: languagePack
                                                                  ?.reviewText
                                                                  ?.textarea_placeholder),
                                                          cursorColor:
                                                              Color(0xFFcccccc),
                                                        ),
                                                        duration: Duration(
                                                            seconds: 1)),
                                                    Container(
                                                        margin: EdgeInsets.only(
                                                            left: 40,
                                                            right: 40,
                                                            bottom: 20),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            _addReview();
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          style: TextButton.styleFrom(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100)),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          15),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFf9b701)),
                                                          child: Container(
                                                              child: Text(
                                                                  languagePack
                                                                      ?.reviewText
                                                                      ?.post,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: Colors
                                                                          .white))),
                                                        ))
                                                  ]));
                                        }));
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(10),
                                            child: Icon(Icons.add,
                                                color: Color(0xFFf9b701),
                                                size: 18)),
                                        Expanded(
                                            child: Container(
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                child: Text(
                                                    languagePack?.reviewText
                                                            ?.new_review ??
                                                        "",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFFf9b701),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700))))
                                      ]))))
                      : Container(),

                  showcasereviews != null
                      ? Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ShowcaseReviews(
                            getReviews: _getReviews,
                            data: showcasereviews,
                            languagePack: languagePack,
                          ))
                      : Container(
                          width: size.width,
                          margin: EdgeInsets.only(top: 135),
                          child: Center(child: CircularProgressIndicator())),
                ],
              )),
          Positioned(
            top: top,
            width: MediaQuery.of(context).size.width,
            child: Align(
                child: TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0),
                        primary: Colors.transparent.withOpacity(0)),
                    onPressed: () {
                      if (club.followed) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(languagePack
                                ?.organizerText?.unfollow_success)));

                        unfollowClub();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                languagePack?.organizerText?.follow_success)));
                        followClub();
                      }
                      setState(() {
                        club.followed = !club.followed;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFf9b701),
                            borderRadius: BorderRadius.circular(50)),
                        margin: EdgeInsets.only(
                          left: 40,
                          right: 40,
                        ),
                        width: size.width,
                        alignment: Alignment.center,
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              club != null
                                  ? club.followed
                                      ? languagePack?.organizerText?.unfollow
                                      : languagePack?.organizerText?.follow
                                  : "",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700),
                            ))))),
          ),
        ],
      ),
    );
  }
}
