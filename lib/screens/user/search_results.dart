import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  String keyword = "";
  SearchResults({Key? key, required this.keyword});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    final searchProvider = Provider.of<HomeProvider>(context, listen: false);
    searchProvider.searchProducts(widget.keyword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Consumer<HomeProvider>(builder: (context, searchProvider, _) {
      return Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
          alignment: Alignment.centerLeft,
          child: Text("${searchProvider.productsResult.length} Results",
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        ),
        InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(20),
                child: Row(children: [
                  Container(
                      margin: EdgeInsets.all(10),
                      child: Icon(Icons.search, color: Colors.black)),
                  Expanded(
                      child: Container(
                          child: Text(widget.keyword,
                              style: GoogleFonts.poppins())))
                ]))),
        // Expanded(
        //     child: ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: searchProvider.productsResult.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return CardWidgetProductResult(
        //         product: searchProvider.productsResult[index]);
        //   },
        // )),
      ]);
    })));
  }
}
