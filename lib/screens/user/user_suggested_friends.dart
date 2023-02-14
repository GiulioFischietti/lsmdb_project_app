import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/edit_profile.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_follow.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_minimal_follower.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSuggestedFriends extends StatefulWidget {
  ObjectId userId;
  UserSuggestedFriends({Key? key, required this.userId});

  @override
  State<UserSuggestedFriends> createState() => _UserSuggestedFriendsState();
}

class _UserSuggestedFriendsState extends State<UserSuggestedFriends> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getSuggestedFriendsOfUser();
    followingsScrollController = ScrollController()
      ..addListener(() {
        eventScrollListener();
      });
  }

  void eventScrollListener() {
    if (followingsScrollController.position.extentAfter == 0) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      userProvider.getSuggestedFriendsOfUser();
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
            child: Text("People You May Know",
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
                    itemCount: userProvider.suggestedFriendsOfUser.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidetMinimalFollower(
                        followable: true,
                        myUserId: userProvider.user.id,
                        entityMinimal:
                            userProvider.suggestedFriendsOfUser[index],
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
