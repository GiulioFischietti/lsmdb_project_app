import 'package:eventi_in_zona/models/entity_minimal.dart';
import 'package:eventi_in_zona/models/user_minimal.dart';
import 'package:eventi_in_zona/repositories/user_repo.dart';
import 'package:eventi_in_zona/screens/auth/login.dart';
import 'package:eventi_in_zona/screens/user/artist_details.dart';
import 'package:eventi_in_zona/screens/user/club_details.dart';
import 'package:eventi_in_zona/screens/user/organizer_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:objectid/objectid.dart';

class CardWidetMinimalUser extends StatefulWidget {
  EntityMinimal entityMinimal;
  ObjectId myUserId;
  bool followable;
  CardWidetMinimalUser(
      {required this.myUserId,
      required this.followable,
      required this.entityMinimal,
      super.key});

  @override
  State<CardWidetMinimalUser> createState() => _CardWidetMinimalUserState();
}

class _CardWidetMinimalUserState extends State<CardWidetMinimalUser> {
  bool followed = false;
  bool loadingFollow = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 7,
                      color: Colors.black.withOpacity(0.2))
                ]),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.grey[400],
                      image: DecorationImage(
                          image: NetworkImage(widget.entityMinimal.image))),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        child: Text(widget.entityMinimal.name,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold))),
                    Container(
                        child: Text("@" + widget.entityMinimal.username,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey[500])))
                  ],
                ),
                Expanded(child: Container()),
                widget.followable
                    ? !loadingFollow
                        ? followed
                            ? InkWell(
                                onTap: () async {
                                  setState(() {
                                    loadingFollow = true;
                                  });

                                  await unfollowUser(
                                      widget.myUserId, widget.entityMinimal.id);

                                  setState(() {
                                    followed = false;
                                    loadingFollow = false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.orange),
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    margin: EdgeInsets.only(
                                        right: 20, top: 0, bottom: 0),
                                    child: Text(
                                      "Unfollow",
                                      style: GoogleFonts.poppins(
                                          color: Colors.orange),
                                    )))
                            : InkWell(
                                onTap: () async {
                                  // entityProvider.unfollowClub(
                                  //     userProvider.user.id);
                                  setState(() {
                                    loadingFollow = true;
                                  });

                                  await followUser(
                                      widget.myUserId, widget.entityMinimal.id);

                                  setState(() {
                                    followed = true;
                                    loadingFollow = false;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.orange),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    margin: const EdgeInsets.only(
                                        right: 20, top: 0, bottom: 0),
                                    child: Text(
                                      "Follow",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )))
                        : CircularProgressIndicator()
                    : Container()
              ],
            )));
  }
}
