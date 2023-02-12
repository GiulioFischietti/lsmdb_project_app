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

class Friends extends StatefulWidget {
  Friends({Key? key});

  @override
  State<Friends> createState() => _FriendsState();
}

class _FriendsState extends State<Friends> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getSuggestedFriendsBasedOnLikes();
  }

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
            child: Text("Friends",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 10, left: 20, bottom: 20, right: 20),
            alignment: Alignment.centerLeft,
            child: Text("Friends suggestions based on common music tastes.",
                textScaleFactor: 1,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyText1),
          ),
          userProvider.loading
              ? Expanded(
                  child: Container(
                      child: Center(child: CircularProgressIndicator())))
              : Expanded(
                  child: ListView.builder(
                    itemCount: userProvider.suggestedFriends.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidetSuggestedUser(
                          myUserId: userProvider.user.id,
                          followable: true,
                          userMinimal: userProvider.suggestedFriends[index]);
                    },
                  ),
                )
        ],
      );
    })));
  }
}
