class OrderProductModel {
  int id;
  String name;
  int quantity;
  String price;
  String image;

  OrderProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.image,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json["id"],
      name: json["name"],
      quantity: json["quantity"],
      price: json["price"],
      image: json["image"],
    );
  }
}

class OrderModel {
  int id;
  String totalAmount;
  String orderNumber;
  String status;
  String createdAt;
  List<OrderProductModel> products;

  OrderModel({
    required this.id,
    required this.totalAmount,
    required this.orderNumber,
    required this.status,
    required this.createdAt,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      totalAmount: json["total_amount"],
      orderNumber: json["order_number"],
      status: json["status"],
      createdAt: json["created_at"],
      products: (json["product"] as List)
          .map(
            (e) => OrderProductModel.fromJson(e),
      )
          .toList(),
    );
  }
}