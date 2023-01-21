import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/home_provider.dart';
import 'package:eventi_in_zona/screens/manager/edit_monitor.dart';
import 'package:provider/provider.dart';

class MonitorDetails extends StatefulWidget {
  int id;
  MonitorDetails({Key? key, required this.id}) : super(key: key);

  @override
  _MonitorDetailsState createState() => _MonitorDetailsState();
}

class _MonitorDetailsState extends State<MonitorDetails> {
  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.getMonitorById(widget.id);
  }

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
          title: Text("Monitor",
              style: GoogleFonts.poppins(
                  color: Colors.black, fontWeight: FontWeight.w500)),
        ),
        backgroundColor: Colors.white,
        body: Consumer<HomeProvider>(builder: (context, homeProvider, _) {
          return homeProvider.loading
              ? Container(
                  height: size.height,
                  child: Center(child: CircularProgressIndicator.adaptive()))
              : Column(children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        height: size.width / 1.5,
                        width: size.width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: homeProvider.monitor.imageUnavailable
                                    ? BoxFit.cover
                                    : BoxFit.contain,
                                image:
                                    NetworkImage(homeProvider.monitor.image))),
                      ),
                      Container(
                          color: Colors.white,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                left: 20, top: 20, bottom: 10),
                                            child: Text(
                                                homeProvider.monitor.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20)))),
                                  ],
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 20),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "€ " +
                                          homeProvider.monitor.price
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                          fontSize: 18, color: Colors.black),
                                    )),
                              ])),
                      field("Brand", homeProvider.monitor.brand),
                      field("Description", homeProvider.monitor.description),
                      field("Refresh Rate",
                          homeProvider.monitor.refreshRate.toString() + 'Hz'),
                      field("Special Features",
                          homeProvider.monitor.specialFeatures.toString()),
                      field("Resolution", homeProvider.monitor.resolution),
                    ],
                  )),
                  InkWell(
                      onTap: () {
                        // final userProvider =
                        //     Provider.of<UserProvider>(context, listen: false);
                        // addToCart(
                        //     name: homeProvider.monitor.name,
                        //     price: homeProvider.monitor.price,
                        //     category: homeProvider.monitor.category,
                        //     image_url: homeProvider.monitor.image,
                        //     product_id: homeProvider.monitor.productId,
                        //     user_id: userProvider.user.id);

                        // const snackBar = SnackBar(
                        //   content: Text('Item added to cart'),
                        // );
                        // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>
                                EditMonitor(monitor: homeProvider.monitor)));
                      },
                      child: Container(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          alignment: Alignment.bottomCenter,
                          decoration: const BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50))),
                          child: Text("Update Details",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))))
                ]);
        }));
  }

  Widget field(String title, String content) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(fontSize: 18),
                    )),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      content,
                      style: GoogleFonts.poppins(),
                    ))
              ],
            )),
          ],
        ));
  }
}
