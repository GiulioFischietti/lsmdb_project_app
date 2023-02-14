import 'package:eventi_in_zona/providers/analytics_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:objectid/objectid.dart';
import 'package:provider/provider.dart';

class MostUsedWords extends StatefulWidget {
  MostUsedWords({Key? key}) : super(key: key);

  @override
  _MostUsedWordsState createState() => _MostUsedWordsState();
}

class _MostUsedWordsState extends State<MostUsedWords> {
  @override
  void initState() {
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final analyticsProvider =
        Provider.of<AnalyticsProvider>(context, listen: false);
    analyticsProvider.getMostUsedWords(userProvider.manager.managedEntity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
        Consumer<AnalyticsProvider>(builder: (context, analyticsProvider, _) {
      return ListView(shrinkWrap: true, children: [
        Container(
          margin: const EdgeInsets.only(top: 40, left: 20, bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text("Most Used Words",
              textScaleFactor: 1,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.headline1),
        ),
        analyticsProvider.loading
            ? Center(child: CircularProgressIndicator())
            : DataTable(
                columns: [
                    DataColumn(
                      label: Text('Word'),
                    ),
                    DataColumn(
                      label: Text('Count'),
                    ),
                  ],
                rows: analyticsProvider.wordCounts
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.word)),
                          DataCell(Text(e.count.toString())),
                        ]))
                    .toList())
      ]);
    }));
  }
}
