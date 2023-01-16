class Order {
  late int id;
  late int userId;
  late String shippingAddress;
  late String shippingCountry;
  late DateTime shippingDate;
  late DateTime orderDate;
  late String paymentType;
  late String status;
  late double total;

  Order(data) {
    id = data['id'];
    userId = data['customer_id'];
    shippingAddress = data['shipping_address'];
    shippingCountry = data['shipping_country'];
    shippingDate = data['shipping_date'] != null
        ? DateTime.parse(data['shipping_date'])
        : DateTime.now();
    orderDate = DateTime.parse(data['order_date']);
    paymentType = data['payment_type'];
    status = data['status'];
    total = double.parse(data['total'].toString());
  }
}
