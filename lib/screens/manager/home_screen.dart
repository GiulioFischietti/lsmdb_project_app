import 'package:eventi_in_zona/models/event.dart';
import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/providers/entity_provider.dart';
import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/widgets/manager/tile_concluded_order.dart';
import 'package:eventi_in_zona/widgets/manager/tile_inprogress_order.dart';
import 'package:eventi_in_zona/widgets/manager/tile_incoming_event.dart';
import 'package:eventi_in_zona/widgets/manager/tile_shipped_order.dart';
import 'package:provider/provider.dart';

class HomeManager extends StatefulWidget {
  HomeManager({Key? key}) : super(key: key);

  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  late ScrollController eventScrollController;
  String layout = 'grid';

  PageController _pageController = new PageController();

  @override
  void initState() {
    // _con.listenForOrders();
    super.initState();
    final homeProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    homeProvider.getEventsByEntity(userProvider.manager.managedEntity.id);
    eventScrollController = ScrollController()
      ..addListener(() {
        eventScrollListener();
      });
  }

  void eventScrollListener() {
    if (eventScrollController.position.extentAfter == 0) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      eventProvider
          .getMoreEventsByEntity(userProvider.manager.managedEntity.id);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;

  bool incomingEvent(EventMinimal event) {
    return (event.start.isAfter(DateTime.now()));
  }

  bool pastEvent(EventMinimal event) {
    return (event.start.isBefore(DateTime.now()));
  }

  bool available = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child: Consumer2<EventProvider, UserProvider>(
        builder: (context, eventProvider, userProvider, _) {
      return Column(children: [
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, bottom: 10, right: 20),
                          child: Text(
                            "Welcome Back ${userProvider.manager.name}",
                            style: GoogleFonts.poppins(fontSize: 18),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Manager ID: ${userProvider.manager.id}",
                            style: GoogleFonts.poppins(),
                          ))
                    ],
                  )),
              Container(
                height: 50,
                width: 50,
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.14),
                          blurRadius: 7,
                          spreadRadius: 2)
                    ],
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(userProvider.manager.image)),
                    borderRadius: BorderRadius.circular(100)),
              )
            ],
          ),
        ),
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 20, top: 30),
            child: Text("Events Organized",
                style: GoogleFonts.poppins(fontSize: 18))),
        Flexible(
            child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20, top: 0),
                child: ListView.builder(
                    shrinkWrap: true,
                    controller: eventScrollController,
                    itemCount: eventProvider.eventsByEntity.length,
                    itemBuilder: (BuildContext context, int index) {
                      return TileIncomingEvent(
                        eventMinimal: eventProvider.eventsByEntity[index],
                      );
                    })))
      ]);
    }));
  }
}
