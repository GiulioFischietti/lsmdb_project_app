import 'package:eventi_in_zona/models/entity.dart';
import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/screens/user/artist_details.dart';
import 'package:eventi_in_zona/screens/user/club_details.dart';
import 'package:eventi_in_zona/screens/user/organizer_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardWidgetEntityResult extends StatefulWidget {
  EntityMinimal entity;

  CardWidgetEntityResult({
    Key? key,
    required this.entity,
  }) : super(key: key);

  @override
  _CardWidgetEntityResultState createState() => _CardWidgetEntityResultState();
}

class _CardWidgetEntityResultState extends State<CardWidgetEntityResult> {
  bool addedToCart = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 40),
        width: size.width / 2.3,
        child: Column(children: [
          InkWell(
              onTap: () {
                switch (widget.entity.type) {
                  case "club":
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ClubDetails(id: widget.entity.id)));
                    break;
                  case "organizer":
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            OrganizerDetails(id: widget.entity.id)));
                    break;
                  case "artist":
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ArtistDetails(id: widget.entity.id)));
                    break;

                  default:
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) =>
                            OrganizerDetails(id: widget.entity.id)));
                    break;
                }
              },
              child: Container(
                width: size.width,
                height: size.width / 2.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        onError: (error, stacktrace) {
                          print(error);
                          widget.entity.image =
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSJXPMV4om8DHHMSpua5R6d8TlCmR0zDwbQ&usqp=CAU";
                          setState(() {});
                        },
                        fit: BoxFit.cover,
                        image: NetworkImage(widget.entity.image)),
                    borderRadius: BorderRadius.circular(5)),
              )),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "${widget.entity.avgRate}",
                    style: GoogleFonts.poppins(),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 5, bottom: 10),
                  child: RatingBar.builder(
                      initialRating: widget.entity.avgRate,
                      minRating: 1,
                      unratedColor: Colors.white,
                      itemCount: 5,
                      allowHalfRating: true,
                      itemSize: 24.0,
                      onRatingUpdate: (double rate) {},
                      itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.orange,
                          ))),
            ],
          ),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
                child: Container(
                    margin: const EdgeInsets.only(top: 0, left: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.entity.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, fontSize: 14)))),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 0, bottom: 0),
                child: Icon(Icons.emoji_events)),
            Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "${widget.entity.score}",
                  style: GoogleFonts.poppins(),
                )),
          ]),
          Container(
              margin: const EdgeInsets.only(top: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 7.5, vertical: 1.5),
                    decoration: BoxDecoration(
                        color: Colors.orange[300],
                        borderRadius: BorderRadius.circular(50)),
                    margin: const EdgeInsets.only(left: 2.5),
                    alignment: Alignment.centerLeft,
                    child: Text(widget.entity.type,
                        style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.w500))),
                Expanded(child: Container()),
              ])),
          Row(
            children: [],
          )
        ]));
  }
}
