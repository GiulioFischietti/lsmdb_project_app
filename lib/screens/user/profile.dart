import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/edit_profile.dart';
import 'package:eventi_in_zona/screens/user/user_followers.dart';
import 'package:eventi_in_zona/screens/user/user_followings.dart';
import 'package:eventi_in_zona/screens/user/user_liked_events.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getAppUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Consumer<UserProvider>(builder: (context, userProvider, _) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Profile",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.14),
                          blurRadius: 7,
                          spreadRadius: 2)
                    ],
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: NetworkImage(userProvider.user.image),
                        fit: BoxFit.cover)),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.center,
                      child: Text(
                        userProvider.user.name,
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 0, top: 5),
                      child: Text(
                        "@" + userProvider.user.username,
                        style: GoogleFonts.poppins(color: Colors.grey),
                      ))
                ],
              ),
              Expanded(child: Container()),
              InkWell(
                  onTap: () async {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => EditProfile()));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange!)),
                      margin: const EdgeInsets.only(top: 30, right: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Text("Edit",
                          style: GoogleFonts.poppins(color: Colors.orange))))
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) =>
                                  UserFollowers(userId: userProvider.user.id)));
                        },
                        child: Column(
                          children: [
                            Text("${userProvider.user.nFollowers}",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("Followers",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey[600]))
                          ],
                        )),
                  ),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => UserFollowings(
                                    userId: userProvider.user.id)));
                          },
                          child: Column(
                            children: [
                              Text("${userProvider.user.nFollowings}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text("Followings",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[600]))
                            ],
                          ))),
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => UserLikedEvents(
                                    userId: userProvider.user.id)));
                          },
                          child: Column(
                            children: [
                              Text("${userProvider.user.nLikes}",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              Text("Liked Events",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey[600]))
                            ],
                          )))
                ],
              )),
          Container(height: 10),
          profileTile("Followers", Icons.person_outline, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) => UserFollowers(userId: userProvider.user.id)));
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (ctx) => Orders()));
          }),
          profileTile("Followings", Icons.person_outline, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    UserFollowings(userId: userProvider.user.id)));
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (ctx) => Orders()));
          }),
          profileTile("Favorite Events", Icons.bookmark_outline, () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx) =>
                    UserLikedEvents(userId: userProvider.user.id)));
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (ctx) => EditProfile()));
          }),
          Expanded(child: Container()),
          logOutTile("Log Out", Icons.exit_to_app_outlined, () {
            Navigator.pop(context);
          })
        ],
      );
    })));
  }

  Widget profileTile(String label, IconData icon, Function onTap) {
    return InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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

  Widget logOutTile(String label, IconData icon, Function onTap) {
    return InkWell(
        onTap: () => onTap(),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Icon(icon)),
            Expanded(
              child: Container(
                  // margin: EdgeInsets.all(20),
                  child: Text(label, style: GoogleFonts.poppins(fontSize: 16))),
            ),
          ],
        ));
  }
}
