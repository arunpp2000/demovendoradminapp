AddProductModel? Product;

class AddProductModel {
  bool? b2c;
  bool? b2b;
  bool? sale;
  bool? imported;
  bool? payOnDelivery;
  bool? nonveg;
  bool? veg;
  bool? Returnable;
  bool? cancellable;
  bool? refundable;
  bool? barcode;
  bool? warranty;
  bool? guaranty;
  bool? variableproduct;
  bool? managestock;
  bool? minimumqty;
  bool? qtylimit;
  String? sellername;
  String? name;
  String? productCode;
  String? productbarcode;
  String? moq;
  String? unit;
  int? weight;
  int? stock;
  int? hsnCode;
  String? prowarranty;
  String? proGuaranty;
  int? sold;
  int? qutlimit;
  double? productdimensionL;
  double? productdimensionB;
  double? productdimensionH;
  String? description;
  String? brand;
  String? category;
  String? subcategory;
  String? childcategory;
  String? ingredients;
  String? fact;
  String? intructions;
  String? fssailicno;
  String? shelflife;
  String? madeFrom;
  String? color;
  String? attributes;
  String? attributesvalue;
  int? gst;
  double? b2cP;
  double? b2cD;
  String? variants1Lprice;
  String? variants1Lsku;
  String? variants1Lstockqut;
  String? productId;
  DateTime? date;
  String? variants2Lprice;
  String? variants2Lsku;
  String? variants2Lstockqut;
  Map<String, dynamic>? media;
  Map<String,dynamic>? productcolor;
  bool? enableaffiliate;
  double? commission;
  int? commissiontext;
  int? status;
  String? vendorId;
  String? categoryName;
  bool? available;
  bool? exchangable;
  bool? expirable;
  bool? liquidContents;
  bool? giftWrap;
  String? expireType;
  String? heatSensitive;
  double? giftWrapCharge;

  double? b2bDelhiD;
  double? b2bDelhiP;
  List? b2bDelhiTier;
  double? b2bKeralaD;
  double? b2bKeralaP;
  List? b2bKeralaTier;
  double? b2bTamilnaduD;
  double? b2bTamilnaduP;
  List? b2bTamilnaduTier;
  List? b2bTier;
  String? branchId;
  double? fives;
  double? fours;
  List? imageId;
  double? ones;
  bool? open;
  List? relatedProducts;
  bool? sales;
  List? search;
  double? start;
  double? step;
  double? stop;
  double? threes;
  double? totalReviews;
  double? twos;
  String? userId;
  List? videoUrl;



