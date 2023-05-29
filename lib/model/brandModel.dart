AddBrand? currentBrand = AddBrand();

class AddBrand {
  String? branchId;
  String? color;
  String? brand;
  String? head;
  String? couponColorCode;
  String? content;
  //String? featureName;
  String? venderId;
  List? imageList;
  List? galaryimage;
  String? imageUrl;
  String? banner;
  bool?Brandaffiliate;
  List? youTube;
  // int? commissionPer;
  String? commissionPer;
  String?percentage;
  bool? delete;
  int? status;
  String? brandId;
  DateTime? date;


  AddBrand(
      {this.brand,
        this.head,
        this.couponColorCode,
        this.content,
        this.venderId,
        this.imageList,
        this.galaryimage,
        this.banner,
        this.imageUrl,
        // this.featureName,
        this.youTube,
        this.commissionPer,
        this.percentage,
        this.branchId,
        this.color,
this.delete,
        this.status,
        this.brandId,
        this.date,

        this.Brandaffiliate});

  AddBrand.fromJson(Map<String, dynamic> json) {
    brand = json["brand"];
    head = json["head"];
    couponColorCode = json["couponColorCode"];
    content = json["content"];
    //featureName = json["featureName"];
    venderId = json["venderId"];
    imageList = json["imageList"];
    galaryimage = json["galaryimage"];
    banner = json["banner"];
    imageUrl = json["imageUrl"];
    Brandaffiliate = json["affiliatedProgram"];
    youTube = json["youTube"];
    commissionPer = json["commissionPer"];
    percentage = json["percentage"];
    branchId = json["branchId"];
    color = json["color"];
    delete = json["delete"];
    status = json["status"];
    brandId = json["brandId"];
    date = json["date"].toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["brand"] = brand?? "";
    data["head"] = head ?? "";
    data["couponColorCode"] = couponColorCode ?? "";
    data["content"] = content ?? "";
    // data["featureName"] = featureName ?? "";
    data["venderId"] = venderId ?? "";
    data["imageList"] = imageList ?? [];
    data["galaryimage"] = galaryimage ?? [];
    data["imageUrl"]=imageUrl ??"";
    data["banner"]=banner ??"";
    data["affiliatedProgram"]=Brandaffiliate ??"";
    data["youTube"]=youTube ??"";
    data["commissionPer"]=commissionPer ??"";
    data["percentage"]=percentage ??"";
    data["branchId"]=branchId ??"";
    data["color"]=color ??"";
    data["delete"]=delete ??"";
    data["status"]=status ??"";
    data["brandId"]=brandId ??"";
    data["date"]=date ??"";
    return data;
  }

  AddBrand copyWith({
    String? brand,
    String? color,
    String? head,
    String? couponColorCode,
    String? content,
    // String? featureName,
    String? venderId,
    List? imageList,
    List? galaryimage,
    String? imageUrl,
    String? banner,
    List? youTube,
    //int? commissionPer,
    String? commissionPer,
    String? percentage,
    String? branchId,
    bool? delete,
    bool?Brandaffiliate,
    int? status,
    String? brandId,
    DateTime? date,

  }) {
    return AddBrand(
      brand: brand ?? this.brand,
      head: head ?? this.head,
      couponColorCode: couponColorCode ?? this.couponColorCode,
      content: content ?? this.content,
      venderId: venderId ?? this.venderId,
      imageList: imageList ?? this.imageList,
      galaryimage: galaryimage ?? this.galaryimage,
      banner: banner??this.banner,
      imageUrl: imageUrl??this.imageUrl,
      Brandaffiliate: Brandaffiliate ?? this.Brandaffiliate,
      youTube:  youTube ?? this. youTube,
      commissionPer:  commissionPer ?? this. commissionPer,
      percentage:  percentage ?? this. percentage,
      branchId:  branchId ?? this. branchId,
      color:  color ?? this. color,
      delete:  delete ?? this. delete,
      status:  status ?? this. status,
      brandId:  brandId ?? this. brandId,
      date:  date ?? this. date,
    );
    // featureName: featureName ?? this.featureName,);
  }
}