import 'package:eventi_in_zona/screens/user/select_genre.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_entity_result.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';

class TopRated extends StatefulWidget {
  TopRated({Key? key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late ScrollController entityScrollController;
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    homeProvider.getTopRatedEntities(context);

    entityScrollController = ScrollController()
      ..addListener(() {
        entityScrollListener();
      });
  }

  void entityScrollListener() {
    // print(entityScrollController.position.extentAfter);
    if (entityScrollController.position.extentAfter == 0) {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);

      homeProvider.getMoreTopRatedEntities(context);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, HomeProvider>(
        builder: (context, userProvider, homeProvider, _) {
      return Scaffold(
          key: _scaffoldKey,
          body: Container(
              child: SafeArea(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
                  alignment: Alignment.centerLeft,
                  child: Text("Top Rated",
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1),
                ),
                Expanded(
                  child: Container(
                      margin: EdgeInsets.only(top: 40),
                      child: homeProvider.topRatedEntities.isNotEmpty
                          ? ListView.builder(
                              controller: entityScrollController,
                              shrinkWrap: true,
                              itemCount: homeProvider.topRatedEntities.length,
                              itemBuilder: (BuildContext context, int index) {
                                return (CardWidgetEntityResult(
                                    entity:
                                        homeProvider.topRatedEntities[index]));
                              },
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Text(
                                "Nessun risultato",
                                style: GoogleFonts.poppins(),
                              ))),
                ),
                homeProvider.loadingTopRatedEntitiesPagination
                    ? Container(
                        margin: EdgeInsets.all(20),
                        child: CircularProgressIndicator())
                    : Container()
              ]))));
    });
  }
}
