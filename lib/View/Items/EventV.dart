import 'package:project_app/Model/EventVModel.dart';
import 'package:project_app/View/Entities/Club.dart';
import 'package:project_app/View/Entities/Event.dart';
import 'package:project_app/View/Entities/Organizer.dart';
import 'package:project_app/View/Entities/Event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore_for_file: file_names

class EventV extends StatefulWidget {
  EventVModel eventV;
  int index;

  EventV({this.eventV, this.index});
  @override
  _EventVState createState() => _EventVState();
}

class _EventVState extends State<EventV> with SingleTickerProviderStateMixin {
  List<String> month = [
    "Gen",
    "Feb",
    "Mar",
    "Apr",
    "Mag",
    "Giu",
    "Lug",
    "Ago",
    "Set",
    "Ott",
    "Nov",
    "Dic"
  ];

  @override
  Widget build(BuildContext context) {
    return (Container(
        decoration: BoxDecoration(
          color: Color(0xFF222222),
          borderRadius: BorderRadius.circular(10),
        ),
        width: 220,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.all(0),
              backgroundColor: Color(0xFF222222),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20))),
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => Event(
            //             id: widget.eventV.id,
            //             image: widget.eventV.image,
            //             name: widget.eventV.name,
            //             slug: widget.eventV.slug,
            //             tag: "eventimage" + widget.index.toString())));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Event(
                        id: widget.eventV.id,
                        image: widget.eventV.image,
                        name: widget.eventV.name,
                        slug: widget.eventV.slug,
                        tag: "eventimage" + widget.index.toString())));
          },
          child: Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Stack(children: [
                    (Container(
                        color: Theme.of(context).primaryColor,
                        child: Hero(
                          tag: 'eventimage' + widget.eventV.id.toString(),
                          child: Image(
                            height: 110,
                            width: 220,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Container(
                                  color: Colors.grey[800],
                                  width: 220,
                                  height: 110);
                            },
                            image: NetworkImage(
                              widget.eventV.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ))),
                    Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                  widget.eventV.start.day.toString() +
                                      ' ' +
                                      month[widget.eventV.start.month - 1],
                                  style: TextStyle(
                                      color: _getColor(widget.eventV.start,
                                          widget.eventV.end)))),
                          decoration: BoxDecoration(
                              color: Color(0xcc222222),
                              borderRadius: BorderRadius.circular(5)),
                        )),
                    Positioned(
                      bottom: 0,
                      left: 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              // style: OutlinedButton.styleFrom(),
                              onPressed: () {
                                if (widget.eventV.organizer.type == "club") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Club(
                                              id: widget.eventV.organizer.id
                                                  .toString(),
                                              image:
                                                  widget.eventV.organizer.image,
                                              name:
                                                  widget.eventV.organizer.name,
                                              slug: widget.eventV.organizer.id
                                                  .toString(),
                                              tag: "clubimage" +
                                                  widget.eventV.organizer.id
                                                      .toString())));
                                } else if (widget.eventV.organizer.type ==
                                    "organizer") {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Organizer(
                                              id: widget.eventV.id,
                                              image:
                                                  widget.eventV.organizer.image,
                                              name:
                                                  widget.eventV.organizer.name,
                                              slug: widget.eventV.organizer.id,
                                              tag: "clubimage" +
                                                  widget.eventV.organizer.id
                                                      .toString())));
                                }
                              },
                              icon: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            widget.eventV.organizer.image))),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              child: Text(widget.eventV.organizer.name,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16)))
                        ],
                      ),
                    )
                  ]),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: Text(widget.eventV.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 20))),
                  Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 10, bottom: 5, top: 2.5),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 4),
                              child: (Icon(Icons.place_outlined,
                                  color: Colors.white, size: 11))),
                          Flexible(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.eventV.place,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w400),
                                  ))),
                        ],
                      )),
                  Container(
                      margin: EdgeInsets.only(
                          left: 15, right: 10, top: 2.5, bottom: 0),
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 4),
                              child: (Icon(Icons.music_note_outlined,
                                  color: Colors.grey[400], size: 11))),
                          Flexible(
                              child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    widget.eventV.musicalGenre ??
                                        "Non specificato",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey[400],
                                        fontWeight: FontWeight.w400),
                                  ))),
                        ],
                      )),
                ],
              )),
        )));
  }

  Color _getColor(DateTime start, DateTime end) {
    if (DateTime.now().isAfter(end)) {
      return Colors.red[500];
    } else {
      if (DateTime.now().isBefore(end) && DateTime.now().isAfter(start)) {
        return Colors.yellow[600];
      } else if (DateTime.now().isBefore(start)) {
        return Colors.green[500];
      }
    }
  }
}
