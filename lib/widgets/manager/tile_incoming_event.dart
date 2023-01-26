// ignore: must_be_immutable
import 'package:eventi_in_zona/models/event_minimal.dart';
import 'package:eventi_in_zona/screens/manager/event_details.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/screens/manager/order_details.dart';

class TileIncomingEvent extends StatefulWidget {
  EventMinimal eventMinimal;
  TileIncomingEvent({Key? key, required this.eventMinimal // this.heroTag,
      /*this.preferiti*/
      })
      : super(key: key);

  @override
  _TileIncomingEventState createState() => _TileIncomingEventState();
}

class _TileIncomingEventState extends State<TileIncomingEvent> {
  bool favorite = false;
  bool added = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // widget._con = ProductController();
    // widget._con.product = widget.activity;
    return Container(
        decoration: BoxDecoration(
            boxShadow: [],
            border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(children: [
          Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.eventMinimal.image)))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => EventDetails(
                              id: widget.eventMinimal.id,
                            )));
                  },
                  child: Column(
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            widget.eventMinimal.name,
                            style: GoogleFonts.poppins(),
                          )),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${widget.eventMinimal.start.day} ${months[widget.eventMinimal.start.month]} ${widget.eventMinimal.start.year}',
                            style: GoogleFonts.poppins(
                                color: widget.eventMinimal.start
                                        .isAfter(DateTime.now())
                                    ? Colors.green
                                    : Colors.red),
                          ))
                    ],
                  ))),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              widget.eventMinimal.start.isAfter(DateTime.now())
                  ? "Incoming"
                  : "Past",
              style: GoogleFonts.poppins()
                  .copyWith(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(7.5),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[500],
              size: 16,
            ),
          )
        ]));
  }
}
