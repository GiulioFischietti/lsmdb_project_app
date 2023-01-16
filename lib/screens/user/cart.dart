import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eventi_in_zona/providers/user_provider.dart';
import 'package:eventi_in_zona/screens/user/checkoutpage.dart';
import 'package:eventi_in_zona/widgets/user/card_widget_cart_item.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  Cart({Key? key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.getUserCart();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Consumer<UserProvider>(
      builder: (context, userProvider, _) => Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text("Cart",
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: userProvider.cartProducts.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return CardWidgetCartItem(
                  key: widget.key, item: userProvider.cartProducts[index]);
            },
          )),
          InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => CheckoutPage()));
              },
              child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: userProvider.cartProducts.isNotEmpty
                          ? Colors.orange
                          : Colors.grey,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))),
                  child: Text(
                      "Checkout ${userProvider.cartProducts.isNotEmpty ? '€' + (userProvider.cartProducts.map((e) => e.price * e.quantity)).reduce((a, b) => a + b).toStringAsFixed(2) : ''}",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.bold))))
        ],
      ),
    )));
  }
}
