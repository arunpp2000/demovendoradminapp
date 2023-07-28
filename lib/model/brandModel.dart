AddBrand? currentBrand = AddBrand();

class AddBrand {
  String? branchId;
  String? color;
  String? brand;
  String? head;
  int? referNo;
  String? content;
  String? venderId;
  List? imageList;
  List? galleryImage;
  String? imageUrl;
  String? banner;
  // bool? Brandaffiliate;
  List? youTube;
  // String? commissionPer;
  // double? percentage;
  bool? delete;
  int? status;
  String? brandId;
  DateTime? date;
  DateTime? acceptedDate;
  DateTime? rejectedDate;

  AddBrand(
      {
        this.brand,
        this.head,
        this.content,
        this.venderId,
        this.imageList,
        this.galleryImage,
        this.banner,
        this.imageUrl,
        this.youTube,
        // this.commissionPer,
        // this.percentage,
        this.branchId,
        this.color,
        this.delete,
        this.status,
        this.brandId,
        // this.Brandaffiliate,
        this.date,
        this.acceptedDate,
        this.rejectedDate,
        this.referNo,
      });

  AddBrand.fromJson(Map<String, dynamic> json) {
    brand = json["brand"];
    head = json["head"];
    // couponColorCode = json["couponColorCode"];
    content = json["content"];
    //featureName = json["featureName"];
    venderId = json["vendorId"];
    imageList = json["imageList"];
    galleryImage = json["galleryImage"];
    banner = json["banner"];
    imageUrl = json["imageUrl"];
    // Brandaffiliate = json["affiliatedProgram"];
    youTube = json["youTube"];
    // commissionPer = json["commissionPer"];
    //  percentage = json["percentage"];
    branchId = json["branchId"];
    color = json["color"];
    delete = json["delete"];
    status = json["status"];
    brandId = json["brandId"];
    // date = json["date"].toDate();
    // acceptedDate = json["acceptedDate"].toDate();
    date = json["date"]==null?DateTime.now():json["date"].toDate();
    acceptedDate = json["acceptedDate"]==null?DateTime.now():json["acceptedDate"].toDate();
    rejectedDate = json["rejectedDate"]==null?DateTime.now():json["rejectedDate"].toDate();
    referNo = int.tryParse(json["referNo"].toString())??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["brand"] = brand?? "";
    data["head"] = head ?? "";
    // data["couponColorCode"] = couponColorCode ?? "";
    data["content"] = content ?? "";
    // data["featureName"] = featureName ?? "";
    data["vendorId"] = venderId ?? "";
    data["imageList"] = imageList ?? [];
    data["galleryImage"] = galleryImage ?? [];
    data["imageUrl"]=imageUrl ??"";
    data["banner"]=banner ??"";
    // data["affiliatedProgram"]=Brandaffiliate ??"";
    data["youTube"]=youTube ??"";
    // data["commissionPer"]=commissionPer ??"";
    //  data["percentage"]=percentage ??"";
    data["branchId"]=branchId ??"";
    data["color"]=color ??"";
    data["delete"]=delete ??false;
    data["status"]=status ??0;
    data["brandId"]=brandId ??"";
    data["date"]=date ??DateTime.now();
    data["acceptedDate"]=acceptedDate ??DateTime.now();
    data["rejectedDate"]=rejectedDate ??DateTime.now();
    data["referNo"]=referNo;
    return data;
  }

  AddBrand copyWith({
    String? brand,
    String? color,
    String? head,
    // String? couponColorCode,
    String? content,
    // String? featureName,
    String? venderId,
    List? imageList,
    List? galleryImage,
    String? imageUrl,
    String? banner,
    List? youTube,
    // String? commissionPer,
    // double? percentage,
    String? branchId,
    bool? delete,
    // bool? Brandaffiliate,
    int? status,
    String? brandId,
    DateTime? date,
    DateTime? rejectedDate,
    DateTime? acceptedDate,
    int? referNo,

  }) {
    return AddBrand(
      brand: brand ?? this.brand,
      head: head ?? this.head,
      // couponColorCode: couponColorCode ?? this.couponColorCode,
      content: content ?? this.content,
      venderId: venderId ?? this.venderId,
      imageList: imageList ?? this.imageList,
      galleryImage: galleryImage ?? this.galleryImage,
      banner: banner??this.banner,
      imageUrl: imageUrl??this.imageUrl,
      // Brandaffiliate: Brandaffiliate ?? this.Brandaffiliate,
      youTube:  youTube ?? this. youTube,
      // commissionPer:  commissionPer ?? this. commissionPer,
      //  percentage:  percentage ?? this. percentage,
      branchId:  branchId ?? this. branchId,
      color:  color ?? this. color,
      delete:  delete ?? this. delete,
      status:  status ?? this. status,
      brandId:  brandId ?? this. brandId,
      date:  date ?? this. date,
      rejectedDate:  rejectedDate ?? this. rejectedDate,
      acceptedDate:  acceptedDate ?? this. acceptedDate,
      referNo:  referNo ?? this. referNo,
    );
    // featureName: featureName ?? this.featureName,);
  }
}
