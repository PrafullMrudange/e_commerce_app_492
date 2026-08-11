class ProductModel {
  String? id;
  String? name;
  String? price;
  String? image;
  String? categoryId;
  dynamic status;
  String? createdAt;
  String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.categoryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      categoryId: json['category_id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}