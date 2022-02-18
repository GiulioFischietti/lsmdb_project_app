import 'package:project_app/Model/NotificationVModel.dart';
import 'package:flutter/material.dart';
// ignore_for_file: file_names

class NotificationV extends StatefulWidget {
  NotificationVModel notification;
  bool selected = false;
  Animation<double> animation;
  NotificationV({Key key, this.notification, this.animation, this.selected})
      : super(key: key);

  @override
  _NotificationVState createState() => _NotificationVState();
}

class _NotificationVState extends State<NotificationV> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizeTransition(
        axis: Axis.vertical,
        sizeFactor: widget.animation,
        child: Container(
            margin: EdgeInsets.all(20),
            child: Row(children: [
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    image: DecorationImage(
                        image: NetworkImage(widget.notification.image_sender))),
              ),
              Flexible(
                  child: InkWell(
                      child: Container(
                margin: EdgeInsets.only(left: 10),
                child: RichText(
                  maxLines: 4,
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: widget.notification.name_sender + ' ',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFFf9b701),
                              fontWeight: FontWeight.w700)),
                      TextSpan(
                          text: widget.notification.text_notification,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ))),
              widget.notification.image_notification != ""
                  ? Container(
                      height: 40,
                      width: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                  widget.notification.image_notification))))
                  : Container(),
            ])));
  }
}