  AddProductModel(
      {this.b2c,
        this.b2b,
        this.sale,
        this.imported,
        this.payOnDelivery,
        this.nonveg,
        this.veg,
        this.Returnable,
        this.cancellable,
        this.refundable,
        this.barcode,
        this.warranty,
        this.guaranty,
        this.variableproduct,
        this.managestock,
        this.date,
        this.minimumqty,
        this.qtylimit,
        this.sellername,
        this.name,
        this.productCode,
        this.productbarcode,
        this.moq,
        this.productId,
        this.unit,
        this.weight,
        this.media,
        this.stock,
        this.hsnCode,
        this.prowarranty,
        this.proGuaranty,
        this.sold,
        this.qutlimit,
        this.description,
        this.productdimensionL,
        this.productdimensionB,
        this.productdimensionH,
        this.brand,
        this.category,
        this.subcategory,
        this.childcategory,
        this.ingredients,
        this.fact,
        this.intructions,
        this.fssailicno,
        this.shelflife,
        this.madeFrom,
        this.color,
        this.attributes,
        this.attributesvalue,
        this.gst,
        this.b2cP,
        this.b2cD,
        this.variants1Lprice,
        this.variants1Lsku,
        this.variants1Lstockqut,
        this.variants2Lprice,
        this.variants2Lsku,
        this.variants2Lstockqut,
        this.enableaffiliate,
        this.commission,
        this.commissiontext,
        this.status,
        this.vendorId,
        this.productcolor,
        this.available,
        this.categoryName,
        this.exchangable,
        this.expirable,
        this.liquidContents,
        this.giftWrap,
        this.expireType,
        this.heatSensitive,
        this.giftWrapCharge,

        this.b2bDelhiD,
        this.b2bDelhiP,
        this.b2bDelhiTier,
        this.b2bKeralaD,
        this.b2bKeralaP,
        this.b2bKeralaTier,
        this.b2bTamilnaduD,
        this.b2bTamilnaduP,
        this.b2bTamilnaduTier,
        this.b2bTier,
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
        this.videoUrl,
      });
  AddProductModel.fromJson(Map<String, dynamic> json) {
    b2c = json["b2c"];
    b2b = json["b2b"];
    sale = json["sale"];
    imported = json["imported"];
    payOnDelivery = json["payOnDelivery"];
    nonveg = json["non veg"];
    veg = json["veg"];
    refundable = json["refundable"];
    cancellable = json["cancellable"];
    refundable = json["refundable"];
    barcode = json["barcode"];
    warranty = json["warranty"];
    guaranty = json["guaranty"];
    variableproduct = json["variableProduct"];
    managestock = json["manageStock"];
    minimumqty = json["minimumQty"];
    qtylimit = json["qtyLimit"];
    sellername = json["sellerName"];
    name = json["name"];
    productCode = json["productCode"];
    productbarcode = json["productBarcode"];
    moq = json["moq"];
    unit = json["unit"];
    weight = json["weight"];
    stock = json["stock"];
    hsnCode = json["hsnCode"];
    warranty = json["warranty"];
    guaranty = json["guaranty"];
    sold = json["sold"];
    qutlimit = json["qutLimit"];
    productdimensionL = json["productDimensionL"];
    productdimensionB = json["productDimensionB"];
    productdimensionH = json["productDimensionH"];
    description = json["description"];
    //productdescription = json["productDescription"];
    date = json["date"];
    brand = json["brand"];
    category = json["category"];
    subcategory = json["subCategory"];
    childcategory = json["childCategory"];
    ingredients = json["ingredients"];
    fact = json["fact"];
    intructions = json["intructions"];
    fssailicno = json["fssaiLicno "];
    shelflife = json["shelfLife"];
    madeFrom = json["madeFrom"];
    color = json["color"];
    attributes = json["attributes"];
    attributesvalue = json["attributesValue"];
    gst = json["gst"];
    b2cP = json["b2cP"];
    b2cD = json["b2cD"];
    variants1Lprice = json["variants1LPrice"];
    variants1Lsku = json["variants1LSku"];
    variants1Lstockqut = json["variants1LStock"];
    variants2Lprice = json["variants2LPtice"];
    variants2Lsku = json["variants2LSku"];
    variants2Lstockqut = json["variants2LStockQty"];
    enableaffiliate = json["enableAffiliate"];
    commission = json["commission"];
    commissiontext = json["commissionText"];
    status = json["status"];
    media = json["media"];
    productcolor=json["productColor"];
    productId = json["productId"];
    vendorId = json["vendorId"];
    available = json["available"];
    categoryName = json["categoryName"];
    exchangable = json["exchangable"];
    expirable = json["expirable"];
    liquidContents = json["liquidContents"];
    giftWrap = json["giftWrap"];
    expireType = json["expireType"];
    heatSensitive = json["heatSensitive"];
    giftWrapCharge = json["giftWrapCharge"];

    b2bDelhiD = json["b2bDelhiD"];
    b2bDelhiP = json["b2bDelhiP"];
    b2bDelhiTier = json["b2bDelhiTier"];
    b2bKeralaD = json["b2bKeralaD"];
    b2bKeralaP = json["b2bKeralaP"];
    b2bKeralaTier = json["b2bKeralaTier"];
    b2bTamilnaduD = json["b2bTamilnaduD"];
    b2bTamilnaduP = json["b2bTamilnaduP"];
    b2bTamilnaduTier = json["b2bTamilnaduTier"];
    b2bTier = json["b2bTier"];
    branchId = json["branchId"];
    fives = json["fives"];
    fours = json["fours"];
    imageId = json["imageId"];
    ones = json["ones"];
    open = json["open"];
    sales = json["sales"];
    search = json["search"];
    start = json["start"];
    step = json["step"];
    stop = json["stop"];
    threes = json["threes"];
    totalReviews = json["totalReviews"];
    twos = json["twos"];
    userId = json["userId"];
    videoUrl = json["videoUrl"];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["b2c"] = b2c ?? "";
    data["b2b"] = b2b ?? "";
    data["sale"] = sale ?? "";
    data["date"] = date ?? "";
    data["imported"] = imported ?? "";
    data["payOnDelivery"] = payOnDelivery ?? "";
    data["nonveg"] = nonveg ?? "";
    data["veg"] = veg ?? "";
    data["Returnable"] = Returnable ?? "";
    data["cancellable"] = cancellable ?? "";
    data["refundable"] = refundable ?? "";
    data["barcode"] = barcode ?? "";
    data["warranty"] = warranty ?? "";
    data["guaranty"] = guaranty ?? "";
    data["variableProduct"] = variableproduct ?? "";
    data["manageStock"] = managestock ?? "";
    data["minimumQty"] = minimumqty ?? "";
    data["qtyLimit"] = qtylimit ?? "";
    data["sellerName"] = sellername ?? "";
    data["name"] = name ?? "";
    data["productCode"] = productCode ?? "";
    data["productBarcode"] = productbarcode ?? "";
    data["moq"] = moq ?? "";
    data["unit"] = unit ?? "";
    data["weight"] = weight ?? "";
    data["stock"] = stock ?? "";
    data["hsnCode"] = hsnCode ?? "";
    data["warranty"] = warranty ?? "";
    data["guaranty"] = guaranty ?? "";
    data["sold"] = sold ?? "";
    data["qutLimit"] = qutlimit ?? "";
    data["productDimensionL"] = productdimensionL ?? "";
    data["productDimensionB"] = productdimensionB ?? "";
    data["producDimensionH"] = productdimensionH ?? "";
    data["description"] = description ?? "";
    data["brand"] = brand ?? "";
    data["category"] = category ?? "";
    data["subCategory"] = subcategory ?? "";
    data["childCategory"] = childcategory ?? "";
    data["ingredients"] = ingredients ?? "";
    data["fact"] = fact ?? "";
    data["intructions"] = intructions ?? "";
    data["fssaiLicNo"] = fssailicno ?? "";
    data["shelfLife"] = shelflife ?? "";
    data["madeFrom"] = madeFrom ?? "";
    data["color"] = color ?? "";
    data["attributes"] = attributes ?? "";
    data["attributesValue"] = attributesvalue ?? "";
    data["gst"] = gst ?? "";
    data["b2cP"] = b2cP ?? "";
    data["b2cD"] = b2cD ?? "";
    data["variants1LPrice"] = variants1Lprice ?? "";
    data["variants1LSku"] = variants1Lsku ?? "";
    data["variants1LStockqty"] = variants1Lstockqut ?? "";
    data["variants2LPrice"] = variants2Lprice ?? "";
    data["variants2LSku"] = variants2Lsku ?? "";
    data["variants2LStockqty"] = variants2Lstockqut ?? "";
    data["enableAffiliate"] = enableaffiliate ?? "";
    data["commission"] = commission ?? "";
    data["commissionText"] = commissiontext ?? "";
    data["vendorId"] = vendorId ?? "";
    data["status"] = status ?? 0;
    data["media"] = media ?? {};
    data["productColor"] = productcolor ?? {};
    data["productId"] = productId ?? "";
    data["available"] = available ?? "";
    data["categoryName"] = categoryName ?? "";
    data["exchangable"] = exchangable ?? "";
    data["expirable"] = expirable ?? "";
    data["liquidContents"] = liquidContents ?? "";
    data["giftWrap"] = giftWrap ?? "";
    data["expireType"] = expireType ?? "";
    data["heatSensitive"] = heatSensitive ?? "";
    data["giftWrapCharge"] = giftWrapCharge ?? "";


    data["b2bDelhiD"] = b2bDelhiD ?? "";
    data["b2bDelhiP"] = b2bDelhiP ?? "";
    data["b2bDelhiTier"] = b2bDelhiTier ?? "";
    data["b2bKeralaD"] = b2bKeralaD ?? "";
    data["b2bKeralaP"] = b2bKeralaP ?? "";
    data["b2bKeralaTier"] = b2bKeralaTier ?? "";
    data["b2bTamilnaduD"] = b2bTamilnaduD ?? "";
    data["b2bTamilnaduP"] = b2bTamilnaduP ?? "";
    data["b2bTamilnaduTier"] = b2bTamilnaduTier ?? "";
    data["b2bTier"] = b2bTier ?? "";
    data["branchId"] = branchId ?? "";
    data["fives"] = fives ?? "";
    data["fours"] = fours ?? "";
    data["imageId"] = imageId ?? "";
    data["ones"] = ones ?? "";
    data["open"] = open ?? "";
    data["relatedProducts"] = relatedProducts ?? "";
    data["sales"] = sales ?? "";
    data["search"] = search ?? "";
    data["start"] = start ?? "";
    data["step"] = step ?? "";
    data["stop"] = stop ?? "";
    data["threes"] = threes ?? "";
    data["totalReviews"] = totalReviews ?? "";
    data["twos"] = twos ?? "";
    data["userId"] = userId ?? "";
    data["videoUrl"] = videoUrl ?? "";


    return data;
  }

