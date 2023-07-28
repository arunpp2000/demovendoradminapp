AddProductModel? Product;

class AddProductModel {
  bool? available;
  bool? b2b;
  double? b2bD;
  bool? b2c;
  //bool? sale;
  bool? imported;
  bool? payOnDelivery;
  bool? nonveg;
  bool? veg;
  List? videoUrl;
  bool? delete;
  String? sellername;
  String? name;
  String? productCode;
  String? instructions;
  double? weight;
  int? stock;
  int? hsnCode;
  int? sold;
  String? description;
  String? brand;
  String? category;

  String? ingredients;
  String? fact;

  String? madeFrom;
  double? gst;
  double? b2cP;
  double? b2bP;
  double? b2cD;


  // String? variants1Lprice;
  // String? variants1Lsku;
  // String? variants1Lstockqut;
  String? productId;
  DateTime? date;
  DateTime? acceptedDate;
  // String? variants2Lprice;
  // String? variants2Lsku;
  // String? variants2Lstockqut;
  //Map<String, dynamic>? media;
  //Map<String, dynamic>? productcolor;
  // bool? enableaffiliate;
  // double? commission;
  // int? commissiontext;
  int? status;
  String? vendorId;
  String? categoryName;

  //bool? exchangable;
  // bool? expirable;
  // bool? liquidContents;
  //bool? giftWrap;
  // String? expireType;
  //String? heatSensitive;
  //double? giftWrapCharge;
  double? b2bDelhiD;
  double? b2cDelhiD;
  double? b2bDelhiP;
  double? b2cDelhiP;
  List? b2bDelhiTier;
  List? b2cDelhiTier;
  double? b2bKeralaD;
  double? b2cKeralaD;
  double? b2bKeralaP;
  double? b2cKeralaP;
  List? b2bKeralaTier;
  List? b2cKeralaTier;
  double? b2bTamilnaduD;
  double? b2cTamilnaduD;
  double? b2bTamilnaduP;
  double? b2cTamilnaduP;
  List? b2bTamilnaduTier;
  List? b2cTamilnaduTier;
  List? b2bNorthEast1Tier;
  List? b2cNorthEast1Tier;
  double? b2bNorthEast1D;
  double? b2cNorthEast1D;
  double? b2bNorthEast1P;
  double? b2cNorthEast1P;
  List? b2bTier;
  List? b2cTier;
  String? branchId;
  int? fives;
  int? fours;
  List? imageId;
  int? ones;
  bool? open;
  List? relatedProducts;
  bool? sales;
  List? search;
  int? start;
  int? step;
  int? stop;
  int? threes;
  int? totalReviews;
  int? twos;
  String? userId;


  AddProductModel({
    this.b2c,
    this.b2b,
    //this.sale,
    this.imported,
    this.payOnDelivery,
    this.nonveg,
    this.veg,
    this.videoUrl,
    this.b2bD,
    this.b2bP,
    this.date,
    this.acceptedDate,
    this.delete,

    this.sellername,
    this.name,
    this.productCode,
    this.productId,
    // this.unit,
    this.weight,
    //this.media,
    this.stock,
    this.hsnCode,
    this.sold,
    this.description,

    this.brand,
    this.category,
    this.ingredients,
    this.fact,
    this.instructions,

    this.madeFrom,

    this.gst,
    this.b2cP,
    this.b2cD,

    this.status,
    this.vendorId,

    this.available,
    this.categoryName,

    this.b2bDelhiD,
    this.b2cDelhiD,
    this.b2bDelhiP,
    this.b2cDelhiP,
    this.b2bDelhiTier,
    this.b2cDelhiTier,
    this.b2bKeralaD,
    this.b2cKeralaD,
    this.b2bKeralaP,
    this.b2cKeralaP,
    this.b2bKeralaTier,
    this.b2cKeralaTier,
    this.b2bTamilnaduD,
    this.b2cTamilnaduD,
    this.b2bTamilnaduP,
    this.b2cTamilnaduP,
    this.b2bTamilnaduTier,
    this.b2cTamilnaduTier,
    this.b2bNorthEast1P,
    this.b2cNorthEast1P,
    this.b2bNorthEast1D,
    this.b2cNorthEast1D,
    this.b2bNorthEast1Tier,
    this.b2cNorthEast1Tier,
    this.b2bTier,
    this.b2cTier,
    this.branchId,
    this.fives,
    this.fours,
    this.imageId,
    this.ones,
    this.open,
    this.relatedProducts,
    this.sales,
    this.search,
    this.start,
    this.step,
    this.stop,
    this.threes,
    this.totalReviews,
    this.twos,
    this.userId,
  });

