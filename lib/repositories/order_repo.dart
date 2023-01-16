import 'package:eventi_in_zona/models/product_order.dart';
import 'package:eventi_in_zona/repositories/repo.dart';

Future<dynamic> getManagerOrdersData() async {
  return await Repo().getData("order/managerorders");
}

Future<dynamic> updateStatusOrderData(String status, int id) async {
  return await Repo()
      .postData("order/updatestatusorder", {"id": id, "status": status});
}

Future<dynamic> getUserOrdersData(int customer_id) async {
  return await Repo().getData("order/orders?id=$customer_id");
}

Future<dynamic> getUserOrderDetailsData(int order_id, int customer_id) async {
  return await Repo()
      .getData("order/orderdetails?id=$customer_id&order_id=$order_id");
}

Future<dynamic> createOrderData(
    {List<ProductOrder>? product_orders,
    int? customer_id,
    double? total,
    String? shipping_address,
    String? shipping_country,
    String? payment_type}) async {
  return await Repo().postData("order/createorder", {
    "id": customer_id,
    "total": (product_orders!.map((e) => e.price * e.quantity))
        .reduce((a, b) => a + b),
    "shipping_address": shipping_address,
    "shipping_country": shipping_country,
    "payment_type": payment_type,
    "product_orders": product_orders.map((e) {
      return e.toJson();
    }).toList()
  });
}
