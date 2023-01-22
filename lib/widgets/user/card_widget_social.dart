import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CardWidgetSocial extends StatefulWidget {
  String social;
  CardWidgetSocial({super.key, required this.social});

  @override
  State<CardWidgetSocial> createState() => _CardWidgetSocialState();
}

class _CardWidgetSocialState extends State<CardWidgetSocial> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          launchUrl(Uri.parse(widget.social));
        },
        child: Container(
            margin: EdgeInsets.only(right: 20, top: 10, bottom: 10, left: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        // color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              widget.social.toLowerCase().contains("soundcloud")
                                  ? "https://www.freepnglogos.com/uploads/soundcloud-logo-png/soundcloud-logo-soundcloud-icon-transparent-png-1.png"
                                  : widget.social
                                          .toLowerCase()
                                          .contains("youtube")
                                      ? "https://upload.wikimedia.org/wikipedia/commons/e/ef/Youtube_logo.png"
                                      : widget.social
                                              .toLowerCase()
                                              .contains("twitter")
                                          ? "https://www.freepnglogos.com/uploads/twitter-logo-png/twitter-logo-vector-png-clipart-1.png"
                                          : widget.social
                                                  .toLowerCase()
                                                  .contains("facebook")
                                              ? "https://www.citypng.com/public/uploads/preview/-11595349592mdhzsfgakx.png"
                                              : widget.social
                                                      .toLowerCase()
                                                      .contains("instagram")
                                                  ? "https://www.hotelmilano.net/wp-content/uploads/2021/04/instagram-png-instagram-png-logo-1455-3-1024x1024.png"
                                                  : widget.social
                                                          .toLowerCase()
                                                          .contains("snapchat")
                                                      ? "https://1000marche.net/wp-content/uploads/2020/03/Snapchat-logo.png"
                                                      : "",
                            )))),
                Text(
                  widget.social.toLowerCase().contains("soundcloud")
                      ? "SoundCloud"
                      : widget.social.toLowerCase().contains("youtube")
                          ? "YouTube"
                          : widget.social.toLowerCase().contains("twitter")
                              ? "Twitter"
                              : widget.social.toLowerCase().contains("facebook")
                                  ? "Facebook"
                                  : widget.social
                                          .toLowerCase()
                                          .contains("instagram")
                                      ? "Instagram"
                                      : widget.social
                                              .toLowerCase()
                                              .contains("snapchat")
                                          ? "SnapChat"
                                          : widget.social,
                  style: GoogleFonts.poppins(),
                )
              ],
            )));
  }
}
