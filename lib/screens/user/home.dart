import 'package:eventi_in_zona/screens/user/select_genre.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController eventScrollController;
  late ScrollController entityScrollController;
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    homeProvider.getNearEvents(context);
    homeProvider.getNearClubs(context);
    eventScrollController = ScrollController()
      ..addListener(() {
        eventScrollListener();
      });
    entityScrollController = ScrollController()
      ..addListener(() {
        entityScrollListener();
      });
    // homeProvider.getBeers();
    // homeProvider.getBooks();
    // homeProvider.getMonitors();

    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.getUserCart();
  }

  void eventScrollListener() {
    if (eventScrollController.position.extentAfter == 0) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      homeProvider.getMoreNearEvents(context);
    }
  }

  void entityScrollListener() {
    if (entityScrollController.position.extentAfter == 0) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      homeProvider.getMoreNearClubs(context);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: Container(
              child: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
                    alignment: Alignment.centerLeft,
                    child: Text("Home",
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1),
                  )),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => Search()));
                      },
                      child: Container(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, bottom: 0),
                          alignment: Alignment.centerLeft,
                          child: Icon(Icons.search))),
                ],
              ),
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 10, right: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [])),
              // Container(
              //     margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              //     child: Container(
              //         padding: EdgeInsets.all(12.5),
              //         decoration: BoxDecoration(
              //             border:
              //                 Border.all(color: Colors.grey[300]!, width: 1),
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(7.5)),
              //         child: Row(children: [
              //           // InkWell(
              //           //     onTap: () {
              //           //       _scaffoldKey.currentState!.openDrawer();
              //           //     },
              //           //     child: Container(
              //           //         child:
              //           //             Icon(Icons.menu, color: Colors.grey[700]))),

              //           InkWell(
              //               onTap: () {
              //                 // Navigator.of(context).push(MaterialPageRoute(
              //                 //     builder: (ctx) => MapResultsSearch(
              //                 //         keyword: "",
              //                 //         position: null,
              //                 //         categories: [])));
              //               },
              //               child: Container(
              //                   child: Icon(Icons.search,
              //                       color: Colors.grey[700]))),
              //           Expanded(
              //               flex: 1,
              //               child: InkWell(
              //                   onTap: () {
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) => Search()));
              //                   },
              //                   child: Container(
              //                       margin:
              //                           EdgeInsets.only(left: 10, right: 10),
              //                       child: Text("Search...",
              //                           maxLines: 1,
              //                           overflow: TextOverflow.ellipsis,
              //                           style: GoogleFonts.poppins(
              //                               textStyle: TextStyle(
              //                                   color: Colors.grey[500],
              //                                   fontSize: 14,
              //                                   fontWeight:
              //                                       FontWeight.w400)))))),
              //         ]))),
              InkWell(
                  onTap: () async {
                    // dynamic pos = await getStoredLocation(context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (ctx) => MapResultsSearch(
                    //         keyword: "", position: pos, categories: [])));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 40),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                                child: Text('Events in your area (100km)',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))))),
                      ]))),
              Container(
                  margin: EdgeInsets.only(top: 0),
                  height: 270,
                  child: Consumer<HomeProvider>(
                      builder: (context, homeProvider, _) {
                    return homeProvider.nearEvents.isNotEmpty
                        ? ListView.builder(
                            controller: eventScrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeProvider.nearEvents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return (CardWidgetEventMinimal(
                                  eventMinimal:
                                      homeProvider.nearEvents[index]));
                            },
                          )
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              "Nessun risultato",
                              style: GoogleFonts.poppins(),
                            ));
                  })),
              InkWell(
                  onTap: () async {
                    // dynamic pos = await getStoredLocation(context);
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (ctx) => MapResultsSearch(
                    //         keyword: "", position: pos, categories: [])));
                  },
                  child: Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 10, top: 40),
                      child: Row(children: [
                        Expanded(
                            child: Container(
                                child: Text('Near Clubs',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400))))),
                      ]))),
              Container(
                  margin: EdgeInsets.only(top: 0),
                  height: 320,
                  child: Consumer<HomeProvider>(
                      builder: (context, homeProvider, _) {
                    return homeProvider.nearClubs.isNotEmpty
                        ? ListView.builder(
                            controller: entityScrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: homeProvider.nearClubs.length,
                            itemBuilder: (BuildContext context, int index) {
                              return (CardWidgetEntity(
                                  entity: homeProvider.nearClubs[index]));
                            },
                          )
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: Text(
                              "Nessun risultato",
                              style: GoogleFonts.poppins(),
                            ));
                  })),
            ],
          )))));
    });
  }
}
