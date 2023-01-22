import 'package:eventi_in_zona/screens/user/search_results.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class SelectWhen extends StatefulWidget {
  final String? type;
  final String? type_name;
  final List<String?>? services;
  final List<double>? prices;
  final List<String?>? servicesNames;

  const SelectWhen(
      {this.type,
      this.prices,
      this.services,
      this.type_name,
      this.servicesNames});

  @override
  _SelectWhenState createState() => _SelectWhenState();
}

DateTime? selectedDate;

class _SelectWhenState extends State<SelectWhen> {
  @override
  void initState() {
    // TODO: implement initState
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
              width: size.width,
              height: size.height,
              child: SafeArea(
                child: Container(
                  height: size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(
                            left: 20, top: 20, bottom: 20, right: 20),
                        child: Text('When?',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black))),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        child: InkWell(
                          child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.calendar_today,
                                          color: Colors.transparent)),
                                  Expanded(
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                              ((selectedDate!.month ==
                                                          new DateTime.now()
                                                              .month) &&
                                                      (selectedDate!.day ==
                                                          new DateTime.now()
                                                              .day) &&
                                                      (selectedDate!.year ==
                                                          new DateTime.now()
                                                              .year))
                                                  ? "Today"
                                                  : ((selectedDate!.month ==
                                                              new DateTime.now()
                                                                  .month) &&
                                                          (selectedDate!.day ==
                                                              new DateTime.now()
                                                                      .day +
                                                                  1) &&
                                                          (selectedDate!.year ==
                                                              new DateTime.now()
                                                                  .year))
                                                      ? "Tomorrow"
                                                      : selectedDate!.day
                                                              .toString() +
                                                          ' ' +
                                                          months[selectedDate!
                                                              .month] +
                                                          ' ' +
                                                          selectedDate!.year
                                                              .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.grey[850]))))),
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.calendar_today))
                                ],
                              )),
                          onTap: () async {
                            selectedDate = await showDatePicker(
                              cancelText: 'Annulla',
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2025),
                            );
                            if (selectedDate != null) {
                              setState(() {});
                            } else {
                              selectedDate = new DateTime.now();
                            }
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: InkWell(
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 7,
                                      color: Colors.grey.withOpacity(0.2))
                                ],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: Icon(Icons.arrow_forward,
                                          color: Colors.transparent)),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text('Show results',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white))))),
                                ],
                              )),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => SearchResults()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
