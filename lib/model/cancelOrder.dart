import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CancelOrder {
  DateTime? acceptedDate;
  DateTime? cancellationDate;
  int? cancellationStatus;
  DateTime? cancelledDate;
  DateTime? deliveredDate;
  String? deliveryCharge;
  String? deliveryPin;
  double? discount;
  double? gst;
  int? invoiceNo;
  DateTime? orderDate;
  List? orderDetails;
  DocumentReference? orderId;
  int? orderStatus;
  double? price;
  String? shipRocketOrderId;
  DateTime? invoiceDate;
  DateTime? shippedDate;
  Map? shippingAddress;
  String? shippingMethod;
  String? tip;
  double? total;
  String? totalPrice;
  String? trackingUrl;
  DateTime? placedDate;

  //
  // String? awb_code;
  // String? promoCode;
  // String? partner;
  // String? referralCode;
  // List? search;
  // List? token;
  // String? branchId;
  // String? userId;
  // bool? view;
  // String? paymentCart;
  // String? driverId;
  // String? driverName;

  CancelOrder({
    this.price,
    this.placedDate,
    this.trackingUrl,
    this.discount,
    this.invoiceNo,
    this.orderStatus,
    this.acceptedDate,
    this.deliveredDate,
    this.totalPrice,
    this.deliveryCharge,
    this.deliveryPin,
    this.gst,
    this.invoiceDate,
    this.orderId,
    this.shippedDate,
    this.shippingAddress,
    this.shippingMethod,
    this.shipRocketOrderId,
    this.tip,
    this.total,
    this.orderDetails,
    this.cancellationDate,
    this.cancellationStatus,
    this.cancelledDate,
    this.orderDate,

    // this.items,
    // this.awb_code,
    // this.branchId,
    // this.view,
    // this.token,
    // this.promoCode,
    // this.referralCode,
    // this.paymentCart,
    // this.driverId,
    // this.driverName,
    // this.search,
    // this.userId,
    // this.partner,
  });

  CancelOrder.fromJson(Map<String, dynamic> json) {
    placedDate = json["placedDate"] == null
        ? DateTime.now()
        : json["placedDate"].toDate();
    price = json['price'].toDouble() ?? 0;
    totalPrice = json["totalPrice"] ?? "";
    trackingUrl = json['trackingUrl'] ?? "";
    deliveryPin = json['deliveryPin'] ?? "";
    orderId = json['orderId'] ?? "";
    shippingMethod = json['shippingMethod'] ?? "";
    shipRocketOrderId = json['shipRocketOrderId'] ?? "";
    discount = json['discount'].toDouble() ?? 0;
    gst = json['gst'].toDouble() ?? 0;
    invoiceNo = json['invoiceNo'] ?? 0;
    orderStatus = json['orderStatus'] ?? 0;
    deliveryCharge = json['deliveryCharge'];
    tip = json['tip'] ?? "";
    total = json['total'].toDouble() ?? 0;

    acceptedDate = json['acceptedDate'] == null
        ? DateTime.now()
        : json['acceptedDate'].toDate();
    deliveredDate = json['deliveredDate'] == null
        ? DateTime.now()
        : json['deliveredDate'].toDate();
    shippedDate = json['shippedDate'] == null
        ? DateTime.now()
        : json['shippedDate'].toDate();
    shippingAddress = json['shippingAddress'] ?? {};
    orderDate =
    json['orderDate'] == null ? DateTime.now() : json['orderDate'].toDate();
    cancelledDate = json['cancelledDate'] == null
        ? DateTime.now()
        : json['cancelledDate'].toDate();

    cancellationDate = json['cancellationDate'] == null
        ? DateTime.now()
        : json['cancellationDate'].toDate();
    invoiceDate = json['invoiceDate'] == null
        ? DateTime.now()
        : json['invoiceDate'].toDate();
    cancellationDate = json['cancellationDate'] == null
        ? DateTime.now()
        : json['cancellationDate'].toDate();
    orderDetails = json['orderDetails'] ?? [];
    cancellationStatus = json['cancellationStatus'];

    // userId = json['userId'] ?? "";
    // awb_code = json['awb_code'] ?? "";
    // branchId = json['branchId'] ?? "";
    // partner = json['partner'] ?? "";
    // token = json['token'] ?? [];
    // view = json['view'] ?? false;
    // items = json['items'] ?? [];
    // search = json['search'] ?? [];
    // paymentCart = json['paymentCart'] ?? "";
    // driverName = json['driverName'] ?? "";
    // promoCode = json['promoCode'] ?? "";
    // driverId = json['driverId'] ?? "";
    // referralCode = json['referralCode'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['trackingUrl'] = trackingUrl ?? '';
    data['deliveryPin'] = deliveryPin ?? '';
    data["totalPrice"] = totalPrice ?? "";
    data['orderId'] = orderId;
    data['shippedDate'] = shippedDate ?? DateTime.now();
    data['acceptedDate'] = acceptedDate ?? DateTime.now();
    data['invoiceDate'] = invoiceDate ?? DateTime.now();
    data['deliveredDate'] = deliveredDate ?? DateTime.now();
    data['shippingMethod'] = shippingMethod ?? "";
    data['shipRocketOrderId'] = shipRocketOrderId ?? "";
    data['shippingAddress'] = shippingAddress ?? {};
    data['discount'] = discount ?? 0;
    data['invoiceNo'] = invoiceNo ?? 0;
    data['orderStatus'] = orderStatus ?? 0;
    data['deliveryCharge'] = deliveryCharge ?? 0;
    data['tip'] = tip ?? "";
    data['total'] = total ?? 0;
    data["placedDate"] = placedDate ?? DateTime.now();
    data['cancellationDate'] = cancellationDate ?? DateTime.now();
    data['cancelledDate'] = cancelledDate ?? DateTime.now();
    data['orderDate'] = orderDate ?? DateTime.now();
    data['orderDetails'] = orderDetails ?? [];
    data['cancellationStatus'] = cancellationStatus ?? "";

    // data['items'] = items ?? [];
    // data['search'] = search ?? [];
    // data['token'] = token ?? [];
    // data['view'] = view ?? false;
    // data['paymentCart'] = paymentCart;
    // data['driverName'] = driverName ?? "";
    // data['promoCode'] = promoCode ?? "";
    // data['partner'] = partner ?? '';
    // data['driverId'] = driverId ?? '';
    // data['referralCode'] = referralCode;
    // data['awb_code'] = awb_code ?? '';
    // data['branchId'] = branchId ?? '';
    // data['userId'] = userId ?? '';

    return data;
  }
}

StreamSubscription? Streamcurrentuser;
