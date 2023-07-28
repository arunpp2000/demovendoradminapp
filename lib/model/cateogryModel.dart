// catogory? category;

class Category {
  String? banner;
  String? brand;
  String? branchId;
  String? categoryBadge;
  String? categoryId;
  String? description;
  String? imageUrl;
  String? madeIn;
  String? name;
  List? search;
  String? vendorId;
  int? status;
  int? referNo;
  bool? delete;
  DateTime? date;
  DateTime? approvedDate;
  DateTime? rejectedDate;
  String? parentId;



  Category(
      {
        this.imageUrl,
        this.banner,
        this.brand,
        this.name,
        this.status,
        // this.subCategory,
        // this.childCategory,
        this.categoryBadge,
        this.categoryId,
        this.description,
        this.madeIn,
        this.branchId,
        this.search,
        this.delete,
        this.vendorId,
        this.date,
        this.approvedDate,
        this.rejectedDate,
        this.referNo,
        this.parentId

      });

  Category.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    banner = json['banner'];
    name = json['name'];

    status = json["status"];
    categoryBadge = json['categoryBadge'];
    categoryId = json['categoryId'];
    description = json['description'];
    madeIn = json['madeIn'];
    branchId = json['branchId'];
    search = json["search"];
    vendorId = json['vendorId'];
    delete = json["delete"];

    date = json["date"]==null?DateTime.now():json["date"].toDate();
    approvedDate = json["acceptedDate"]==null?DateTime.now():json["acceptedDate"].toDate();
    rejectedDate = json["rejectedDate"]==null?DateTime.now():json["rejectedDate"].toDate();
    referNo = json["referNo"];
    parentId = json["parentId"]??'';
    brand = json["brand"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['imageUrl'] = this.imageUrl??"";
    data['banner'] = this.banner??"";
    data['name'] = this.name;
    data["status"]=status ??"";

    data['categoryBadge'] = this.categoryBadge;
    data['categoryId'] = this.categoryId;
    data['description'] = this.description;
    data['madeIn'] = this.madeIn;
    data['branchId'] = this.branchId;
    data["search"] = this.search;
    data['vendorId'] = this.vendorId;
    data["delete"] = this.delete;
    data["date"]=date ??"";
    data["acceptedDate"]=approvedDate ??DateTime.now();
    data["rejectedDate"]=rejectedDate ??DateTime.now();
    data["referNo"]=referNo ;
    data["parentId"]=parentId ;
    data["brand"]=brand ;
    return data;
  }
  Category? copyWith({
    String? banner,
    String? branchId,
    String? categoryBadge,
    String? categoryId,
    String? description,
    String? imageUrl,
    String? madeIn,
    String? name,
    List? search,
    String? vendorId,
    int? status,
    int? referNo,
    bool? delete,
    DateTime? date,
    DateTime? approvedDate,
    DateTime? rejectedDate,
    String? parentId,
    String? brand,

  }){
    return Category(
      banner: banner ?? this.banner,
      branchId: branchId ?? this.branchId,
      categoryBadge: categoryBadge ?? this.categoryBadge,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.categoryId,
      brand: brand ?? this.brand,
      parentId: parentId ?? this.parentId,
      rejectedDate: rejectedDate ?? this.rejectedDate,
      approvedDate: approvedDate ?? this.approvedDate,
      date: date ?? this.date,
      delete: delete ?? this.delete,
      referNo: referNo ?? this.referNo,
      status: status ?? this.status,
      vendorId: vendorId ?? this.vendorId,
      search: search ?? this.search,
      name: name ?? this.name,
      madeIn: madeIn ?? this.madeIn,
      imageUrl: imageUrl ?? this.imageUrl,



    );
  }
}
