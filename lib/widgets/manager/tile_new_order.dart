// ignore: must_be_immutable
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/models/order.dart';
import 'package:eventi_in_zona/screens/manager/order_details.dart';

class TileNewOrder extends StatefulWidget {
  Order order;
  TileNewOrder({Key? key, required this.order // this.heroTag,
      /*this.preferiti*/
      })
      : super(key: key);

  @override
  _TileNewOrderState createState() => _TileNewOrderState();
}

class _TileNewOrderState extends State<TileNewOrder> {
  bool favorite = false;
  bool added = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // widget._con = ProductController();
    // widget._con.product = widget.activity;
    return Container(
        decoration: BoxDecoration(
            boxShadow: [],
            border: Border(bottom: BorderSide(color: Colors.grey[200]!))),
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Row(children: [
          Expanded(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => OrderDetails(
                            order: widget.order, id: widget.order.id)));
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: Text(
                        "Order #${widget.order.id}",
                        style: GoogleFonts.poppins(),
                      )))),
          // InkWell(
          //     onTap: () {},
          //     child: Container(
          //       margin: EdgeInsets.all(10),
          //       padding: EdgeInsets.all(7.5),
          //       decoration: BoxDecoration(
          //           color: Colors.red,
          //           borderRadius: BorderRadius.circular(100)),
          //       child: Icon(Icons.remove_circle, color: Colors.white),
          //     )),
          // InkWell(
          //     onTap: () async {
          //       // await _con.autoAssignOrder(widget.order.id, widget.driver_id);
          //       // widget.onAccept();
          //       // Navigator.of(context).pushReplacement(
          //       //     MaterialPageRoute(builder: (ctx) => HomeWidget()));
          //     },
          //     child: Container(
          //       margin: EdgeInsets.all(10),
          //       padding: EdgeInsets.all(7.5),
          //       decoration: BoxDecoration(
          //           color: Colors.green[800],
          //           borderRadius: BorderRadius.circular(100)),
          //       child: Icon(Icons.check, color: Colors.white),
          //     )),
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              "Paid",
              style: GoogleFonts.poppins()
                  .copyWith(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 2.5),
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
        ]));
  }
}
