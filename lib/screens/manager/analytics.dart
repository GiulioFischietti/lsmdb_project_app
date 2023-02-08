import 'package:eventi_in_zona/models/critic_user.dart';
import 'package:eventi_in_zona/providers/analytics_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/manager/critic_users.dart';
import 'package:eventi_in_zona/screens/manager/most_used_words.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final analyticsProvider =
        Provider.of<AnalyticsProvider>(context, listen: false);
    analyticsProvider
        .getEntityRateByYear(userProvider.manager.managedEntity.id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return ListView(shrinkWrap: true, children: [
      Container(
        margin: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
        alignment: Alignment.centerLeft,
        child: Text("Dashboard",
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1),
      ),
      Consumer<AnalyticsProvider>(builder: (context, analyticsProvider, _) {
        return Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Rate by year",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 18),
                )),
            Container(
                height: 250,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: analyticsProvider.yearRates
                      .map((e) => Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.bottomCenter,
                                height: 50 * e.avg,
                                width: 50,
                                decoration: BoxDecoration(color: Colors.blue),
                              ),
                              Container(
                                  child: Text(e.year.toString(),
                                      style: GoogleFonts.poppins()))
                            ],
                          ))
                      .toList(),
                )),
            DataTable(
                columns: [
                  DataColumn(
                    label: Text('Year'),
                  ),
                  DataColumn(
                    label: Text('Count'),
                  ),
                  DataColumn(
                    label: Text('Rate'),
                  )
                ],
                rows: analyticsProvider.yearRates
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.year.toString())),
                          DataCell(Text(e.count.toString())),
                          DataCell(Text(e.avg.toStringAsFixed(2))),
                        ]))
                    .toList())
          ],
        );
      }),
      Container(
          margin: EdgeInsets.only(left: 20, bottom: 10, top: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "More Analytics",
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
          )),
      profileTile("What people say about your club", Icons.comment_outlined,
          () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MostUsedWords()));
      }),
      profileTile("Critic Users", Icons.person_remove, () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => CriticUsers()));
      })
    ]);
  }
}

Widget profileTile(String label, IconData icon, Function onTap) {
  return InkWell(
      onTap: () => onTap(),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Icon(icon)),
          Expanded(
            child: Container(
                // margin: EdgeInsets.all(20),
                child: Text(label, style: GoogleFonts.poppins(fontSize: 16))),
          ),
          Container(
              margin: EdgeInsets.all(20),
              child: Icon(Icons.arrow_forward_ios, size: 16)),
        ],
      ));
}
