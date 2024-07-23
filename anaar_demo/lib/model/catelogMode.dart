class Catelogmodel {
  String? userId;
  String? productName;
  String? category;
  String? description;
  String? price;
  List<String?> images;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Catelogmodel(
      {required this.productName,
      required this.userId,
      required this.category,
      required this.images,
      required this.description,
      required this.price,
      this.createdAt,
      this.updatedAt,
      this.iV});

  factory Catelogmodel.fromJson(Map<String, dynamic> json) {
    return Catelogmodel(
        productName: json['productName'],
        userId: json['userId'],
        category: json['category'],
        images: List<String>.from(json['images']),
        description: json['description'],
        price: json['price']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['_id'] = this.sId;
    data['productName'] = this.productName;
    data['userId'] = this.userId;
    data['category'] = this.category;
    data['images'] = this.images;
    data['price'] = this.price;
    data['description'] = this.description;
    data['productName'] = this.productName;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
