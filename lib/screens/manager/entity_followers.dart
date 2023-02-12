import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/edit_profile.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_follow.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_suggested_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntityFollowers extends StatefulWidget {
  ObjectId entityId;
  EntityFollowers({Key? key, required this.entityId});

  @override
  State<EntityFollowers> createState() => _EntityFollowersState();
}

class _EntityFollowersState extends State<EntityFollowers> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getEntityFollowers(widget.entityId);
    followersScrollController = ScrollController()
      ..addListener(() {
        eventScrollListener();
      });
  }

  void eventScrollListener() {
    if (followersScrollController.position.extentAfter == 0) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.getMoreEntityFollowers(widget.entityId);
    }
  }

  late ScrollController followersScrollController;
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
            child: Text("Followers",
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
                    controller: followersScrollController,
                    itemCount: userProvider.entityFollowers.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidetSuggestedUser(
                          followable: false,
                          myUserId: userProvider.user.id,
                          userMinimal: userProvider.entityFollowers[index]);
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
