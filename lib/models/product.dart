class Product {
  int id = 0;
  String name = "";
  String shortDescription = "";
  String description = "";
  String brand = "";
  String category = "";
  String image = "";
  int count = 0;
  bool imageUnavailable = true;
  double price = 0.0;
  int stock = 0;

  Product(data) {
    id = data['id'] ?? data['product_id'] ?? 0;
    name = data['name'] ?? "";
    category = data['category'] ?? "";
    shortDescription = data['short_description'] ?? "";
    description = data['description'] ?? "";
    brand = data['brand'] ?? "";
    imageUnavailable = (data['image_url'] == "");
    image = data['image_url'] == ""
        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSJXPMV4om8DHHMSpua5R6d8TlCmR0zDwbQ&usqp=CAU"
        : data['image_url'] ?? "";
    price =
        data['price'] != null ? double.parse(data['price'].toString()) : 0.0;
    stock = data['stock'] ?? 0;
    count = data['product_count'] ?? 0;
  }

  Product.fromJson(Map<String, dynamic> data) {
    id = data['id'] ?? 0;
    name = data['name'] ?? "";
    category = data['category'] ?? "";
    shortDescription = data['short_description'] ?? "";
    description = data['description'] ?? "";
    brand = data['brand'] ?? "";
    imageUnavailable = (data['image_url'] == "");
    image = data['image_url'] == ""
        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSSJXPMV4om8DHHMSpua5R6d8TlCmR0zDwbQ&usqp=CAU"
        : data['image_url'] ?? "";
    price =
        data['price'] != null ? double.parse(data['price'].toString()) : 0.0;
    stock = data['stock'] ?? 0;
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'image_url': image,
        "price": price
      };
}
