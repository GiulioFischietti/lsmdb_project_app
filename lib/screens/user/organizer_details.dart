import 'package:eventi_in_zona/models/review.dart';
import 'package:eventi_in_zona/providers/entity_provider.dart';
import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/add_review.dart';
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
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../widgets/user/card_widget_review.dart';

class OrganizerDetails extends StatefulWidget {
  ObjectId id;
  OrganizerDetails({Key? key, required this.id}) : super(key: key);

  @override
  _OrganizerDetailsState createState() => _OrganizerDetailsState();
}

class _OrganizerDetailsState extends State<OrganizerDetails> {
  @override
  void initState() {
    super.initState();
    final entityProvider = Provider.of<EntityProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    entityProvider.getEntityById(
        widget.id.hexString, userProvider.user.id.hexString);
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
                title: Text("Organizer",
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
                              image: NetworkImage(
                                  entityProvider.organizer.image))),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 20, top: 20, bottom: 0),
                        padding: EdgeInsets.only(top: 10),
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                          child: Text(
                                              entityProvider.organizer.name,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20)))),
                                  entityProvider.organizer.followedByUser
                                      ? InkWell(
                                          onTap: () async {
                                            entityProvider.unfollowOrganizer(
                                                userProvider.user.id);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 0),
                                              child: Text(
                                                "Unfollow",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.orange),
                                              )))
                                      : InkWell(
                                          onTap: () async {
                                            entityProvider.followOrganizer(
                                                userProvider.user.id);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.orange),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.orange),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 5),
                                              margin: EdgeInsets.only(
                                                  right: 20,
                                                  top: 10,
                                                  bottom: 0),
                                              child: Text(
                                                "Follow",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                              )))
                                ],
                              ),
                              Row(
                                children: [
                                  RatingBar.builder(
                                      wrapAlignment: WrapAlignment.start,
                                      onRatingUpdate: (rate) {},
                                      initialRating:
                                          entityProvider.organizer.avgRate,
                                      minRating: 1,
                                      unratedColor: Colors.grey[400],
                                      itemCount: 5,
                                      itemSize: 24.0,
                                      itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                          )),
                                  Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Text(
                                        entityProvider.organizer.avgRate
                                            .toString(),
                                        style: GoogleFonts.poppins(),
                                      ))
                                ],
                              )
                            ])),
                    field("Description", entityProvider.organizer.description),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Social Medias",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    entityProvider.organizer.socialMedias.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No SocialMedias info available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            height: 80,
                            margin: EdgeInsets.only(left: 10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  entityProvider.organizer.socialMedias.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidgetSocial(
                                    social: entityProvider
                                        .organizer.socialMedias[index]);
                              },
                            ),
                          ),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Websites",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    entityProvider.organizer.websites.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No Websites info available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            margin: EdgeInsets.only(left: 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount:
                                  entityProvider.organizer.websites.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {},
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                            entityProvider
                                                .organizer.websites[index],
                                            style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ))));
                              },
                            ),
                          ),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Phones",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    entityProvider.organizer.phones.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No Phones info available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            margin: EdgeInsets.only(left: 20),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: entityProvider.organizer.phones.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          "tel:${entityProvider.organizer.phones[index]}"));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                            entityProvider
                                                .organizer.phones[index],
                                            style: GoogleFonts.poppins(
                                              color: Colors.blue,
                                              decoration:
                                                  TextDecoration.underline,
                                            ))));
                              },
                            ),
                          ),
                    Container(
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Email",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    entityProvider.organizer.email == ""
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No Email info available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            margin: EdgeInsets.only(left: 20),
                            child: InkWell(
                                onTap: () {
                                  launchUrl(Uri.parse(
                                      "mailto:${entityProvider.organizer.email}"));
                                },
                                child: Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Text(entityProvider.organizer.email,
                                        style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ))))),
                    Container(
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          "Upcoming Events",
                          style: GoogleFonts.poppins(fontSize: 18),
                        )),
                    entityProvider.organizer.upcomingEvents.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No Upcoming Events info available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            height: 255,
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: entityProvider
                                  .organizer.upcomingEvents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidgetEventMinimal(
                                    // isFav: userProvider.user.likesEvents.any(
                                    //     ((element) =>
                                    //         element ==
                                    //         entityProvider.organizer
                                    //             .upcomingEvents[index].id)),
                                    eventMinimal: entityProvider
                                        .organizer.upcomingEvents[index]);
                              },
                            ),
                          ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                margin: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Reviews",
                                  style: GoogleFonts.poppins(fontSize: 18),
                                ))),
                        entityProvider.organizer.reviewedByUser
                            ? Container()
                            : InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => AddReview(
                                          entityId: widget.id,
                                          name: entityProvider.organizer.name,
                                          type: "organizer",
                                          my_review: Review({}))));
                                },
                                child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    margin: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Add Review",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.orange),
                                    ))),
                      ],
                    ),
                    entityProvider.organizer.reviews.isEmpty
                        ? Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "No Reviews available for this Organizer",
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.grey[500]),
                            ))
                        : Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(top: 10),
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  entityProvider.organizer.reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return entityProvider.organizer.reviews.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.all(20),
                                        child: Text(
                                          "No Reviews available for this Organizer",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              color: Colors.grey[800]),
                                        ))
                                    : CardWidgetReview(
                                        isMine: entityProvider.organizer
                                                .reviews[index].user.id ==
                                            userProvider.user.id,
                                        review: entityProvider
                                            .organizer.reviews[index]);
                              },
                            ),
                          ),
                    (entityProvider.organizer.reviews.length <
                            entityProvider.organizer.nReviews)
                        ? entityProvider.loadingReviews
                            ? Container(
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : InkWell(
                                onTap: () {
                                  entityProvider.getMoreReviewsOrganizer();
                                },
                                child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.all(20),
                                    child: Text(
                                      "Load More Reviews",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )))
                        : Container()
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
