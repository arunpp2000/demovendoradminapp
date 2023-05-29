import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';



class OrderModel {
  DateTime? acceptedDate;
  DateTime? deliveredDate;
  Timestamp? invoiceDate;
  Timestamp? placedDate;
  DateTime? shippedDate;
  String? awb_code;
  String? promoCode;
  String? partner;
  String? referralCode;
  String? shipRocketOrderId;
  List? search;
  int? invoiceNo;
  double? price;
  double? tip;
  double? total;
  int? orderStatus;
  List? items;
  List? shops;
  List? token;
  String? branchId;
  String? trackingUrl;
  String? userId;
  bool? view;
  String? paymentCart;
  String? shippingMethod;
  String? orderId;
  String? deliveryPin;
  String? driverId;
  String? driverName;
  double? gst;
  double? deliveryCharge;
  double? discount;
  Map<String, dynamic>? shippingAddress;
  OrderModel(
      {this.price,
        this.trackingUrl,
        this.userId,
        this.partner,
        this.discount,
        this.items,
        this.invoiceNo,
        this.orderStatus,
        this.search,
        this.acceptedDate,
        this.awb_code,
        this.branchId,
        this.deliveredDate,
        this.deliveryCharge,
        this.deliveryPin,
        this.driverId,
        this.driverName,
        this.gst,
        this.invoiceDate,
        this.orderId,
        this.paymentCart,
        this.placedDate,
        this.promoCode,
        this.referralCode,
        this.shippedDate,
        this.shippingAddress,
        this.shippingMethod,
        this.shipRocketOrderId,
        this.shops,
        this.tip,
        this.token,
        this.total,
        this.view});

  OrderModel.fromJson(Map<String, dynamic> json) {
    price = json['price'].toDouble() ?? 0;
    trackingUrl = json['trackingUrl'] ?? "";
    userId = json['userId'] ?? "";
    awb_code = json['awb_code'] ?? "";
    branchId = json['branchId'] ?? "";
    partner = json['partner'] ?? "";
    deliveryPin = json['deliveryPin'] ?? "";
    driverId = json['driverId'] ?? "";
    referralCode = json['referralCode'] ?? "";
    orderId = json['orderId'] ?? "";
    paymentCart = json['paymentCart'] ?? "";
    driverName = json['driverName'] ?? "";
    promoCode = json['promoCode'] ?? "";
    shippingMethod = json['shippingMethod'] ?? "";
    shipRocketOrderId = json['shipRocketOrderId'] ?? "";
    discount = json['discount'].toDouble() ?? 0;
    gst = json['gst'].toDouble() ?? 0;
    invoiceNo = json['invoiceNo'] ?? 0;
    orderStatus = json['orderStatus'] ?? 0;
    deliveryCharge = json['deliveryCharge'].toDouble() ?? 0;
    tip = json['tip'].toDouble() ?? 0;
    total = json['total'].toDouble() ?? 0;
    items = json['items'] ?? [];
    search = json['search'] ?? [];
    shops = json['shops'] ?? [];
    token = json['token'] ?? [];
    view = json['view'] ?? false;
    acceptedDate = json['acceptedDate'] == null
        ? DateTime.now()
        : json['acceptedDate'].toDate();
    invoiceDate = json['invoiceDate']==null?Timestamp.now():json['invoiceDate'];
    deliveredDate = json['deliveredDate'] == null
        ? DateTime.now()
        : json['deliveredDate'].toDate();
    placedDate = json['placedDate'] == null
        ? Timestamp.now()
        : json['placedDate'];
    shippedDate = json['shippedDate'] == null
        ? DateTime.now()
        : json['shippedDate'].toDate();
    shippingAddress = json['shippingAddress'] ?? {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = userId ?? '';
    data['trackingUrl'] = trackingUrl ?? '';
    data['awb_code'] = awb_code ?? '';
    data['branchId'] = branchId ?? '';
    data['deliveryPin'] = deliveryPin ?? '';
    data['partner'] = partner ?? '';
    data['driverId'] = driverId ?? '';
    data['referralCode'] = referralCode;
    data['orderId'] = orderId;
    data['paymentCart'] = paymentCart;
    data['driverName'] = driverName ?? "";
    data['promoCode'] = promoCode ?? "";
    data['shippedDate'] = shippedDate ?? DateTime.now();
    data['acceptedDate'] = acceptedDate ?? DateTime.now();
    data['invoiceDate'] = invoiceDate ?? DateTime.now();
    data['deliveredDate'] = deliveredDate ?? DateTime.now();
    data['placedDate'] = placedDate ?? DateTime.now();
    data['shippingMethod'] = shippingMethod ?? "";
    data['shipRocketOrderId'] = shipRocketOrderId ?? "";
    data['shippingAddress'] = shippingAddress ?? {};
    data['discount'] = discount ?? 0;
    data['invoiceNo'] = invoiceNo ?? 0;
    data['orderStatus'] = orderStatus ?? 0;
    data['deliveryCharge'] = deliveryCharge ?? 0;
    data['tip'] = tip ?? 0;
    data['total'] = total ?? 0;
    data['items'] = items ?? [];
    data['search'] = search ?? [];
    data['shops'] = shops ?? [];
    data['token'] = token ?? [];
    data['view'] = view ?? false;
    return data;
  }
}

StreamSubscription? Streamcurrentuser;

// currentUserListener(String userId) {
//   Streamcurrentuser = FirebaseFirestore.instance
//       .collection("Users")
//       .doc(userId)
//       .snapshots()
//       .listen((event) {
//     print(event.data());
//     currentuser = UserModel.fromJson(event.data()!);
//     currentUserLevel = event['sno'];
//     print("---------------------------------------------------");
//     print(event.exists);
//     print("---------------------------------------------------");
//   });
// }

// GC2502694     0
// GC9462971     1
// GC5132990     z
// GC8922992     5
