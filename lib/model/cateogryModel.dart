// catogory? category;

class Category {
  String? imageUrl;
  String? banner;
  String? name;
  String? subCategory;
  String? childCategory;
  String? categoryBadge;
  String? categoryId;
  String? description;
  String? brand;
  String? madeIn;
  String? branchId;
  List? search;
  String? vendorId;
  bool? delete;

  Category(
      {this.imageUrl,
      this.banner,
      this.name,
      this.subCategory,
      this.childCategory,
      this.categoryBadge,
      this.categoryId,
      this.description,
      this.brand,
      this.madeIn,
      this.branchId,
      this.search,
      this.delete,
      this.vendorId});

  Category.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    banner = json['banner'];
    name = json['name'];
    subCategory = json['subCategory'];
    childCategory = json['childCategory'];
    categoryBadge = json['categoryBadge'];
    categoryId = json['categoryId'];
    description = json['description'];
    brand = json['brand'];
    madeIn = json['madeIn'];
    branchId = json['branchId'];
    search = json["search"];
    vendorId = json['vendorId'];
    delete = json["delete"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl??"";
    data['banner'] = this.banner??"";
    data['name'] = this.name;
    data['subCategory'] = this.subCategory;
    data['childCategory'] = this.childCategory;
    data['categoryBadge'] = this.categoryBadge;
    data['categoryId'] = this.categoryId;
    data['description'] = this.description;
    data['brand'] = this.brand;
    data['madeIn'] = this.madeIn;
    data['branchId'] = this.branchId;
    data["search"] = this.search;
    data['vendorId'] = this.vendorId;
    data["delete"] = this.delete;
    return data;
  }
}
