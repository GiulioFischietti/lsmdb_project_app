import 'package:project_app/Model/ShowcaseArtistsModel.dart';
import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/Model/ShowcaseOrganizersModel.dart';
import 'package:project_app/View/Items/ClubV.dart';
import 'package:project_app/View/Items/OrganizerV.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

import 'ArtistV.dart';

class ShowcaseArtists extends StatefulWidget {
  ShowcaseArtistsModel data;

  ShowcaseArtists({this.data});
  @override
  _ShowcaseArtiststate createState() => _ShowcaseArtiststate();
}

class _ShowcaseArtiststate extends State<ShowcaseArtists> {
  @override
  Widget build(BuildContext context) {
    return new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          margin: EdgeInsets.only(bottom: 0, left: 20, top: 30),
          child: Text(widget.data.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500))),
      Container(
          height: 250,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.artists.length,
            itemBuilder: (context, index) {
              return ArtistV(widget.data.artists[index]);
            },
          ))
    ]);
  }
}