  AddProductModel.fromJson(Map<String, dynamic> json) {
    b2c = json["b2c"];
    b2b = json["b2b"];
    // sale = json["sale"];
    imported = json["imported"];
    payOnDelivery = json["payOnDelivery"];
    delete = json["delete"];
    nonveg = json["nonveg"];
    veg = json["veg"];
    sellername = json["sellerName"];
    name = json["name"];
    productCode = json["productCode"];
    // productbarcode = json["productBarcode"];
    // moq = json["moq"];
    // unit = json["unit"];
    weight = double.tryParse(json["weight"].toString())??0;
    stock = int.tryParse(json["stock"].toString())??0;
    hsnCode = int.tryParse(json["hsnCode"].toString())??0;
    // warranty = json["warranty"];
    // guaranty = json["guaranty"];
    sold = int.tryParse(json["sold"].toString())??0;

    description = json["description"];
    videoUrl = json["videoUrl"];
    //productdescription = json["productDescription"];
    date = json["date"]==null?DateTime.now():json["date"].toDate();
    acceptedDate = json["acceptedDate"]==null?DateTime.now():json["acceptedDate"].toDate();
    brand = json["brand"];
    category = json["category"];
    ingredients = json["ingredients"];
    fact = json["fact"];
    instructions = json["intructions"];
    // fssailicno = json["fssaiLicno "];
    // shelflife = json["shelfLife"];
    madeFrom = json["madeFrom"];
    relatedProducts=json["relatedProducts"];
    // color = json["color"];
    // attributes = json["attributes"];
    // attributesvalue = json["attributesValue"];
    gst = double.tryParse(json["gst"].toString())??0;
    b2cP = double.tryParse(json["b2cP"].toString())??0;
    b2bP = double.tryParse(json["b2bP"].toString())??0;
    b2cD = double.tryParse(json["b2cD"].toString())??0;
    b2bD = double.tryParse(json["b2bD"].toString())??0;
    status = int.tryParse(json["status"].toString())??0;
    productId = json["productId"];
    vendorId = json["vendorId"];
    available = json["available"];
    categoryName = json["categoryName"];
    b2bDelhiD = double.tryParse(json["b2bDelhiD"].toString())??0;
    b2cDelhiD = double.tryParse(json["b2cDelhiD"].toString())??0;
    b2bDelhiP = double.tryParse(json["b2bDelhiP"].toString())??0;
    b2cDelhiP = double.tryParse(json["b2cDelhiP"].toString())??0;
    b2bDelhiTier = json["b2bDelhiTier"];
    b2cDelhiTier = json["b2cDelhiTier"];
    b2bKeralaD = double.tryParse(json["b2bKeralaD"].toString())??0;
    b2cKeralaD = double.tryParse(json["b2cKeralaD"].toString())??0;
    b2bKeralaP = double.tryParse(json["b2bKeralaP"].toString())??0;
    b2cKeralaP = double.tryParse(json["b2cKeralaP"].toString())??0;
    b2bKeralaTier = json["b2bKeralaTier"];
    b2cKeralaTier = json["b2cKeralaTier"];
    b2bTamilnaduD = double.tryParse(json["b2bTamilnaduD"].toString())??0;
    b2cTamilnaduD = double.tryParse(json["b2cTamilnaduD"].toString())??0;
    b2bTamilnaduP = double.tryParse(json["b2bTamilnaduP"].toString())??0;
    b2cTamilnaduP = double.tryParse(json["b2cTamilnaduP"].toString())??0;
    b2bTamilnaduTier = json["b2bTamilnaduTier"];
    b2cTamilnaduTier = json["b2cTamilnaduTier"];
    b2bNorthEast1D = double.tryParse(json["b2bNorthEast1D"].toString())??0;
    b2cNorthEast1D = double.tryParse(json["b2cNorthEast1D"].toString())??0;
    b2bNorthEast1P = double.tryParse(json["b2bNorthEast1P"].toString())??0;
    b2cNorthEast1P = double.tryParse(json["b2cNorthEast1P"].toString())??0;
    b2bNorthEast1Tier = json["b2bNorthEast1Tier"];
    b2cNorthEast1Tier = json["b2cNorthEast1Tier"];



    b2bTier = json["b2bTier"];
    b2cTier = json["b2cTier"];
    branchId = json["branchId"];
    fives = int.tryParse(json["fives"].toString())??0;
    fours = int.tryParse(json["fours"].toString())??0;
    imageId = json["imageId"];
    ones = int.tryParse(json["ones"].toString())??0;
    open = json["open"];
    sales = json["sales"];
    search = json["search"];
    start = int.tryParse(json["start"].toString())??0;
    step = int.tryParse(json["step"].toString())??0;
    stop = int.tryParse(json["stop"].toString())??0;
    threes = int.tryParse(json["threes"].toString())??0;
    totalReviews = int.tryParse(json["totalReviews"].toString())??0;
    twos = int.tryParse(json["twos"].toString())??0;
    userId = json["userId"];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["b2c"] = b2c ?? false;
    data["productId"]=productId??"";
    data["delete"] = delete ?? false;
    data["b2b"] = b2b ?? false;
    //data["sale"] = sale ?? "";
    data["date"] = date ??DateTime.now();
    data["acceptedDate"] = acceptedDate ??DateTime.now();
    data["imported"] = imported ??false;
    data["payOnDelivery"] = payOnDelivery ?? false;
    data["nonveg"] = nonveg ?? false;
    data["veg"] = veg ?? false;
    data["videoUrl"] = videoUrl ?? [];
    data["sellerName"] = sellername ?? "";
    data["name"] = name ?? "";
    data["productCode"] = productCode ?? "";
    data["weight"] = weight ?? 0;
    data["stock"] = stock ?? 0;
    data["hsnCode"] = hsnCode ?? 0;
    data["sold"] = sold ?? 0;
    data["description"] = description ?? "";
    data["brand"] = brand ?? [];
    data["category"] = category ?? [];
    data["ingredients"] = ingredients ?? "";
    data["fact"] = fact ?? "";
    data["intructions"] = instructions ?? "";
    data["madeFrom"] = madeFrom ?? "";
    data["gst"] = gst ?? 0;
    data["b2cP"] = b2cP ?? 0;
    data["b2bP"] = b2bP ?? 0;
    data["b2cD"] = b2cD ?? 0;
    data["b2bD"] = b2bD ?? 0;
    data["vendorId"] = vendorId ?? "";
    data["status"] = status;
    data["available"] = available ?? false;
    data["b2bDelhiD"] = b2bDelhiD ?? 0;
    data["b2cDelhiD"] = b2cDelhiD ?? 0;
    data["b2bDelhiP"] = b2bDelhiP ?? 0;
    data["b2cDelhiP"] = b2cDelhiP ?? 0;
    data["b2bDelhiTier"] = b2bDelhiTier ?? [];
    data["b2cDelhiTier"] = b2cDelhiTier ?? [];
    data["b2bKeralaD"] = b2bKeralaD ?? 0;
    data["b2cKeralaD"] = b2cKeralaD ?? 0;
    data["b2bKeralaP"] = b2bKeralaP ?? 0;
    data["b2cKeralaP"] = b2cKeralaP ?? 0;
    data["b2bKeralaTier"] = b2bKeralaTier ?? [];
    data["b2cKeralaTier"] = b2cKeralaTier ?? [];
    data["b2bTamilnaduD"] = b2bTamilnaduD ?? 0;
    data["b2cTamilnaduD"] = b2cTamilnaduD ?? 0;
    data["b2bTamilnaduP"] = b2bTamilnaduP ?? 0;
    data["b2cTamilnaduP"] = b2cTamilnaduP ?? 0;
    data["b2bTamilnaduTier"] = b2bTamilnaduTier ?? [];
    data["b2cTamilnaduTier"] = b2cTamilnaduTier ?? [];
    data["b2bTier"] = b2bTier ?? [];
    data["b2bNorthEast1Tier"] = b2bNorthEast1Tier ?? [];
    data["b2cNorthEast1Tier"] = b2cNorthEast1Tier ?? [];
    data["b2bNorthEast1P"] = b2bNorthEast1P ?? 0;
    data["b2cNorthEast1P"] = b2cNorthEast1P ?? 0;
    data["b2bNorthEast1D"] = b2bNorthEast1D ?? 0;
    data["b2cNorthEast1D"] = b2cNorthEast1D ?? 0;
    data["b2cTier"] = b2cTier ?? [];
    data["branchId"] = branchId ?? "";
    data["fives"] = fives ?? 0;
    data["fours"] = fours ?? 0;
    data["imageId"] = imageId ?? [];
    data["ones"] = ones ?? 0;
    data["open"] = open ?? false;
    data["relatedProducts"] = relatedProducts ?? [];
    data["sales"] = sales ?? false;
    data["search"] = search ?? [];
    data["start"] = start ?? 0;
    data["step"] = step ?? 0;
    data["stop"] = stop ?? 0;
    data["threes"] = threes ?? 0;
    data["totalReviews"] = totalReviews ?? 0;
    data["twos"] = twos ?? 0;
    data["userId"] = userId ?? "";

    return data;
  }

