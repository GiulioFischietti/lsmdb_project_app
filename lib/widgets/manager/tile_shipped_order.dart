import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/screens/manager/order_details.dart';

// ignore: must_be_immutable
class TileShippedOrder extends StatefulWidget {
  Order order;
  // String heroTag;
  // ProductController _con;
  // final Favorite preferiti;
  TileShippedOrder({
    Key? key,
    required this.order,
    // this.heroTag,
    /*this.preferiti*/
  }) : super(key: key);

  @override
  _TileShippedOrderState createState() => _TileShippedOrderState();
}

class _TileShippedOrderState extends State<TileShippedOrder> {
  bool favorite = false;
  bool added = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // widget._con = ProductController();
    // widget._con.product = widget.activity;
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) =>
                  OrderDetails(order: widget.order, id: widget.order.id)));
        },
        child: Container(
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Row(children: [
              Expanded(
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: Text(
                        "Order #${widget.order.id}",
                        style: GoogleFonts.poppins(),
                      ))),
              Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  "Shipped",
                  style: GoogleFonts.poppins()
                      .copyWith(fontSize: 14, color: Colors.yellow[800]),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(7.5),
                decoration: BoxDecoration(
                    color: Colors.yellow[800],
                    borderRadius: BorderRadius.circular(100)),
              ),
              Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(7.5),
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[500],
                  size: 16,
                ),
              )
            ])));
  }
}
