import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTileWidget extends StatefulWidget {
  MenuTileWidget(
      {Key? key, required this.onTap, required this.label, required this.icon})
      : super(key: key);

  Function onTap;
  Icon icon;
  String label;

  @override
  _MenuTileWidgetState createState() => _MenuTileWidgetState();
}

class _MenuTileWidgetState extends State<MenuTileWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(children: [
        Container(margin: EdgeInsets.only(right: 20), child: widget.icon),
        Text(widget.label,
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black)))
      ]),
      onTap: () async {
        widget.onTap();
      },
    );
  }
}
