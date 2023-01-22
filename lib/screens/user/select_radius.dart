import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/select_when.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class SelectRadius extends StatefulWidget {
  const SelectRadius({
    super.key,
  });

  @override
  _SelectRadiusState createState() => _SelectRadiusState();
}

class _SelectRadiusState extends State<SelectRadius> {
  @override
  void initState() {}
  double distance = 50;
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
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                                left: 20, top: 20, bottom: 20, right: 20),
                            child: Text('Max Distance?',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black))),
                          ),
                          Expanded(child: Container()),
                          Container(
                              margin: EdgeInsets.only(top: 20, bottom: 20),
                              child: SfSlider(
                                activeColor: Colors.orange,
                                inactiveColor: Colors.white.withOpacity(0.8),
                                min: 0.0,
                                max: 100.0,
                                value: distance,
                                interval: 25,
                                showTicks: false,
                                showLabels: true,
                                enableTooltip: true,
                                minorTicksPerInterval: 0,
                                onChanged: (dynamic values) {
                                  setState(() {
                                    distance = values;
                                  });
                                },
                              )),
                          InkWell(
                              onTap: () {
                                final eventProvider =
                                    Provider.of<EventProvider>(context,
                                        listen: false);
                                eventProvider.maxDistance = distance;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => SelectWhen()));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.centerRight,
                                      child: const Icon(Icons.calendar_today,
                                          color: Colors.transparent)),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.orange,
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              color:
                                                  Colors.grey.withOpacity(0.2))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 10),
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: Text('Next',
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white)))),
                                    ),
                                  ),
                                ],
                              )),
                          Expanded(child: Container()),
                        ]))))));
  }
}
