import 'package:project_app/Model/ShowcaseClubsModel.dart';
import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/View/Items/ClubV.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

class ShowcaseClubs extends StatefulWidget {
  ShowcaseClubModel data;

  ShowcaseClubs({this.data});
  @override
  _ShowcaseClubstate createState() => _ShowcaseClubstate();
}

class _ShowcaseClubstate extends State<ShowcaseClubs> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 275,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.clubs.length,
            itemBuilder: (context, index) {
              return ClubV(widget.data.clubs[index]);
            },
          ))
    ]);
  }
}
