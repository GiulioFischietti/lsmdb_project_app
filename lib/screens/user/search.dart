import 'package:flutter/material.dart';
import 'package:eventi_in_zona/screens/user/search_results.dart';

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
        margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
        alignment: Alignment.centerLeft,
        child: Text("Search",
            textScaleFactor: 1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1),
      ),
      Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          margin: EdgeInsets.all(20),
          child: Row(children: [
            Container(
                margin: EdgeInsets.all(10),
                child: Icon(Icons.search, color: Colors.black)),
            Expanded(
                child: TextFormField(
                    controller: searchController,
                    decoration: InputDecoration(border: InputBorder.none),
                    autofocus: true,
                    cursorColor: Colors.black,
                    onEditingComplete: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              SearchResults(keyword: searchController.text)));
                    }))
          ]))
    ])));
  }
}
