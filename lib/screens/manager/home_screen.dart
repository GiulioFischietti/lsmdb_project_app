import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/providers/manager_provider.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/widgets/manager/tile_concluded_order.dart';
import 'package:eventi_in_zona/widgets/manager/tile_inprogress_order.dart';
import 'package:eventi_in_zona/widgets/manager/tile_new_order.dart';
import 'package:eventi_in_zona/widgets/manager/tile_shipped_order.dart';
import 'package:provider/provider.dart';

class HomeManager extends StatefulWidget {
  HomeManager({Key? key}) : super(key: key);

  @override
  _HomeManagerState createState() => _HomeManagerState();
}

class _HomeManagerState extends State<HomeManager> {
  // TODO add layout in configuration file
  String layout = 'grid';

  PageController _pageController = new PageController();

  @override
  void initState() {
    // _con.listenForOrders();
    super.initState();
    final managerProvider =
        Provider.of<ManagerProvider>(context, listen: false);
    managerProvider.getManagedOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedIndex = 0;

  bool orderIsNew(Order order) {
    return (order.status == 'Paid');
  }

  bool orderIsInPreparation(Order order) {
    return ((order.status == "In preparation"));
  }

  bool orderIsShipped(Order order) {
    return ((order.status == "Shipped"));
  }

  bool orderIsConcluded(Order order) {
    return (order.status == "Delivered");
  }

  bool available = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(child:
        Consumer<ManagerProvider>(builder: (context, managerProvider, _) {
      return Stack(children: [
        Column(children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, bottom: 10, right: 20),
                            child: Text(
                              "Welcome Back ${managerProvider.manager.name}",
                              style: GoogleFonts.poppins(fontSize: 18),
                            )),
                        Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Manager ID: ${managerProvider.manager.id}",
                              style: GoogleFonts.poppins(),
                            ))
                      ],
                    )),
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.14),
                            blurRadius: 7,
                            spreadRadius: 2)
                      ],
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(managerProvider.manager.image)),
                      borderRadius: BorderRadius.circular(100)),
                )
              ],
            ),
          ),
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[400]!.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7)
              ],
            ),
            height: 80,
            margin: EdgeInsets.only(top: 30),
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(0,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 0
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 7.5),
                        child: Text(
                          "All",
                          style: selectedIndex == 0
                              ? GoogleFonts.poppins(color: Colors.white)
                              : GoogleFonts.poppins(),
                        ))),
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(1,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 1
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 7.5),
                        child: Text(
                          "Paid",
                          style: selectedIndex == 1
                              ? GoogleFonts.poppins(color: Colors.white)
                              : GoogleFonts.poppins(),
                        ))),
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(2,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 2
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 7.5),
                        child: Text(
                          "In Preparation",
                          style: selectedIndex == 2
                              ? GoogleFonts.poppins(color: Colors.white)
                              : GoogleFonts.poppins(),
                        ))),
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(3,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 3
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 7.5),
                        child: Text(
                          "Shipped",
                          style: selectedIndex == 3
                              ? GoogleFonts.poppins(color: Colors.white)
                              : GoogleFonts.poppins(),
                        ))),
                InkWell(
                    onTap: () {
                      _pageController.animateToPage(4,
                          duration: Duration(milliseconds: 650),
                          curve: Curves.ease);
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: selectedIndex == 4
                                ? Colors.orange
                                : Colors.grey[200],
                            borderRadius: BorderRadius.circular(40)),
                        margin:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 7.5),
                        child: Text(
                          "Delivered",
                          style: selectedIndex == 4
                              ? GoogleFonts.poppins(color: Colors.white)
                              : GoogleFonts.poppins(),
                        ))),
              ],
            ),
          ),
          Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.all(10),
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (int val) {
                      setState(() {
                        selectedIndex = val;
                      });
                    },
                    children: [
                      RefreshIndicator(
                        onRefresh: () async {
                          // return await _con.getOrdersOfRider();
                        },
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: managerProvider.orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (orderIsNew(managerProvider.orders[index])) {
                              return TileNewOrder(
                                  // driver_id: _con.rider.id,
                                  // onAccept: () {
                                  //   _pageController.animateToPage(2,
                                  //       duration: Duration(milliseconds: 650),
                                  //       curve: Curves.ease);
                                  //   setState(() {
                                  //     managerProvider.orders[index].driver_id =
                                  //         _con.rider.id;
                                  //   });
                                  // },

                                  order: managerProvider.orders[index]);
                            }
                            if (orderIsConcluded(
                                managerProvider.orders[index])) {
                              return TileConcludedOrder(
                                  order: managerProvider.orders[index]);
                            }
                            if (orderIsInPreparation(
                                managerProvider.orders[index])) {
                              return TileInProgressOrder(
                                  order: managerProvider.orders[index]);
                            }
                            if (orderIsShipped(managerProvider.orders[index])) {
                              return TileShippedOrder(
                                  order: managerProvider.orders[index]);
                            }
                            return Container();
                          },
                        ),
                      ),
                      RefreshIndicator(
                          onRefresh: () async {
                            // return await _con.getOrdersOfRider();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: managerProvider.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (orderIsNew(managerProvider.orders[index])) {
                                return TileNewOrder(
                                    // onAccept: () {
                                    // _pageController.animateToPage(2,
                                    //     duration: Duration(milliseconds: 650),
                                    //     curve: Curves.ease);
                                    // setState(() {
                                    //   managerProvider.orders[index].driver_id =
                                    //       _con.rider.id;
                                    // });
                                    // },
                                    // driver_id: _con.rider.id,
                                    order: managerProvider.orders[index]);
                              } else
                                return Container();
                            },
                          )),
                      RefreshIndicator(
                          onRefresh: () async {
                            // return await _con.getOrdersOfRider();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: managerProvider.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              // if (managerProvider.orders[index].status == "accepted")
                              if (orderIsInPreparation(
                                  managerProvider.orders[index]))
                                return TileInProgressOrder(
                                    order: managerProvider.orders[index]);
                              // else
                              return Container();
                            },
                          )),
                      RefreshIndicator(
                          onRefresh: () async {
                            // return await _con.getOrdersOfRider();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: managerProvider.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              // if (managerProvider.orders[index].status == "accepted")
                              if (orderIsShipped(managerProvider.orders[index]))
                                return TileShippedOrder(
                                    order: managerProvider.orders[index]);
                              // else
                              return Container();
                            },
                          )),
                      RefreshIndicator(
                          onRefresh: () async {
                            // return await _con.getOrdersOfRider();
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: managerProvider.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (orderIsConcluded(
                                  managerProvider.orders[index]))
                                return TileConcludedOrder(
                                    order: managerProvider.orders[index]);
                              else
                                return Container();
                            },
                          )),
                    ],
                  )))
        ]),
      ]);
    }));
  }
}
