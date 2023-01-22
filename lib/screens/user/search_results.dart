import 'package:eventi_in_zona/providers/event_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_event.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  SearchResults({Key? key});

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    eventProvider.searchEvents(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
        child: Consumer<EventProvider>(builder: (context, searchProvider, _) {
      return Column(children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
          alignment: Alignment.centerLeft,
          child: Text("Results",
              textScaleFactor: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1),
        ),
        searchProvider.loading
            ? Center(child: CircularProgressIndicator())
            : Expanded(
                child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchProvider.searchResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return CardWidgetEventMinimal(
                      eventMinimal: searchProvider.searchResults[index]);
                },
              ))
      ]);
    })));
  }
}
