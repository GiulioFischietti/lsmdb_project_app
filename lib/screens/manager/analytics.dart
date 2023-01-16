import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/manager/customer_analytics.dart';
import 'package:eventi_in_zona/screens/manager/edit_profile.dart';
import 'package:eventi_in_zona/screens/manager/expences_analytics.dart';
import 'package:eventi_in_zona/screens/manager/product_analytics.dart';
import 'package:eventi_in_zona/screens/user/orders.dart';
import 'package:provider/provider.dart';

class Analytics extends StatefulWidget {
  const Analytics({Key? key});

  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(child:
        Consumer<ManagerProvider>(builder: (context, managerProvider, _) {
      return Column(children: [
        Container(
          margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text("Analytics",
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ProductAnalytics()));
                    },
                    child: Container(
                        height: size.width / 2 - 20,
                        // width: size.width / 2 - 20,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: size.width / 2 - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(Icons.task_outlined,
                                      color: Colors.grey)),
                            ),
                            Container(
                                margin: EdgeInsets.all(20),
                                child: Text("Product Analytics",
                                    style: GoogleFonts.poppins(fontSize: 12)))
                          ],
                        )))),
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => CustomerAnalytics()));
                    },
                    child: Container(
                        height: size.width / 2 - 20,
                        // width: size.width / 2 - 20,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: size.width / 2 - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(Icons.person_outline,
                                      color: Colors.grey)),
                            ),
                            Container(
                                margin: const EdgeInsets.all(20),
                                child: Text("Customer Analytics",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 12)))
                          ],
                        )))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ExpencesAnalytics()));
                    },
                    child: Container(
                        height: size.width / 2 - 20,
                        // width: size.width / 2 - 20,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: size.width / 2 - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(Icons.money, color: Colors.grey)),
                            ),
                            Container(
                                margin: EdgeInsets.all(20),
                                child: Text("Expences Analytics",
                                    style: GoogleFonts.poppins(fontSize: 12)))
                          ],
                        )))),
            Expanded(
                child: InkWell(
                    child: Container(
                        height: size.width / 2 - 20,
                        // width: size.width / 2 - 20,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: size.width / 2 - 50,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(Icons.person_outline,
                                      color: Colors.transparent)),
                            ),
                            Container(
                                margin: EdgeInsets.all(20),
                                child: Text("",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(fontSize: 12)))
                          ],
                        )))),
          ],
        )
      ]);
    })));
  }
}
