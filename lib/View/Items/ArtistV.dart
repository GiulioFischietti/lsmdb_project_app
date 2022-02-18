import 'package:project_app/Model/artistVModel.dart';
import 'package:project_app/Model/OrganizerVModel.dart';
import 'package:project_app/View/Entities/Artist.dart';
import 'package:project_app/View/Entities/Organizer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ignore_for_file: file_names

class ArtistV extends StatefulWidget {
  ArtistVModel artistV;
  ArtistV(this.artistV, {Key key});

  @override
  _ArtistVState createState() => _ArtistVState();
}

class _ArtistVState extends State<ArtistV> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(0xFF444444),
      ),
      child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Artist(
                        id: widget.artistV.id,
                        image: widget.artistV.image,
                        name: widget.artistV.name,
                        slug: widget.artistV.id,
                        tag: "artistimage" + widget.artistV.id.toString())));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.artistV.image)))),
              Container(
                  margin: EdgeInsets.only(top: 2.5),
                  child: RatingBar.builder(
                    initialRating: widget.artistV.rating,
                    minRating: 1,
                    itemSize: 18,
                    direction: Axis.horizontal,
                    wrapAlignment: WrapAlignment.center,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.5),
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (double value) {},
                  )),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Text(widget.artistV.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xFFcccccc), fontSize: 18))),
            ],
          )),
      width: 150,
    );
  }
}
