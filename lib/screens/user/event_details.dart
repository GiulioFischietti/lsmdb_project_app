import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_entity.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';

class EventDetails extends StatefulWidget {
  ObjectId id;
  EventDetails({Key? key, required this.id}) : super(key: key);

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  void initState() {
    super.initState();
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    eventProvider.getEventById(
        widget.id.hexString, userProvider.user.id.hexString);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<EventProvider, UserProvider>(
        builder: (context, eventProvider, userProvider, _) {
      return eventProvider.loading
          ? Scaffold(
              body: Container(
                  height: size.height,
                  child: const Center(
                      child: CircularProgressIndicator.adaptive())))
          : Scaffold(
              appBar: AppBar(
                actions: [
                  InkWell(
                      onTap: () {
                        if (eventProvider.event.likedByUser) {
                          eventProvider.dislikeEvent(userProvider.user.id);
                        } else {
                          eventProvider.likeEvent(userProvider.user.id);
                        }
                      },
                      child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10, left: 10),
                          child: Icon(
                              eventProvider.event.likedByUser
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: Colors.black))),
                ],
                leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios,
                        size: 18, color: Colors.black)),
                backgroundColor: Colors.grey[100],
                title: Text("Event",
                    style: GoogleFonts.poppins(
                        color: Colors.black, fontWeight: FontWeight.w500)),
              ),
              backgroundColor: Colors.white,
              body: Column(children: [
                Expanded(
                    child: ListView(
                  children: [
                    Container(
                      height: size.width / 1.5,
                      width: size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(eventProvider.event.image))),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20, top: 20, bottom: 10),
                                          child: Text(eventProvider.event.name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20)))),
                                ],
                              ),
                              // Container(
                              //     margin: EdgeInsets.only(left: 20),
                              //     alignment: Alignment.centerLeft,
                              //     child: Text(
                              //       "€ " +
                              //           eventProvider.event.price
                              //               .toStringAsFixed(2),
                              //       style: GoogleFonts.poppins(
                              //           fontSize: 18, color: Colors.black),
                              //     )),
                            ])),
                    Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Row(
                            children: eventProvider.event.genres
                                .map((e) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.orange),
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.only(
                                        top: 2.5,
                                        bottom: 2.5,
                                        left: 5,
                                        right: 5),
                                    child: Text(
                                      e,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12, color: Colors.white),
                                    )))
                                .toList())),

                    field("Description", eventProvider.event.description),
                    field("Start Date",
                        '${eventProvider.event.start.day} ${months[eventProvider.event.start.month]} at ${eventProvider.event.start.hour}:${eventProvider.event.start.minute >= 10 ? eventProvider.event.start.minute : "0${eventProvider.event.start.minute}"}'),
                    field("End Date",
                        '${eventProvider.event.end.day} ${months[eventProvider.event.end.month]} at ${eventProvider.event.end.hour}:${eventProvider.event.end.minute >= 10 ? eventProvider.event.end.minute : "0${eventProvider.event.end.minute}"}'),

                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Organizers",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),

                    Container(
                      height: 115,
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: eventProvider.event.organizers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardWidetMinimalEntity(
                              entityMinimal:
                                  eventProvider.event.organizers[index]);
                        },
                      ),
                    ),

                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Artists",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),

                    Container(
                      height: 115,
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      child: eventProvider.event.artists.isEmpty
                          ? Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "No Artist info available for this event",
                                style: GoogleFonts.poppins(
                                    fontSize: 16, color: Colors.grey[500]),
                              ))
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: eventProvider.event.artists.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidetMinimalEntity(
                                    entityMinimal:
                                        eventProvider.event.artists[index]);
                              },
                            ),
                    ),
                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Club hosting event",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),

                    Container(
                        height: 115,
                        color: Colors.white,
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            CardWidetMinimalEntity(
                                entityMinimal: eventProvider.event.club)
                          ],
                        )),
                    field("Address", eventProvider.event.address)
                    // field(
                    //     "Alcohol Percentage",
                    //     eventProvider.event.alcoholPercentage
                    //             .toStringAsFixed(1) +
                    //         '%'),
                    // field("Volume",
                    //     eventProvider.event.volumeMl.toString() + 'mL'),
                  ],
                )),
              ]));
    });
  }

  Widget field(String title, String content) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(fontSize: 18),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      content,
                      style: GoogleFonts.poppins(),
                    ))
              ],
            )),
          ],
        ));
  }
}
