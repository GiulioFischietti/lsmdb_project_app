import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/screens/manager/create_beer.dart';
import 'package:eventi_in_zona/screens/manager/create_book.dart';
import 'package:eventi_in_zona/screens/manager/create_monitor.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_beer.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_book.dart';
import 'package:eventi_in_zona/widgets/manager/card_widget_product_result.dart';
import 'package:provider/provider.dart';

class ProductsByCategory extends StatefulWidget {
  const ProductsByCategory({Key? key});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  @override
  void initState() {
    super.initState();
    final managerProvider =
        Provider.of<ManagerProvider>(context, listen: false);
    managerProvider.getProductsByCategory();
  }

  PageController _pageController = PageController();
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selected == 0
                ? Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => CreateBeer()))
                : selected == 2
                    ? Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) => CreateBook()))
                    : Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => CreateMonitor()));
          },
          backgroundColor: Colors.orange,
          splashColor: Colors.orange,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Consumer<ManagerProvider>(builder: (context, managerProvider, _) {
              return Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 20, left: 20, bottom: 0),
                  alignment: Alignment.centerLeft,
                  child: Text("Products",
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  height: 50,
                  child: managerProvider.productsByCategory.isNotEmpty
                      ? Center(
                          child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: managerProvider.productsByCategory.length,
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
                                            managerProvider
                                                .productsByCategory[index]
                                                .category,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.normal,
                                                color: selected == index
                                                    ? Colors.white
                                                    : Colors.grey)))));
                          },
                        ))
                      : CircularProgressIndicator(),
                ),
                managerProvider.productsByCategory.isNotEmpty
                    ? Container(
                        height: size.height * 0.66,
                        child: PageView.builder(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              selected = page;
                            });
                          },
                          itemCount: managerProvider.productsByCategory.length,
                          itemBuilder: (BuildContext context, int index1) {
                            return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.65),
                              itemCount: managerProvider
                                  .productsByCategory[index1].products.length,
                              itemBuilder: (BuildContext context, int index) {
                                return CardWidgetProductResult(
                                  // color: Colors.red,

                                  product: managerProvider
                                      .productsByCategory[index1]
                                      .products[index],
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
