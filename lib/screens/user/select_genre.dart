import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/screens/user/select_where.dart';
import 'package:eventi_in_zona/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:eventi_in_zona/screens/user/search_results.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({Key? key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(children: [
      Container(
        margin: EdgeInsets.only(top: 40, left: 20, bottom: 0),
        alignment: Alignment.centerLeft,
        child: Text("What are you searching for?",
            textScaleFactor: 1,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.headline1),
      ),
      Container(height: 40),
      Flexible(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: genres.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  final eventProvider =
                      Provider.of<EventProvider>(context, listen: false);

                  if (genres[index].toUpperCase() != "ANY") {
                    eventProvider.genreSearch = genres[index];
                  } else {
                    eventProvider.genreSearch = "";
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => SelectWhere()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 7,
                            color: Colors.black.withOpacity(0.2))
                      ],
                      // border: Border.all(width: 2, color: Colors.orange),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    genres[index].toUpperCase(),
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                ));
          },
        ),
      )
    ])));
  }
}
