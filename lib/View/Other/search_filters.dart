import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SearchFilters extends StatefulWidget {
  Function callback;
  SearchFilters({Key key, this.callback}) : super(key: key);

  @override
  State<SearchFilters> createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  List<String> searchGenres = [
    "Tutti gli eventi",
    "Pop",
    "Rock",
    "House",
    "Rap",
    "Elettronica",
    "Blues",
    "Dub",
    "Raggae"
  ];
  dynamic value;
  double distance = 10;
  List<int> selectedGenres = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: Color(0xFF333333),
        title: Text(
          "Filtri",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.all(20),
              child: Text(
                "Generi",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Wrap(
                      children: searchGenres
                          .asMap()
                          .map((index, element) => MapEntry(
                                index,
                                InkWell(
                                    onTap: () {
                                      if (index == 0) {
                                        setState(() {
                                          selectedGenres = [0];
                                        });
                                      } else {
                                        setState(() {
                                          if (selectedGenres.contains(index)) {
                                            selectedGenres.remove(index);
                                          } else {
                                            selectedGenres.add(index);
                                          }
                                        });
                                      }
                                      // if (widget.body == null) {
                                      //   widget.body = {
                                      //     "keyword": "",
                                      //     "range": 1000,
                                      //     "rating": 0,
                                      //     "price_min": 0,
                                      //     "price_max": 1000,
                                      //     "delivery_mode": "delivery"
                                      //   };
                                      // }
                                      // widget.body['keyword'] = item;
                                      // Navigator.of(context).push(MaterialPageRoute(
                                      //     builder: (ctx) => SearchResults(
                                      //           body: widget.body,
                                      //         )));
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: 10, top: 5, bottom: 5),
                                        decoration: BoxDecoration(
                                            color:
                                                selectedGenres.contains(index)
                                                    ? Color(0xFFf9b701)
                                                    : Color(0xFF333333)),
                                        child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Text(
                                              element,
                                              style: TextStyle(
                                                  color: selectedGenres
                                                          .contains(index)
                                                      ? Colors.black
                                                      : Colors.grey[200]),
                                            )))),
                              ))
                          .values
                          .toList()))
            ],
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20, top: 40),
              child: Text(
                "Distanza massima (in km)",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18),
              )),
          Container(
              margin: EdgeInsets.only(top: 15),
              child: SfSlider(
                activeColor: Color(0xFFf9b701),
                min: 0.0,
                max: 80.0,
                value: distance,
                interval: 10,
                showTicks: true,
                showLabels: true,
                enableTooltip: true,
                minorTicksPerInterval: 0,
                onChanged: (dynamic values) {
                  setState(() {
                    distance = values;
                  });
                },
              )),
          Expanded(child: Container()),
          InkWell(
              onTap: () {
                List<String> tmpgenres = [];
                for (int index in selectedGenres) {
                  tmpgenres.add(searchGenres[index]);
                }
                widget.callback(
                  tmpgenres,
                  distance,
                );
                Navigator.of(context).pop(context);
              },
              child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFFf9b701),
                      borderRadius: BorderRadius.circular(50)),
                  margin: EdgeInsets.all(20),
                  child: Text(
                    "Applica",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
