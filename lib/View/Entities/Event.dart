import 'dart:convert';
import 'dart:core';

import 'package:project_app/Engine/Communication/request.dart';
// ignore_for_file: file_names

import 'package:project_app/Model/EventModel.dart';
import 'package:project_app/providers/LanguageProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:maps/maps.dart';
import 'Club.dart';
import 'FullScreenImage.dart';
import 'Organizer.dart';
import 'calendarUtilities.dart';
import 'package:maps_adapter_google_maps/maps_adapter_google_maps.dart';

class Event extends StatefulWidget {
  String image;
  String name;
  String tag;
  int id;
  int slug;
  Event({this.image, this.tag, this.id, this.slug, this.name});
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  void getBottomSheet() {}

  void saveEvent() async {
    dynamic response = await Request.put(
        'saveevent', jsonEncode({"event": event.id, "save": true}));
    print(response);
  }

  void removeEvent() async {
    dynamic response = await Request.put(
        'saveevent', jsonEncode({"event": event.id, "save": false}));
    print(response);
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

  double zoom = 11.0;

  // Paris
  final _key = GlobalKey();

  void onSharePress() {
    Share.share(event.name + ' ' + Request().host + event.slug);
  }

  ScrollController scrollController;

  bool isLoading = true;
  EventModel event;

  Future<void> getEvent() async {
    String response = await Request.get('event/' + widget.slug.toString());

    event = EventModel.fromJson(jsonDecode(response));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getEvent();
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
    MapAdapter.defaultInstance = MapAdapter.platformSpecific(
      ios: AppleMapsNativeAdapter(),

      // Bing Maps iframe API does not necessarily require API credentials
      // so we use it in the example.
      otherwise: BingMapsIframeAdapter(),
    );
    Size size = MediaQuery.of(context).size;
    expandedHight = size.width;

    return Consumer<LanguageProvider>(builder: (context, languageProvider, _) {
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
                        top < 50 ? event?.name ?? "Evento" : "",
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

                          // title: Text('SliverAppBar'),

                          background: Stack(children: [
                        Positioned(child: Container(height: size.width + 30)),
                        Positioned(
                            top: size.width - 100,
                            child:
                                Container(color: Colors.yellow, height: 100)),
                        Positioned(
                            child: Hero(
                                tag: 'eventimage' + widget.id.toString(),
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
                                        image: widget.image,
                                        tag: 'eventimage' +
                                            widget.id.toString())));
                          },
                          child: Container(
                              height: size.width - 40,
                              width: size.width,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                event?.name ?? "",
                                textAlign: TextAlign.center,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700),
                              )),
                        )),
                      ])),
                    ),
                  ];
                },
                body: ListView(
                  children: [
                    event != null
                        ? event.live
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 25),
                                        child: Icon(Icons.live_tv,
                                            color: Colors.red, size: 18)),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 10, top: 27.5),
                                        child: Text("EVENTO LIVE STREAMING",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18))),
                                  ])
                            : Container()
                        : Container(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 10, top: 20),
                            child: Icon(Icons.public,
                                color: Color(0xFFf9b701), size: 18)),
                        Flexible(
                            child: Container(
                                margin: EdgeInsets.only(top: 20, left: 10),
                                child: RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(children: <TextSpan>[
                                      TextSpan(
                                          text: languageProvider.text.event
                                                  .organizer_primary +
                                              ' ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400)),
                                      TextSpan(
                                          text: event?.organizer?.name,
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () async {
                                              if (event.organizer.type
                                                      .toLowerCase() ==
                                                  "club") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Club(
                                                            id: event
                                                                .organizer.id
                                                                .toString(),
                                                            image: event
                                                                .organizer
                                                                .image,
                                                            name: event
                                                                .organizer.name,
                                                            slug: event
                                                                .organizer.id
                                                                .toString(),
                                                            tag: "clubimage" +
                                                                event.organizer
                                                                    .id
                                                                    .toString())));
                                              } else if (event.organizer.type
                                                      .toLowerCase() ==
                                                  "organizer") {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Organizer(
                                                            id: event
                                                                .organizer.id,
                                                            image: event
                                                                .organizer
                                                                .image,
                                                            name: event
                                                                .organizer.name,
                                                            slug: event
                                                                .organizer.id,
                                                            tag: "clubimage" +
                                                                event.organizer
                                                                    .id
                                                                    .toString())));
                                              }
                                            },
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700)),
                                      (event != null)
                                          ? (event.other_organizers.length == 1)
                                              ? TextSpan(
                                                  text: "e un altro",
                                                  recognizer:
                                                      new TapGestureRecognizer()
                                                        ..onTap = () async {
                                                          showModalBottomSheet(
                                                              context: context,
                                                              isScrollControlled:
                                                                  true,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              20),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              20))),
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF222222),
                                                              builder: (context) => Wrap(
                                                                  children:
                                                                      // Container(
                                                                      //   decoration:
                                                                      //       new BoxDecoration(
                                                                      //     color: Colors
                                                                      //         .white,
                                                                      //     borderRadius:
                                                                      //         new BorderRadius
                                                                      //             .only(
                                                                      //       topLeft:
                                                                      //           const Radius
                                                                      //                   .circular(
                                                                      //               25.0),
                                                                      //       topRight:
                                                                      //           const Radius
                                                                      //                   .circular(
                                                                      //               25.0),
                                                                      //     ),
                                                                      //   ),
                                                                      //   child: Container(
                                                                      //     alignment:
                                                                      //         Alignment
                                                                      //             .center,
                                                                      //     margin:
                                                                      //         EdgeInsets
                                                                      //             .all(
                                                                      //                 20),
                                                                      //     child: Text(
                                                                      //         "Modal content goes here"),
                                                                      //   ),
                                                                      // ),

                                                                      event.other_organizers
                                                                          .asMap()
                                                                          .map((index, element) => MapEntry(
                                                                              index,
                                                                              TextButton(
                                                                                  onPressed: () {
                                                                                    print(event.other_organizers[index].type);
                                                                                    if (event.other_organizers[index].type.toLowerCase() == "club") {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Club(id: event.other_organizers[index].id.toString(), image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id.toString(), tag: "clubimage" + event.other_organizers[index].id.toString())));
                                                                                    } else if (event.other_organizers[index].type.toLowerCase() == "organizer") {
                                                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => Organizer(id: event.other_organizers[index].id, image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id, tag: "clubimage" + event.organizer.id.toString())));
                                                                                    }
                                                                                  },
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Container(margin: EdgeInsets.only(top: index == 0 ? 20 : 0, left: 10), height: 70, width: 70, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(event.other_organizers[index].image), fit: BoxFit.cover))),
                                                                                      Container(margin: EdgeInsets.only(top: index == 0 ? 20 : 0, left: 10), child: Text(event.other_organizers[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                                                                                    ],
                                                                                  ))))
                                                                          .values
                                                                          .toList()));
                                                        },
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700))
                                              : (event.other_organizers
                                                          .length >=
                                                      2)
                                                  ? TextSpan(
                                                      text: languageProvider
                                                              .text.event.and +
                                                          ' ' +
                                                          languageProvider.text
                                                              .event.others +
                                                          event
                                                              ?.other_organizers
                                                              ?.length
                                                              .toString(),
                                                      recognizer:
                                                          new TapGestureRecognizer()
                                                            ..onTap = () async {
                                                              showModalBottomSheet(
                                                                  context:
                                                                      context,
                                                                  isScrollControlled:
                                                                      true,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(
                                                                              20),
                                                                          topLeft: Radius.circular(
                                                                              20))),
                                                                  backgroundColor:
                                                                      Color(
                                                                          0xFF222222),
                                                                  builder: (context) => Wrap(
                                                                      children:
                                                                          // Container(
                                                                          //   decoration:
                                                                          //       new BoxDecoration(
                                                                          //     color: Colors
                                                                          //         .white,
                                                                          //     borderRadius:
                                                                          //         new BorderRadius
                                                                          //             .only(
                                                                          //       topLeft:
                                                                          //           const Radius
                                                                          //                   .circular(
                                                                          //               25.0),
                                                                          //       topRight:
                                                                          //           const Radius
                                                                          //                   .circular(
                                                                          //               25.0),
                                                                          //     ),
                                                                          //   ),
                                                                          //   child: Container(
                                                                          //     alignment:
                                                                          //         Alignment
                                                                          //             .center,
                                                                          //     margin:
                                                                          //         EdgeInsets
                                                                          //             .all(
                                                                          //                 20),
                                                                          //     child: Text(
                                                                          //         "Modal content goes here"),
                                                                          //   ),
                                                                          // ),

                                                                          event.other_organizers
                                                                              .asMap()
                                                                              .map((index, element) => MapEntry(
                                                                                  index,
                                                                                  TextButton(
                                                                                      onPressed: () {
                                                                                        print(event.other_organizers[index].type);
                                                                                        if (event.other_organizers[index].type.toLowerCase() == "club") {
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Club(id: event.other_organizers[index].id.toString(), image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id.toString(), tag: "clubimage" + event.other_organizers[index].id.toString())));
                                                                                        } else if (event.other_organizers[index].type.toLowerCase() == "organizer") {
                                                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => Organizer(id: event.other_organizers[index].id, image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id, tag: "clubimage" + event.organizer.id.toString())));
                                                                                        }
                                                                                      },
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Container(margin: EdgeInsets.only(top: index == 0 ? 20 : 0, left: 10), height: 70, width: 70, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(event.other_organizers[index].image), fit: BoxFit.cover))),
                                                                                          Container(margin: EdgeInsets.only(top: index == 0 ? 20 : 0, left: 10), child: Text(event.other_organizers[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                                                                                        ],
                                                                                      ))))
                                                                              .values
                                                                              .toList()));
                                                              // showModalBottomSheet<
                                                              //         void>(
                                                              //     isScrollControlled:
                                                              //         true,
                                                              // shape: RoundedRectangleBorder(
                                                              //     borderRadius: BorderRadius.only(
                                                              //         topLeft: Radius
                                                              //             .circular(
                                                              //                 10),
                                                              //         topRight: Radius
                                                              //             .circular(
                                                              //                 10))),

                                                              // context: context,
                                                              // builder:
                                                              //     (BuildContext
                                                              //         context) {
                                                              //   return (
                                                              // Wrap(
                                                              //     children: [
                                                              //       Container(
                                                              //         height:
                                                              //             140,
                                                              //         color: Color(
                                                              //             0xFF333333),
                                                              // child:
                                                              // ListView
                                                              //     .builder(
                                                              //   shrinkWrap:
                                                              //       true,
                                                              //   physics:
                                                              //       NeverScrollableScrollPhysics(),
                                                              //   itemCount: event
                                                              //       .other_organizers
                                                              //       .length,
                                                              //   itemBuilder:
                                                              //       (BuildContext context,
                                                              //           int index) {
                                                              //     return Container(
                                                              //         margin: EdgeInsets.all(10),
                                                              //         height: 70,
                                                              //         child: TextButton(
                                                              //             onPressed: () {
                                                              //               print(event.other_organizers[index].type);
                                                              //               if (event.other_organizers[index].type.toLowerCase() == "club") {
                                                              //                 Navigator.push(context, MaterialPageRoute(builder: (context) => Club(id: event.other_organizers[index].id, image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id, tag: "clubimage" + event.other_organizers[index].id.toString())));
                                                              //               } else if (event.other_organizers[index].type.toLowerCase() == "organizer") {
                                                              //                 Navigator.push(context, MaterialPageRoute(builder: (context) => Organizer(id: event.other_organizers[index].id, image: event.other_organizers[index].image, name: event.other_organizers[index].name, slug: event.other_organizers[index].id, tag: "clubimage" + event.organizer.id.toString())));
                                                              //               }
                                                              //             },
                                                              //             child: Row(
                                                              //               children: [
                                                              //                 Container(height: 70, width: 70, decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), image: DecorationImage(image: NetworkImage(event.other_organizers[index].image), fit: BoxFit.cover))),
                                                              //                 Container(margin: EdgeInsets.all(10), child: Text(event.other_organizers[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)))
                                                              //               ],
                                                              //             )));
                                                              //   },
                                                              // ),
                                                              //   )
                                                              // ]);
                                                              // }
                                                              // );
                                                            },
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700))
                                                  : TextSpan(
                                                      text: "",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w700))
                                          : TextSpan(),
                                    ])))),
                      ],
                    ),
                    event != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  child: Icon(Icons.access_time,
                                      color: Color(0xFFf9b701), size: 18)),
                              Flexible(
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 20, left: 10),
                                      child: RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(children: <TextSpan>[
                                            TextSpan(
                                                text: languageProvider
                                                        .text.event.from_hours +
                                                    ' ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            TextSpan(
                                                text: (event.start.hour < 10
                                                        ? "0" +
                                                            event.start.hour
                                                                .toString()
                                                        : event.start.hour
                                                            .toString()) +
                                                    ':' +
                                                    (event.start.minute < 10
                                                        ? "0" +
                                                            event.start.minute
                                                                .toString()
                                                        : event.start.minute
                                                            .toString()) +
                                                    ' ',
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () async {},
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                            TextSpan(
                                                text: languageProvider
                                                    .text.event.to_hours,
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () async {},
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            TextSpan(
                                                text: ' ' +
                                                    (event.end.hour < 10
                                                        ? "0" +
                                                            event.end.hour
                                                                .toString()
                                                        : event.end.hour
                                                            .toString()) +
                                                    ':' +
                                                    (event.end.minute < 10
                                                        ? "0" +
                                                            event.end.minute
                                                                .toString()
                                                        : event.end.minute
                                                            .toString()),
                                                recognizer:
                                                    new TapGestureRecognizer()
                                                      ..onTap = () async {},
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ]))))
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  child: Icon(Icons.access_time,
                                      color: Color(0xFFf9b701), size: 18)),
                              Container(
                                height: 20,
                                width: size.width - 60,
                                color: Color(0xFF343434),
                                margin: EdgeInsets.only(top: 20, left: 10),
                              )
                            ],
                          ),
                    event != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Icon(Icons.access_time,
                                      color: Colors.transparent, size: 18)),
                              Container(
                                  margin: EdgeInsets.only(top: 5, left: 10),
                                  child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(children: <TextSpan>[
                                        TextSpan(
                                            text: languageProvider
                                                .text.event.from_day,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.w400)),
                                        TextSpan(
                                            text: getDay(
                                                    event.start.weekday - 1) +
                                                ' ' +
                                                event.start.day.toString() +
                                                ' ' +
                                                getMonth(event.start.month - 1),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () async {},
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.w700)),
                                        TextSpan(
                                            text: languageProvider
                                                .text.event.until,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.w400)),
                                        TextSpan(
                                            text: getDay(
                                                    event.end.weekday - 1) +
                                                ' ' +
                                                event.end.day.toString() +
                                                ' ' +
                                                getMonth(event.end.month - 1),
                                            recognizer:
                                                new TapGestureRecognizer()
                                                  ..onTap = () async {},
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[400],
                                                fontWeight: FontWeight.w700)),
                                      ])))
                            ],
                          )
                        : Container(),
                    event != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  child: Icon(Icons.music_note,
                                      color: Color(0xFFf9b701), size: 18)),
                              Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  child: Text(event.genres,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)))
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 20),
                                  child: Icon(Icons.music_note,
                                      color: Color(0xFFf9b701), size: 18)),
                              Container(
                                height: 20,
                                width: size.width - 60,
                                color: Color(0xFF343434),
                                margin: EdgeInsets.only(top: 20, left: 10),
                              )
                            ],
                          ),
                    event != null
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
                                        print(event.latitude);
                                        MapsLauncher.launchCoordinates(
                                            event.latitude, event.longitude);
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              top: 20, left: 10),
                                          child: Text(
                                              event.street +
                                                  ", " +
                                                  event.province +
                                                  ' ' +
                                                  event.province_acronym,
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
                                color: Color(0xFF343434),
                                margin: EdgeInsets.only(top: 20, left: 10),
                              )
                            ],
                          ),
                    event != null
                        ? Container(
                            margin: EdgeInsets.all(15),
                            height: 300,
                            child: MapWidget(
                              key: _key,
                              adapter: selectedAdapter,
                              location: MapLocation(
                                query: query,
                                geoPoint:
                                    GeoPoint(event.latitude, event.longitude),
                                zoom: Zoom(zoom),
                              ),
                              markers: {
                                MapMarker(
                                  geoPoint:
                                      GeoPoint(event.latitude, event.longitude),
                                  details: MapMarkerDetails(
                                    title: widget.name,
                                    snippet: widget.name,
                                  ),
                                ),
                              },
                            ),
                          )
                        : Container(),
                    event != null
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 10, top: 30, bottom: 10),
                                  child: Icon(Icons.edit,
                                      color: Color(0xFFf9b701), size: 18)),
                              Flexible(
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          top: 30, left: 10, bottom: 10),
                                      child: Text(event.description ?? "",
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
                                color: Color(0xFF343434),
                                margin: EdgeInsets.only(top: 30, left: 10),
                              )
                            ],
                          ),
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
                        if (event.saved) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(languageProvider
                                .text.event.event_remove_success),
                          ));
                          removeEvent();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(languageProvider
                                .text.event.event_saved_success),
                          ));
                          saveEvent();
                        }
                        setState(() {
                          event.saved = !event.saved;
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
                                event != null
                                    ? event.saved
                                        ? languageProvider.text.event.remove
                                        : languageProvider.text.event.save
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
    });
  }
}
