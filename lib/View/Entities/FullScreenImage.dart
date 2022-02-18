import 'package:flutter/material.dart';
// ignore_for_file: file_names

class FullScreenImage extends StatelessWidget {
  String image;
  String tag;
  FullScreenImage({this.image, this.tag});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        color: Color(0xFF222222),
        height: size.height,
        width: size.width,
        child: InteractiveViewer(
            child: Hero(
                transitionOnUserGestures: true,
                tag: this.tag,
                child: Image(image: NetworkImage(this.image)))));
  }
}
