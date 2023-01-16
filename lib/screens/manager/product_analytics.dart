import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:provider/provider.dart';

class ProductAnalytics extends StatefulWidget {
  const ProductAnalytics({Key? key});

  @override
  State<ProductAnalytics> createState() => _ProductAnalyticsState();
}

class _ProductAnalyticsState extends State<ProductAnalytics> {
  List<dynamic> orderoptions = [
    {"name": 'Most Selling', "selected": true, "sorting": "desc"},
    {"name": 'Least Selling', "selected": false, "sorting": "asc"}
  ];
  List<dynamic> timeoptions = [
    {
      "name": 'Last 30 Days',
      "start_date": DateTime.now().subtract(const Duration(days: 30)),
      "selected": true
    },
    {
      "name": 'Last 60 Days',
      "start_date": DateTime.now().subtract(const Duration(days: 60)),
      "selected": false
    },
    {
      "name": 'Last 120 Days',
      "start_date": DateTime.now().subtract(const Duration(days: 120)),
      "selected": false
    },
  ];
  @override
  void initState() {
    super.initState();
    final managerProvider =
        Provider.of<ManagerProvider>(context, listen: false);
    managerProvider.getProductAnalytics(
        startDate: DateTime.now().subtract(const Duration(days: 30)),
        endDate: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child:
        Consumer<ManagerProvider>(builder: (context, managerProvider, _) {
      return ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 0),
            alignment: Alignment.centerLeft,
            child: Text("Product\nAnalytics",
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline1),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 40),
            alignment: Alignment.centerLeft,
            child: Text("Product ranking based on sold quantity",
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(fontSize: 13)),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: InkWell(
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
                                                      .indexWhere((element) =>
                                                          element['selected'] ==
                                                          true)]['selected'] =
                                                  false;
                                              timeoptions[index]['selected'] =
                                                  true;
                                            });
                                            modalSetState(() {
                                              timeoptions[index]['selected'] =
                                                  true;
                                            });
                                            managerProvider.getProductAnalytics(
                                                startDate: timeoptions
                                                    .where((element) =>
                                                        element['selected'])
                                                    .first['start_date'],
                                                endDate: DateTime.now(),
                                                sorting: orderoptions
                                                    .where((element) =>
                                                        element['selected'])
                                                    .first['sorting']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.all(20),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: Icon(Icons.check,
                                                          color: timeoptions[
                                                                      index]
                                                                  ['selected']
                                                              ? Colors.orange
                                                              : Colors
                                                                  .transparent)),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                          timeoptions[index]
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
                                      .where((element) => element['selected'])
                                      .first['name'],
                                  style:
                                      GoogleFonts.poppins(color: Colors.black)))
                        ]))),
            Expanded(
                child: InkWell(
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
                                      orderoptions.length,
                                      (index) => InkWell(
                                          onTap: () {
                                            setState(() {
                                              orderoptions[orderoptions
                                                      .indexWhere((element) =>
                                                          element['selected'] ==
                                                          true)]['selected'] =
                                                  false;
                                              orderoptions[index]['selected'] =
                                                  true;
                                            });
                                            modalSetState(() {
                                              orderoptions[index]['selected'] =
                                                  true;
                                            });
                                            managerProvider.getProductAnalytics(
                                                startDate: timeoptions
                                                    .where((element) =>
                                                        element['selected'])
                                                    .first['start_date'],
                                                endDate: DateTime.now(),
                                                sorting: orderoptions
                                                    .where((element) =>
                                                        element['selected'])
                                                    .first['sorting']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              margin: EdgeInsets.all(20),
                                              child: Row(
                                                children: [
                                                  Container(
                                                      child: Icon(Icons.check,
                                                          color: orderoptions[
                                                                      index]
                                                                  ['selected']
                                                              ? Colors.orange
                                                              : Colors
                                                                  .transparent)),
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                          orderoptions[index]
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
                          Container(child: Icon(Icons.sort)),
                          Container(
                              margin: EdgeInsets.only(right: 20),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7.5),
                              child: Text(
                                  orderoptions
                                      .where((element) => element['selected'])
                                      .first['name'],
                                  style:
                                      GoogleFonts.poppins(color: Colors.black)))
                        ])))
          ]),
          Container(
            margin: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Beers",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 16)),
          ),
          ListView.builder(
            itemCount: managerProvider.beerAnalytics.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  height: 50,
                                  width: 50,
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, top: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(80),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(managerProvider
                                              .beerAnalytics[index].image)))),
                            ]),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  managerProvider.beerAnalytics[index].name,
                                  style: GoogleFonts.poppins()),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: managerProvider
                                        .beerAnalytics[index].count,
                                    child: Container(
                                      height: 20,
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    )),
                                Expanded(
                                  flex: managerProvider.totalBeers -
                                      managerProvider
                                          .beerAnalytics[index].count,
                                  child: Container(
                                    height: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 10, right: 10, left: 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                      managerProvider.beerAnalytics[index].count
                                          .toString(),
                                      style: GoogleFonts.poppins(fontSize: 12)),
                                ),
                              ],
                            )
                          ],
                        )),
                      ]));
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Books",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 16)),
          ),
          ListView.builder(
            itemCount: managerProvider.bookAnalytics.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                      borderRadius: BorderRadius.circular(80),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(managerProvider
                                              .bookAnalytics[index].image)))),
                            ]),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  managerProvider.bookAnalytics[index].name,
                                  style: GoogleFonts.poppins()),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: managerProvider
                                        .bookAnalytics[index].count,
                                    child: Container(
                                      height: 20,
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    )),
                                Expanded(
                                  flex: managerProvider.totalBooks -
                                      managerProvider
                                          .bookAnalytics[index].count,
                                  child: Container(
                                    height: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 10, right: 10, left: 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                      managerProvider.beerAnalytics[index].count
                                          .toString(),
                                      style: GoogleFonts.poppins(fontSize: 12)),
                                ),
                              ],
                            )
                          ],
                        )),
                      ]));
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Monitors",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 16)),
          ),
          ListView.builder(
            itemCount: managerProvider.monitorAnalytics.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                      borderRadius: BorderRadius.circular(80),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(managerProvider
                                              .monitorAnalytics[index]
                                              .image)))),
                            ]),
                        Expanded(
                            child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  managerProvider.monitorAnalytics[index].name,
                                  style: GoogleFonts.poppins()),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: managerProvider
                                        .monitorAnalytics[index].count,
                                    child: Container(
                                      height: 20,
                                      decoration:
                                          BoxDecoration(color: Colors.grey),
                                    )),
                                Expanded(
                                  flex: managerProvider.totalMonitors -
                                      managerProvider
                                          .monitorAnalytics[index].count,
                                  child: Container(
                                    height: 20,
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      bottom: 10, top: 10, right: 10, left: 20),
                                  alignment: Alignment.center,
                                  child: Text(
                                      managerProvider
                                          .monitorAnalytics[index].count
                                          .toString(),
                                      style: GoogleFonts.poppins(fontSize: 12)),
                                ),
                              ],
                            )
                          ],
                        )),
                      ]));
            },
          ),
        ],
      );
    })));
  }
}
