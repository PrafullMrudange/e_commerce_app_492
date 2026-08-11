class CartModel {
  int id;
  int productId;
  String name;
  String price;
  int quantity;
  String image;

  CartModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.image,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json["id"],
      productId: json["product_id"],
      name: json["name"],
      price: json["price"],
      quantity: json["quantity"],
      image: json["image"],
    );
  }
}