  AddProductModel copyWith({
    bool? b2c,
    bool? b2b,
    // bool? sale,
    bool? imported,
    bool? payOnDelivery,
    bool? nonveg,
    bool? veg,
    bool? delete,

    List? videoUrl,
    String? sellername,
    String? name,
    String? productCode,
    String? productbarcode,
    DateTime? date,
    DateTime? acceptedDate,
    double? weight,
    int? stock,
    int? hsnCode,

    int? sold,
    String? productId,
    String? description,
    String? brand,
    String? category,
    String? ingredients,
    String? fact,
    String? instructions,
    //String? fssailicno,
    //String? shelflife,
    String? madeFrom,
    double? gst,
    double? b2cP,
    double? b2bP,
    double? b2cD,
    double? b2bD,

    String? vendorId,
    int? status,

    bool? available,
    String? categoryName,

    double? b2bDelhiD,
    double? b2cDelhiD,
    double? b2bDelhiP,
    double? b2cDelhiP,
    List? b2bDelhiTier,
    List? b2cDelhiTier,
    double? b2bKeralaD,
    double? b2cKeralaD,
    double? b2bKeralaP,
    double? b2cKeralaP,
    List? b2bKeralaTier,
    List? b2cKeralaTier,
    double? b2bTamilnaduD,
    double? b2cTamilnaduD,
    double? b2bTamilnaduP,
    double? b2cTamilnaduP,
    List? b2bTamilnaduTier,
    List? b2cTamilnaduTier,
    double? b2bNorthEast1P,
    double? b2cNorthEast1P,
    double? b2bNorthEast1D,
    double? b2cNorthEast1D,
    List? b2bNorthEast1Tier,
    List? b2cNorthEast1Tier,
    List? b2bTier,
    List? b2cTier,
    String? branchId,
    int? fives,
    int? fours,
    List? imageId,
    int? ones,
    bool? open,
    List? relatedProducts,
    bool? sales,
    List? search,
    int? start,
    int? step,
    int? stop,
    int? threes,
    int? totalReviews,
    int? twos,
    String? userId,
  }) {
    return AddProductModel(
        b2c: b2c ?? this.b2c,
        b2b: b2b ?? this.b2b,
        //sale: sale ?? this.sale,
        delete: delete ?? this.delete,
        imported: imported ?? this.imported,
        payOnDelivery: payOnDelivery ?? this.payOnDelivery,
        nonveg: nonveg ?? this.nonveg,
        veg: veg ?? this.veg,
        status: status ?? this.status,
        sellername: sellername ?? this.sellername,
        name: name ?? this.name,
        productCode: productCode ?? this.productCode,
        // productbarcode: productbarcode ?? this.productbarcode,
        // moq: moq ?? this.moq,
        // unit: unit ?? this.unit,
        weight: weight ?? this.weight,
        stock: stock ?? this.stock,
        hsnCode: hsnCode ?? this.hsnCode,

        sold: sold ?? this.sold,

        description: description ?? this.description,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        ingredients: ingredients ?? this.ingredients,
        instructions: instructions ?? this.instructions,

        madeFrom: madeFrom ?? this.madeFrom,
        date: date??this.date,
        acceptedDate: acceptedDate??this.acceptedDate,

        gst: gst ?? this.gst,
        b2cP: b2cP ?? this.b2cP,
        b2bP: b2bP ?? this.b2bP,
        b2cD: b2cD ?? this.b2cD,
        vendorId: vendorId ?? this.vendorId,
        productId: productId ?? this.productId,
        // productcolor: productcolor ?? this.productcolor,
        available: available ?? this.available,
        fact: fact ?? this.fact,
        categoryName: categoryName ?? this.categoryName,

        b2bDelhiD: b2bDelhiD ?? this.b2bDelhiD,
        b2cDelhiD: b2cDelhiD ?? this.b2cDelhiD,
        b2bDelhiP: b2bDelhiP ?? this.b2bDelhiP,
        b2cDelhiP: b2cDelhiP ?? this.b2cDelhiP,
        b2bDelhiTier: b2bDelhiTier ?? this.b2bDelhiTier,
        b2cDelhiTier: b2cDelhiTier ?? this.b2cDelhiTier,
        b2bKeralaD: b2bKeralaD ?? this.b2bKeralaD,
        b2cKeralaD: b2cKeralaD ?? this.b2cKeralaD,
        b2bKeralaP: b2bKeralaD ?? this.b2bKeralaP,
        b2cKeralaP: b2cKeralaD ?? this.b2cKeralaP,
        b2bKeralaTier: b2bKeralaTier ?? this.b2bKeralaTier,
        b2cKeralaTier: b2cKeralaTier ?? this.b2cKeralaTier,
        b2bTamilnaduD: b2bTamilnaduD ?? this.b2bTamilnaduD,
        b2cTamilnaduD: b2cTamilnaduD ?? this.b2cTamilnaduD,
        b2cNorthEast1D: b2cNorthEast1D ?? this.b2cNorthEast1D,
        b2bNorthEast1D: b2bNorthEast1D ?? this.b2bNorthEast1D,
        b2bTamilnaduP: b2bTamilnaduP ?? this.b2bTamilnaduP,
        b2cTamilnaduP: b2cTamilnaduP ?? this.b2cTamilnaduP,
        b2cNorthEast1P: b2cNorthEast1P ?? this.b2cNorthEast1P,
        b2bNorthEast1P: b2bNorthEast1P ?? this.b2bNorthEast1P,
        b2bTamilnaduTier: b2bTamilnaduTier ?? this.b2bTamilnaduTier,
        b2cTamilnaduTier: b2cTamilnaduTier ?? this.b2cTamilnaduTier,
        b2bTier: b2bTier ?? this.b2bTier,
        b2cTier: b2cTier ?? this.b2cTier,
        b2cNorthEast1Tier: b2cNorthEast1Tier ?? this.b2cNorthEast1Tier,
        b2bNorthEast1Tier: b2bNorthEast1Tier ?? this.b2bNorthEast1Tier,
        branchId: branchId ?? this.branchId,

        fives: fives ?? this.fives,
        fours: fours ?? this.fours,
        imageId: imageId ?? this.imageId,
        videoUrl: videoUrl ?? this.videoUrl,
        ones: ones ?? this.ones,
        open: open ?? this.open,
        relatedProducts: relatedProducts ?? this.relatedProducts,
        sales: sales ?? this.sales,
        search: search ?? this.search,
        start: start ?? this.start,
        step: step ?? this.step,
        stop: stop ?? this.stop,
        threes: threes ?? this.threes,
        totalReviews: threes ?? this.totalReviews,
        twos: twos ?? this.twos,
        userId: userId ?? this.userId);

  }
}
