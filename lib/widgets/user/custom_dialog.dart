import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CustomDialog extends StatelessWidget {
  final Icon icon;
  final String message;
  final String cancelMessage;
  final VoidCallback onCancelButtonPress;
  final String exitMessage;
  final VoidCallback onExitButtonPress;
  final bool cancelable;

  CustomDialog(
      {required this.icon,
      required this.cancelable,
      required this.message,
      required this.exitMessage,
      required this.cancelMessage,
      required this.onCancelButtonPress,
      required this.onExitButtonPress});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)), //this right here
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(this.message,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black))),
                Container(
                  margin: EdgeInsets.all(20),
                  child: this.icon,
                ),
                Row(
                  mainAxisAlignment: cancelable
                      ? MainAxisAlignment.spaceEvenly
                      : MainAxisAlignment.center,
                  children: [
                    cancelable
                        ? Expanded(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: InkWell(
                                  onTap: () async {
                                    this.onCancelButtonPress();
                                  },
                                  child: Text(
                                    this.cancelMessage,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white)),
                                  ),
                                )))
                        : Container(),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: InkWell(
                              onTap: () async {
                                this.onExitButtonPress();
                              },
                              child: Text(
                                this.exitMessage,
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                              ),
                            ))),
                  ],
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
