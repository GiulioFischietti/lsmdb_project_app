import 'package:eventi_in_zona/providers/analytics_provider.dart';
import 'package:eventi_in_zona/screens/manager/analytics.dart';
import 'package:eventi_in_zona/screens/user/select_genre.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity_result.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity_stats.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ClubGenresStats extends StatefulWidget {
  ClubGenresStats({Key? key});

  @override
  State<ClubGenresStats> createState() => _ClubGenresStatsState();
}

class _ClubGenresStatsState extends State<ClubGenresStats> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<AnalyticsProvider>(context, listen: false);

    homeProvider.getClubsStats();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer2<UserProvider, AnalyticsProvider>(
        builder: (context, userProvider, homeProvider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: Container(
              child: SafeArea(
                  child: homeProvider.loading
                      ? Container(
                          height: size.height,
                          child: Center(child: CircularProgressIndicator()))
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, bottom: 0),
                                alignment: Alignment.centerLeft,
                                child: Text("Event Stats",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline1),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, bottom: 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    "Clubs that host the highest variety of event genres",
                                    textScaleFactor: 1,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins()),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(top: 40),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: homeProvider.clubStats.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return (CardWidgetEntityStats(
                                            entity:
                                                homeProvider.clubStats[index]));
                                      },
                                    )),
                              ),
                              homeProvider.loadingClubStatsPagination
                                  ? Container(
                                      margin: EdgeInsets.all(20),
                                      child: CircularProgressIndicator())
                                  : Container()
                            ]))));
    });
  }
}
