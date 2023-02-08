import 'dart:math';

import 'package:eventi_in_zona/providers/analytics_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CriticUsers extends StatefulWidget {
  CriticUsers({Key? key}) : super(key: key);

  @override
  _CriticUsersState createState() => _CriticUsersState();
}

class _CriticUsersState extends State<CriticUsers> {
  @override
  void initState() {
    super.initState();
    final analyticsProvider =
        Provider.of<AnalyticsProvider>(context, listen: false);
    analyticsProvider
        .getCriticScore(DateTime.now().subtract(const Duration(days: 180)));
  }

  List<dynamic> timeoptions = [
    {
      "name": 'Last 6 Months',
      "start_date": DateTime.now().subtract(const Duration(days: 180)),
      "selected": true
    },
    {
      "name": 'Last Year',
      "start_date": DateTime.now().subtract(const Duration(days: 365)),
      "selected": false
    },
    {
      "name": 'Last 2 Years',
      "start_date": DateTime.now().subtract(const Duration(days: 700)),
      "selected": false
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body:
        Consumer<AnalyticsProvider>(builder: (context, analyticsProvider, _) {
      return analyticsProvider.loading
          ? Container(
              height: size.height,
              width: size.width,
              child: Center(child: CircularProgressIndicator()))
          : Column(children: [
              Container(
                margin: const EdgeInsets.only(top: 70, left: 20, bottom: 0),
                alignment: Alignment.centerLeft,
                child: Text("Critic Users",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline1),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text("Users rank based on criticScore",
                    textScaleFactor: 1,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(fontSize: 13)),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 0, left: 20, bottom: 20),
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () async {
                              await showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder: (BuildContext
                                            context,
                                        StateSetter
                                            modalSetState /*You can rename this!*/) {
                                      return Wrap(
                                          children: List.generate(
                                              timeoptions.length,
                                              (index) => InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      timeoptions[timeoptions
                                                              .indexWhere(
                                                                  (element) =>
                                                                      element[
                                                                          'selected'] ==
                                                                      true)]
                                                          ['selected'] = false;
                                                      timeoptions[index]
                                                          ['selected'] = true;
                                                    });
                                                    modalSetState(() {
                                                      timeoptions[index]
                                                          ['selected'] = true;
                                                    });
                                                    analyticsProvider
                                                        .getCriticScore(timeoptions
                                                            .where((element) =>
                                                                element[
                                                                    'selected'])
                                                            .first['start_date']);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      margin:
                                                          EdgeInsets.all(20),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                              child: Icon(
                                                                  Icons.check,
                                                                  color: timeoptions[
                                                                              index]
                                                                          [
                                                                          'selected']
                                                                      ? Colors
                                                                          .orange
                                                                      : Colors
                                                                          .transparent)),
                                                          Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              child: Text(
                                                                  timeoptions[
                                                                          index]
                                                                      ['name'],
                                                                  style: GoogleFonts
                                                                      .poppins()))
                                                        ],
                                                      )))));
                                    });
                                  });
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(child: Icon(Icons.timelapse)),
                                  Container(
                                      margin: EdgeInsets.only(right: 20),
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 7.5),
                                      child: Text(
                                          timeoptions
                                              .where((element) =>
                                                  element['selected'])
                                              .first['name'],
                                          style: GoogleFonts.poppins(
                                              color: Colors.black)))
                                ])),
                      ])),
              Expanded(
                  child: ListView.builder(
                itemCount: analyticsProvider.criticUsers.length,
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      alignment: Alignment.center,
                                      height: 20,
                                      width: 20,
                                      margin: EdgeInsets.only(
                                          left: 20, right: 20, top: 5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(80),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  analyticsProvider
                                                      .criticUsers[index]
                                                      .userMinimal
                                                      .image)))),
                                ]),
                            Expanded(
                                child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      analyticsProvider.criticUsers[index]
                                          .userMinimal.username,
                                      style: GoogleFonts.poppins()),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        flex: -(analyticsProvider
                                                    .criticUsers[index]
                                                    .criticScore *
                                                10)
                                            .toInt(),
                                        child: Container(
                                          height: 20,
                                          decoration:
                                              BoxDecoration(color: Colors.grey),
                                        )),
                                    Expanded(
                                      flex: (-(analyticsProvider.criticUsers
                                                      .map((e) => e.criticScore)
                                                      .reduce(min) *
                                                  10)
                                              .toInt()) +
                                          (analyticsProvider.criticUsers[index]
                                                      .criticScore *
                                                  10)
                                              .toInt(),
                                      child: Container(
                                        height: 20,
                                        decoration:
                                            BoxDecoration(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 10,
                                          top: 10,
                                          right: 10,
                                          left: 20),
                                      alignment: Alignment.center,
                                      child: Text(
                                          analyticsProvider
                                              .criticUsers[index].criticScore
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 12)),
                                    ),
                                  ],
                                )
                              ],
                            )),
                          ]));
                },
              ))
            ]);
    }));
  }
}
