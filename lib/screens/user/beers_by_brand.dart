import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_beer.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_book.dart';
import 'package:provider/provider.dart';

class BeersByBrand extends StatefulWidget {
  const BeersByBrand({Key? key});

  @override
  State<BeersByBrand> createState() => _BeersByBrandState();
}

class _BeersByBrandState extends State<BeersByBrand> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBeersByBrand();
  }

  PageController _pageController = PageController();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
          backgroundColor: Colors.grey[100],
          title: Text("Beers",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Consumer<HomeProvider>(builder: (context, homeProvider, _) {
              return Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  height: 50,
                  child: homeProvider.beersByBrand.isNotEmpty
                      ? Center(
                          child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: homeProvider.beersByBrand.length,
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
                                                .beersByBrand[index].brand,
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
                homeProvider.beersByBrand.isNotEmpty
                    ? Container(
                        height: size.height - 206,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              selected = page;
                            });
                          },
                          itemCount: homeProvider.beersByBrand.length,
                          itemBuilder: (BuildContext context, int index1) {
                            return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.65),
                              itemCount:
                                  homeProvider.beersByBrand[index1].beer.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidgetBeer(
                                  // color: Colors.red,

                                  beer: homeProvider
                                      .beersByBrand[index1].beer[index],
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
