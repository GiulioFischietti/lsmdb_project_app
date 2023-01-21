import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/screens/user/event_details.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CardWidgetEventMinimal extends StatefulWidget {
  EventMinimal eventMinimal;

  // ProductController _con;
  // final Favorite preferiti;
  CardWidgetEventMinimal({
    Key? key,
    required this.eventMinimal,

    /*this.preferiti*/
  }) : super(key: key);

  @override
  _CardWidgetEventMinimalState createState() => _CardWidgetEventMinimalState();
}

class _CardWidgetEventMinimalState extends State<CardWidgetEventMinimal> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // widget._con = ProductController();
    // widget._con.product = widget.product;
    return Container(
      width: size.width / 1.6,
      margin: EdgeInsets.only(left: 20, top: 20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => EventDetails(id: widget.eventMinimal.id)));
        },
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            onError: (error, stacktrace) {
                              widget.eventMinimal.image =
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSJXPMV4om8DHHMSpua5R6d8TlCmR0zDwbQ&usqp=CAU";
                              setState(() {});
                            },
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.eventMinimal.image,
                            ),
                          )),
                    ),
                    Positioned(
                        left: 2.5,
                        top: 2.5,
                        child: widget.eventMinimal.dist != 0
                            ? Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white.withOpacity(0.8)),
                                alignment: Alignment.topRight,
                                child: Text(
                                  '${(widget.eventMinimal.dist / 1000).toStringAsFixed(2)}km',
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ))
                            : Container()),
                    Positioned(
                        right: 2.5,
                        top: 2.5,
                        child: Container(
                            margin: EdgeInsets.all(5),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white.withOpacity(0.8)),
                            alignment: Alignment.topRight,
                            child: Text(
                              '${widget.eventMinimal.start.day} ${months[widget.eventMinimal.start.month]}',
                              style: GoogleFonts.poppins(color: Colors.black),
                            )))
                  ],
                )),
            Container(
                margin: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                          Expanded(
                              child: Container(
                                  child: Text(
                            widget.eventMinimal.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400),
                          ))),
                          // InkWell(
                          //     onTap: () {
                          //       setState(() {
                          //         widget.isFav = !widget.isFav;
                          //       });
                          //       final userProvider = Provider.of<UserProvider>(
                          //           context,
                          //           listen: false);
                          //       if (widget.isFav) {
                          //         userProvider.likeEvent(widget.eventMinimal.id,
                          //             widget.eventMinimal.start);
                          //       } else {
                          //         userProvider.dislikeEvent(
                          //             widget.eventMinimal.id,
                          //             widget.eventMinimal.start);
                          //       }

                          //       SnackBar snackBar = SnackBar(
                          //         content: Text(
                          //             '${widget.isFav ? "Added to" : "Removed from"} favorites'),
                          //       );
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(snackBar);
                          //     },
                          //     child: Container(
                          //         margin: const EdgeInsets.only(right: 2.5),
                          //         child: Icon(
                          //             widget.isFav
                          //                 ? Icons.favorite
                          //                 : Icons.favorite_outline,
                          //             size: 16,
                          //             color: widget.isFav
                          //                 ? Colors.red
                          //                 : Colors.black)))
                        ])),
                    Container(
                      height: 10,
                    ),
                    Wrap(
                        children: widget.eventMinimal.genres
                            .map((e) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.orange),
                                margin: EdgeInsets.only(right: 10, bottom: 2.5),
                                padding: EdgeInsets.only(
                                    top: 2.5,
                                    bottom: 2.5,
                                    left: 2.5,
                                    right: 2.5),
                                child: Text(
                                  e,
                                  style: GoogleFonts.poppins(
                                      fontSize: 12, color: Colors.white),
                                )))
                            .toList())
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
