class CategoryModel {
  int? id;
  String? name;
  String? status;
  String? created_at;
  String? updated_at;

  CategoryModel({
    required this.id,
    required this.name,
    required this.status,
    required this.created_at,
    required this.updated_at
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
        id:  int.parse(json['id']),
        name:  json['name'],
        status:  json['status'],
        created_at:  json['created_at'],
        updated_at:  json['updated_at']
    );
  }
}