  AddProductModel copyWith({
    bool? b2c,
    bool? b2b,
    bool? sale,
    bool? imported,
    bool? payOnDelivery,
    bool? nonveg,
    bool? veg,
    bool? Returnable,
    bool? cancellable,
    bool? refundable,
    bool? barcode,
    bool? warranty,
    bool? guaranty,
    bool? variableproduct,
    bool? managestock,
    bool? minimumqty,
    bool? qtylimit,
    String? sellername,
    String? name,
    String? productCode,
    String? productbarcode,
    String? moq,
    DateTime?date,
    String? unit,
    int? weight,
    int? stock,
    int? hsnCode,
    String? prowarranty,
    String? proGuaranty,
    int? sold,
    String? productId,
    int? qutlimit,
    double? productdimensionL,
    double? productdimensionB,
    double? productdimensionH,
    String? description,
    String? brand,
    String? category,
    String? subcategory,
    String? childcategory,
    String? ingredients,
    String? fact,
    String? instructions,
    String? fssailicno,
    String? shelflife,
    String? madeFrom,
    String? color,
    String? attributes,
    String? attributesvalue,
    int? gst,
    double? b2cP,
    double? b2cD,
    String? variants1Lprice,
    String? variants1Lsku,
    String? variants1Lstockqut,
    String? variants2Lprice,
    String? variants2Lsku,
    String? variants2Lstockqut,
    bool? enableaffiliate,
    double? commission,
    int? commissiontext,
    String? venderId,
    int? status,
    Map<String, dynamic>? media,
    Map<String, dynamic>? productcolor,
    bool? available,
    String? categoryName,
    bool? exchangable,
    bool? expirable,
    bool? giftWrap,
    bool? liquidContents,
    String? expireType,
    String? heatSensitive,
    double? giftWrapCharge,

    double? b2bDelhiD,
    double? b2bDelhiP,
    List? b2bDelhiTier,
    double? b2bKeralaD,
    double? b2bKeralaP,
    List? b2bKeralaTier,
    double? b2bTamilnaduD,
    double? b2bTamilnaduP,
    List? b2bTamilnaduTier,
    List? b2bTier,
    String? branchId,
    double? fives,
    double? fours,
    List? imageId,
    double? ones,
    bool? open,
    List? relatedProducts,
    bool? sales,
    List? search,
    double? start,
    double? step,
    double? stop,
    double? threes,
    double? totalReviews,
    double? twos,
    String? userId,
    List? videoUrl,
  }) {
    return AddProductModel(
      b2c: b2c ?? this.b2c,
      b2b: b2b ?? this.b2b,
      sale: sale ?? this.sale,
      imported: imported ?? this.imported,
      payOnDelivery: payOnDelivery ?? this.payOnDelivery,
      nonveg: nonveg ?? this.nonveg,
      veg: veg ?? this.veg,
      Returnable: Returnable ?? this.Returnable,
      cancellable: cancellable ?? this.cancellable,
      refundable: refundable ?? this.refundable,
      barcode: barcode ?? this.barcode,
      warranty: warranty ?? this.warranty,
      guaranty: guaranty ?? this.guaranty,
      variableproduct: variableproduct ?? this.variableproduct,
      managestock: managestock ?? this.managestock,
      minimumqty: minimumqty ?? this.minimumqty,
      qtylimit: qtylimit ?? this.qtylimit,
      sellername: sellername ?? this.sellername,
      name: name ?? this.name,
      productCode: productCode ?? this.productCode,
      productbarcode: productbarcode ?? this.productbarcode,
      moq: moq ?? this.moq,
      unit: unit ?? this.unit,
      weight: weight ?? this.weight,
      stock: stock ?? this.stock,
      hsnCode: hsnCode ?? this.hsnCode,
      prowarranty: prowarranty ?? this.prowarranty,
      proGuaranty: proGuaranty ?? this.proGuaranty,
      sold: sold ?? this.sold,
      qutlimit: qutlimit ?? this.qutlimit,
      productdimensionL: productdimensionL ?? this.productdimensionL,
      productdimensionB: productdimensionB ?? this.productdimensionB,
      productdimensionH: productdimensionH ?? this.productdimensionH,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      childcategory: childcategory ?? this.childcategory,
      ingredients: ingredients ?? this.ingredients,
      intructions: intructions ?? this.intructions,
      fssailicno: fssailicno ?? this.fssailicno,
      shelflife: shelflife ?? this.shelflife,
      madeFrom: madeFrom ?? this.madeFrom,
      color: color ?? this.color,
      attributes: attributes ?? this.attributes,
      attributesvalue: attributesvalue ?? this.attributesvalue,
      gst: gst ?? this.gst,
      b2cP: b2cP ?? this.b2cP,
      b2cD: b2cD ?? this.b2cD,
      variants1Lprice: variants1Lprice ?? this.variants1Lprice,
      variants1Lsku: variants1Lsku ?? this.variants1Lsku,
      variants1Lstockqut: variants1Lstockqut ?? this.variants1Lstockqut,
      variants2Lprice: variants2Lprice ?? this.variants2Lprice,
      variants2Lsku: variants2Lsku ?? this.variants2Lsku,
      variants2Lstockqut: variants2Lstockqut ?? this.variants2Lstockqut,
      enableaffiliate: enableaffiliate ?? this.enableaffiliate,
      commission: commission ?? this.commission,
      commissiontext: commissiontext ?? this.commissiontext,
      vendorId: venderId ?? this.vendorId,
      productId: productId ?? this.productId,
      productcolor:productcolor??this.productcolor,
      available:available??this.available,
      fact: fact??this.fact,
      categoryName: categoryName??this.categoryName,
      exchangable: exchangable??this.exchangable,
      expirable: expirable??this.expirable,
      liquidContents: liquidContents??this.liquidContents,
      giftWrap: giftWrap??this.giftWrap,
      expireType: expireType??this.expireType,
      heatSensitive: heatSensitive??this.heatSensitive,
      giftWrapCharge: giftWrapCharge??this.giftWrapCharge,

      b2bDelhiD: b2bDelhiD??this.b2bDelhiD,
      b2bDelhiP: b2bDelhiP??this.b2bDelhiP,
      b2bDelhiTier: b2bDelhiTier??this.b2bDelhiTier,
      b2bKeralaD: b2bKeralaD??this.b2bKeralaD,
      b2bKeralaP: b2bKeralaD??this.b2bKeralaP,
      b2bKeralaTier: b2bKeralaTier??this.b2bKeralaTier,
      b2bTamilnaduD: b2bTamilnaduD??this.b2bTamilnaduD,
      b2bTamilnaduP: b2bTamilnaduP??this.b2bTamilnaduP,
      b2bTamilnaduTier: b2bTamilnaduTier??this.b2bTamilnaduTier,
      b2bTier: b2bTier??this.b2bTier,
      branchId: branchId??this.branchId,
      fives: fives??this.fives,
      fours: fours??this.fours,
      imageId: imageId??this.imageId,
      ones: ones??this.ones,
      open: open??this.open,
      relatedProducts: relatedProducts??this.relatedProducts,
      sales: sales??this.sales,
      search: search??this.search,
      start: start??this.start,
      step: step??this.step,
      stop: stop??this.stop,
      threes: threes??this.threes,
      totalReviews: threes??this.totalReviews,
      twos: twos??this.twos,
      userId: userId??this.userId,
      videoUrl: videoUrl??this.videoUrl,
    );
  }
}