class Catelogmodel {
  String? sId;
  String? userId;
  String? category;
  List<Catalog>? catalog;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Catelogmodel(
      {this.sId,
      this.userId,
      this.category,
      this.catalog,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Catelogmodel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    category = json['category'];
    if (json['catalog'] != null) {
      catalog = <Catalog>[];
      json['catalog'].forEach((v) {
        catalog!.add(new Catalog.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['category'] = this.category;
    if (this.catalog != null) {
      data['catalog'] = this.catalog!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Catalog {
  String? image;
  String? description;
  String? price;
  String? sId;
  String? createdAt;
  String? updatedAt;

  Catalog(
      {this.image,
      this.description,
      this.price,
      this.sId,
      this.createdAt,
      this.updatedAt});

  Catalog.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    description = json['description'];
    price = json['price'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['description'] = this.description;
    data['price'] = this.price;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
