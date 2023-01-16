import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/models/user.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_product_order.dart';
import 'package:provider/provider.dart';

class OrderDetails extends StatefulWidget {
  int id;
  Order order;
  OrderDetails({Key? key, required this.order, required this.id})
      : super(key: key);
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Future<void> openMapLocation(String latitude, String longitude) async {
    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  Future<void> openMapAddress(String address) async {
    // String googleUrl =
    //     'https://www.google.com/maps/search/?api=1&query=$address';
    // if (await canLaunch(googleUrl)) {
    //   await launch(googleUrl);
    // } else {
    //   throw 'Could not open the map.';
    // }
  }

  _launchCaller(String number) async {
    // String url = ("tel:" + number);
    // if (await canLaunch(url)) {
    //   await launch(url);
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // TODO add layout in configuration file
  String layout = 'grid';

  PageController _pageController = PageController();
  int selectedIndex = 0;

  @override
  void initState() {
    // _con.listenForOrderDetails(
    // routeargument.id
    // );
    // _con.getRider();
    // _con.getOrderById(widget.id);
    super.initState();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserOrderDetails(widget.order.id);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget addressesPage(Order order, User user) {
      return ListView(
        shrinkWrap: true,
        children: [
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 20, bottom: 20, top: 10),
                  child: Text(
                    'Shipping Address',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 20, bottom: 0, top: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          user.name,
                          style: GoogleFonts.poppins(),
                        ))),
                // InkWell(
                //     onTap: () {
                //       // _launchCaller(order.user.phone);
                //     },
                //     child: Container(
                //         margin: EdgeInsets.only(
                //             left: 20, right: 20, bottom: 0, top: 10),
                //         child: Icon(Icons.call, color: Colors.grey[400]))),
                // InkWell(
                //     onTap: () async {
                // openMapAddress(order.deliveryAddress.address +
                //     ' - ' +
                //     order.deliveryAddress.cap +
                //     ' - ' +
                //     order.deliveryAddress.city);
                // },
                // child: Container(
                //     margin: EdgeInsets.only(
                //         right: 30, left: 10, bottom: 0, top: 10),
                //     child: Icon(Icons.directions, color: Colors.grey[400])))
              ]),
              Container(
                  margin: EdgeInsets.only(left: 20, bottom: 0, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    order.shippingAddress,
                    style: GoogleFonts.poppins(),
                  )),
              Container(
                  margin: EdgeInsets.only(left: 20, bottom: 20, top: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    order.shippingCountry,
                    style: GoogleFonts.poppins(),
                  )),
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey[400],
              )),
        ],
      );
    }

    Widget productsOrderedPage(Order order, List<ProductOrder> productOrders) {
      return Column(
        children: [
          Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: productOrders.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CardWidgetProductOrder(
                          productOrder: productOrders[index]);
                    },
                  ))),
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 7)
            ]),
          ),
          Row(children: [
            Expanded(
                child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text("Total", style: GoogleFonts.poppins()))),
            Container(
                margin: EdgeInsets.all(20),
                child: Text(
                    "€ " +
                        (productOrders.map((e) => e.total))
                            .reduce((a, b) => a + b)
                            .toStringAsFixed(2),
                    style: GoogleFonts.poppins().copyWith(fontSize: 16)))
          ]),
        ],
      );
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios, size: 18, color: Colors.black)),
          backgroundColor: Colors.grey[100],
          title: Text("Order #${widget.order.id}",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        body: Column(children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                      setState(() {
                        selectedIndex = 0;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.grey
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Products",
                          style: selectedIndex == 0
                              ? GoogleFonts.poppins()
                              : GoogleFonts.poppins(),
                        ))),
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                      setState(() {
                        selectedIndex = 1;
                      });
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.grey
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin: EdgeInsets.all(20),
                        child: Text(
                          "Address",
                          style: selectedIndex == 1
                              ? GoogleFonts.poppins()
                              : GoogleFonts.poppins(),
                        ))),
              ],
            ),
          ),
          Consumer<UserProvider>(builder: (context, userProvider, _) {
            return Expanded(
                child: PageView(
                    onPageChanged: (int page) {
                      setState(() {
                        selectedIndex = page;
                      });
                    },
                    controller: _pageController,
                    children: [
                  Container(
                      child: productsOrderedPage(
                          widget.order, userProvider.productOrders)),
                  Container(
                      child: addressesPage(widget.order, userProvider.user))
                ]));
          }),
        ]));
  }
}
