import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_app/View/Entities/calendarUtilities.dart';
import 'package:project_app/View/Items/ShowcaseEvents.dart';
import 'package:project_app/View/Other/search_filters.dart';
import 'package:project_app/providers/HomeProvider.dart';
import 'package:project_app/providers/UserProvider.dart';
import 'package:project_app/providers/search_provider.dart';
import 'package:provider/provider.dart';

class SearchResults extends StatefulWidget {
  dynamic position;
  DateTime picked;
  String placename;
  String genre;
  SearchResults(
      {Key key,
      @required this.placename,
      @required this.genre,
      @required this.position})
      : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  double distance = 1000;
  @override
  void initState() {
    super.initState();
    picked = DateTime.now();
    final searchProvider = Provider.of<SearchProvider>(context, listen: false);
    searchProvider.searchEvents(
        [widget.genre], distance, widget.position, DateTime.now());
  }

  DateTime picked;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF333333),
        title: Text("Eventi " + widget.genre + ' - ' + widget.placename),
      ),
      body: Consumer2<UserProvider, SearchProvider>(
          builder: (context, userProvider, searchProvider, child) {
        return Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () async {
                          final newdate = await showDatePicker(
                            locale: Locale('it'),
                            initialEntryMode: DatePickerEntryMode.calendar,
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1920),
                            lastDate: DateTime.now().add(Duration(days: 7)),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.dark().copyWith(
                                  secondaryHeaderColor: Color(0xFFf9b701),
                                  buttonTheme: ButtonThemeData(
                                      highlightColor: Colors.green,
                                      buttonColor: Colors.green,
                                      colorScheme: Theme.of(context)
                                          .colorScheme
                                          .copyWith(
                                              background: Colors.white,
                                              primary: Colors.green,
                                              primaryVariant: Colors.green,
                                              brightness: Brightness.dark,
                                              onBackground: Colors.green)),
                                  colorScheme: ColorScheme.dark(
                                    onSecondary: Theme.of(context).accentColor,
                                    secondaryVariant: Color(0xFFf9b701),
                                    secondary: Color(0xFFf9b701),
                                    primary:
                                        Theme.of(context).primaryColorLight,
                                    onPrimary: Colors.white,

                                    // surface:
                                    //     Theme.of(context).primaryColorLight,
                                    onSurface:
                                        Theme.of(context).primaryColorLight,
                                  ),
                                  dialogTheme: DialogTheme(
                                      contentTextStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText2
                                          .copyWith(color: Colors.white)),
                                  dialogBackgroundColor:
                                      Theme.of(context).primaryColorDark,
                                ),
                                child: child,
                              );
                            },
                          );
                          if (newdate != null) {
                            setState(() {
                              picked = newdate;
                            });
                          }
                          final searchProvider = Provider.of<SearchProvider>(
                              context,
                              listen: false);
                          searchProvider.searchEvents([widget.genre], distance,
                              widget.position, picked);
                        },
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(Icons.calendar_today_outlined,
                                    color: Colors.grey[200])),
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "Dal " +
                                      picked.day.toString() +
                                      ' ' +
                                      getMonth(picked.month - 1),
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[200]),
                          borderRadius: BorderRadius.circular(5)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => SearchFilters(
                                    callback:
                                        (List<String> genres, double distance) {
                                      searchProvider.searchEvents(genres,
                                          distance, widget.position, picked);
                                    },
                                  )));
                        },
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Icon(Icons.filter_alt_outlined,
                                    color: Colors.grey[200])),
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  "Filtri",
                                  style: TextStyle(
                                      color: Colors.grey[200],
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        ),
                      ))
                ],
              ),
            ),
            Row(children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      child: Text(
                        "Eventi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ))),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Icon(Icons.arrow_forward, color: Colors.white))
            ]),
            searchProvider.searchedevents != null
                ? ShowcaseEvents(data: searchProvider.searchedevents)
                : Center(child: CircularProgressIndicator()),
          ],
        );
      }),
    );
  }
}
