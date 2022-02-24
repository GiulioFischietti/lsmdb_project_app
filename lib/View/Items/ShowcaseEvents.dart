import 'package:project_app/Model/ShowcaseEventsModel.dart';
import 'package:project_app/View/Items/EventV.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

class ShowcaseEvents extends StatefulWidget {
  ShowcaseEventsModel data;

  ShowcaseEvents({this.data});
  @override
  _ShowcaseEventState createState() => _ShowcaseEventState();
}

class _ShowcaseEventState extends State<ShowcaseEvents> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          height: 190,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.data.events.length,
            itemBuilder: (context, index) {
              return EventV(
                index: index,
                eventV: widget.data.events[index],
              );
            },
          ))
    ]);
  }
}
