class Requirement {
  String? sId;
  String? userId;
  String? productName;
  String? category;
  String? userType;
  dynamic quantity;
  dynamic totalPrice;
  String? details;
  List<String?> images;
  String? createdAt;
  String? updatedAt;
  dynamic iV;

  Requirement({
    this.sId,
    required this.userId,
    required this.productName,
    required this.category,
    required this.quantity,
    required this.totalPrice,
    required this.details,
    required this.images,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) {
    return Requirement(
      sId: json['_id'],
      userId: json['userId'].toString(),
      productName: json['productName'].toString(),
      category: json['category'].toString(),
      quantity: json['quantity'].toString(),
      totalPrice: json['totalPrice'].toString(),
      details: json['details'].toString(),
      images: List<String>.from(json['images']),
      createdAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
      iV: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'userId': userId,
      'productName': productName,
      'category': category,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'details': details,
      'images': images,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': iV,
    };
  }
}
