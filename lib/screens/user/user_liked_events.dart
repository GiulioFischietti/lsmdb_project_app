import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/edit_profile.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLikedEvents extends StatefulWidget {
  ObjectId userId;
  UserLikedEvents({Key? key, required this.userId});

  @override
  State<UserLikedEvents> createState() => _UserLikedEventsState();
}

class _UserLikedEventsState extends State<UserLikedEvents> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getLikedEvents(widget.userId);
    followingsScrollController = ScrollController()
      ..addListener(() {
        eventScrollListener();
      });
  }

  void eventScrollListener() {
    if (followingsScrollController.position.extentAfter == 0) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.getMoreLikedEvents(widget.userId);
    }
  }

  late ScrollController followingsScrollController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(body: SafeArea(
        child: Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 0),
            alignment: Alignment.centerLeft,
            child: Text("Liked Events",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
          ),
          userProvider.loading
              ? Expanded(
                  child: Container(
                      child: Center(child: CircularProgressIndicator())))
              : Expanded(
                  child: ListView.builder(
                    controller: followingsScrollController,
                    itemCount: userProvider.likedEvents.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidgetEventMinimal(
                        eventMinimal: userProvider.likedEvents[index],
                      );
                    },
                  ),
                ),
          userProvider.loadingMoreFollowers
              ? CircularProgressIndicator()
              : Container()
        ],
      );
    })));
  }
}
