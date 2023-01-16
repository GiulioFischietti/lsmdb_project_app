import 'package:eventi_in_zona/providers/entity_provider.dart';
import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_entity.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_social.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/beer.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/repositories/cart_repo.dart';
import 'package:eventi_in_zona/screens/user/bottomtabcontainer.dart';
import 'package:eventi_in_zona/screens/user/cart.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../widgets/user/card_widget_review.dart';

class ClubDetails extends StatefulWidget {
  ObjectId id;
  ClubDetails({Key? key, required this.id}) : super(key: key);

  @override
  _ClubDetailsState createState() => _ClubDetailsState();
}

class _ClubDetailsState extends State<ClubDetails> {
  @override
  void initState() {
    super.initState();
    final entityProvider = Provider.of<EntityProvider>(context, listen: false);
    entityProvider.getEntityById(widget.id.hexString);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<EntityProvider, UserProvider>(
        builder: (context, entityProvider, userProvider, _) {
      return entityProvider.loading
          ? Scaffold(
              body: Container(
                  height: size.height,
                  child: Center(child: CircularProgressIndicator.adaptive())))
          : Scaffold(
              appBar: AppBar(
                leading: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios,
                        size: 18, color: Colors.black)),
                backgroundColor: Colors.grey[100],
                title: Text("Club",
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
                              image: NetworkImage(entityProvider.club.image))),
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
                                          child: Text(entityProvider.club.name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20)))),
                                  userProvider.user.followingEntities.any(
                                          ((element) =>
                                              element ==
                                              entityProvider.club.id))
                                      ? Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.orange),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          margin: EdgeInsets.only(
                                              right: 20, top: 20, bottom: 10),
                                          child: Text(
                                            "Follow",
                                            style: GoogleFonts.poppins(
                                                color: Colors.white),
                                          ))
                                      : Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.orange,
                                                  width: 2),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          margin: EdgeInsets.only(
                                              right: 20, top: 20, bottom: 10),
                                          child: Text(
                                            "Unfollow",
                                            style: GoogleFonts.poppins(
                                                color: Colors.orange),
                                          ))
                                ],
                              ),
                              // Container(
                              //     margin: EdgeInsets.only(left: 20),
                              //     alignment: Alignment.centerLeft,
                              //     child: Text(
                              //       "€ " +
                              //           entityProvider.club.price
                              //               .toStringAsFixed(2),
                              //       style: GoogleFonts.poppins(
                              //           fontSize: 18, color: Colors.black),
                              //     )),
                            ])),

                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Social Medias",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    Container(
                      height: 60,
                      margin: EdgeInsets.only(left: 20),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entityProvider.club.socialMedias.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CardWidgetSocial(
                              social: entityProvider.club.socialMedias[index]);
                        },
                      ),
                    ),

                    field("Description", entityProvider.club.description),
                    field("Address", entityProvider.club.address),
                    // field(
                    //     "Phone",
                    //     (entityProvider.club.phones)
                    //         .reduce((a, b) => a + '\n' + b)
                    //         .toString()),
                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Upcoming Events",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),

                    Container(
                      height: 115,
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: entityProvider.club.upcomingEvents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return entityProvider.club.upcomingEvents.isEmpty
                              ? Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    "No Upcoming Events available for this Club",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Colors.grey[800]),
                                  ))
                              : CardWidgetEventMinimal(
                                  isFav: userProvider.user.likesEvents.any(
                                      ((element) =>
                                          element ==
                                          entityProvider
                                              .club.upcomingEvents[index].id)),
                                  eventMinimal: entityProvider
                                      .club.upcomingEvents[index]);
                        },
                      ),
                    ),

                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Reviews",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),

                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: entityProvider.club.reviews.length,
                        itemBuilder: (BuildContext context, int index) {
                          return entityProvider.club.reviews.isEmpty
                              ? Container(
                                  margin: EdgeInsets.all(20),
                                  child: Text(
                                    "No Reviews available for this Club",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Colors.grey[800]),
                                  ))
                              : CardWidgetReview(
                                  review: entityProvider.club.reviews[index]);
                        },
                      ),
                    )
                    // field(
                    //     "Alcohol Percentage",
                    //     entityProvider.club.alcoholPercentage
                    //             .toStringAsFixed(1) +
                    //         '%'),
                    // field("Volume",
                    //     entityProvider.club.volumeMl.toString() + 'mL'),
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
