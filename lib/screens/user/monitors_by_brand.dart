import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_book.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_monitor.dart';
import 'package:provider/provider.dart';

class MonitorsByBrand extends StatefulWidget {
  const MonitorsByBrand({Key? key});

  @override
  State<MonitorsByBrand> createState() => _MonitorsByBrandState();
}

class _MonitorsByBrandState extends State<MonitorsByBrand> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getMonitorsByBrand();
  }

  PageController _pageController = PageController();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          return Column(children: [
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 10),
              height: 50,
              child: homeProvider.monitorsByBrand.isNotEmpty
                  ? Center(
                      child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.monitorsByBrand.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onTap: () {
                              _pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 650),
                                  curve: Curves.ease);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: selected == index
                                        ? Colors.orange
                                        : Colors.white),
                                margin: EdgeInsets.all(10),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 6),
                                    child: Text(
                                        homeProvider
                                            .monitorsByBrand[index].brand,
                                        style: GoogleFonts.poppins(
                                            fontWeight: selected == index
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: selected == index
                                                ? Colors.white
                                                : Colors.grey)))));
                      },
                    ))
                  : CircularProgressIndicator(),
            ),
            homeProvider.monitorsByBrand.isNotEmpty
                ? Container(
                    height: size.height - 180,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          selected = page;
                        });
                      },
                      itemCount: homeProvider.monitorsByBrand.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.65),
                          itemCount: homeProvider
                              .monitorsByBrand[index1].monitors.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardWidgetMonitor(
                              // color: Colors.red,

                              monitor: homeProvider
                                  .monitorsByBrand[index1].monitors[index],
                            );
                          },
                        );
                      },
                    ),
                  )
                : CircularProgressIndicator(),
          ]);
        }),
      ],
    )));
  }
}
