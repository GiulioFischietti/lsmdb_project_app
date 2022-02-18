import 'package:project_app/Model/ClubVModel.dart';
import 'package:project_app/View/Entities/Club.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// ignore_for_file: file_names

class ClubV extends StatefulWidget {
  ClubVModel clubV;
  ClubV(this.clubV, {Key key});

  @override
  _ClubVState createState() => _ClubVState();
}

class _ClubVState extends State<ClubV> {
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
                    builder: (context) => Club(
                        id: widget.clubV.id,
                        image: widget.clubV.image,
                        name: widget.clubV.name,
                        slug: widget.clubV.id,
                        tag: "clubimage" + widget.clubV.id.toString())));
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
                          image: NetworkImage(widget.clubV.image)))),
              Container(
                  child: RatingBar.builder(
                initialRating: widget.clubV.rating,
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
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(widget.clubV.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Color(0xFFcccccc), fontSize: 18))),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 5, bottom: 1.5),
                          child: Icon(Icons.room_outlined,
                              color: Color(0xFF999999), size: 13)),
                      Container(
                          child: Text(widget.clubV.place,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Color(0xFF999999), fontSize: 13)))
                    ],
                  ))
            ],
          )),
      width: 150,
    );
  }
}
