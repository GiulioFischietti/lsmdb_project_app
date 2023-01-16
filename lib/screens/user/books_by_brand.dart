import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_book.dart';
import 'package:provider/provider.dart';

class BooksByBrand extends StatefulWidget {
  const BooksByBrand({Key? key});

  @override
  State<BooksByBrand> createState() => _BooksByBrandState();
}

class _BooksByBrandState extends State<BooksByBrand> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getBooksByBrand();
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
              child: homeProvider.booksByBrand.isNotEmpty
                  ? Center(
                      child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: homeProvider.booksByBrand.length,
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
                                        homeProvider.booksByBrand[index].brand,
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
            homeProvider.booksByBrand.isNotEmpty
                ? Container(
                    height: size.height - 180,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          selected = page;
                        });
                      },
                      itemCount: homeProvider.booksByBrand.length,
                      itemBuilder: (BuildContext context, int index1) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.65),
                          itemCount:
                              homeProvider.booksByBrand[index1].books.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardWidgetBook(
                              // color: Colors.red,

                              book: homeProvider
                                  .booksByBrand[index1].books[index],
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
