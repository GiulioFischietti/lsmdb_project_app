import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/screens/user/artist_details.dart';
import 'package:eventi_in_zona/screens/user/club_details.dart';
import 'package:eventi_in_zona/screens/user/organizer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardWidetMinimalEntity extends StatefulWidget {
  EntityMinimal entityMinimal;
  CardWidetMinimalEntity({required this.entityMinimal, super.key});

  @override
  State<CardWidetMinimalEntity> createState() => _CardWidetMinimalEntityState();
}

class _CardWidetMinimalEntityState extends State<CardWidetMinimalEntity> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          switch (widget.entityMinimal.type) {
            case "club":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) => ClubDetails(id: widget.entityMinimal.id)));
              break;
            case "organizer":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      OrganizerDetails(id: widget.entityMinimal.id)));
              break;
            case "artist":
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      ArtistDetails(id: widget.entityMinimal.id)));
              break;

            default:
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      OrganizerDetails(id: widget.entityMinimal.id)));
              break;
          }
        },
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                      color: Colors.black.withOpacity(0.2))
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                      image: DecorationImage(
                          image: NetworkImage(widget.entityMinimal.image))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(widget.entityMinimal.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold))),
                    Container(
                        child: Text(widget.entityMinimal.type,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[500])))
                  ],
                )
              ],
            )));
  }
}
