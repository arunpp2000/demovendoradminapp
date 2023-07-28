import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;


import 'package:intl/intl.dart';


import '../../../globals/colors.dart';

import '../../../login/splashscreen.dart';
import '../../../model/cancelOrder.dart';
import '../../../widgets/button.dart';
import '../../../widgets/customButton.dart';
import '../../../widgets/uploadmedia.dart';
import '../editAddressPop.dart';

String currentBranchId='XaGJz72DaZdJ4S9g7PkO';

class CancelViewPage extends StatefulWidget {
  // final String email;
  final String id;
  CancelViewPage({Key? key,  required this.id,  }) : super(key: key);

  @override
  State<CancelViewPage> createState() => _CancelViewPageState();
}

class _CancelViewPageState extends State<CancelViewPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController statusController = TextEditingController();
  TextEditingController awbCode= TextEditingController();
  TextEditingController shipRocket= TextEditingController();
  TextEditingController trackingUrl= TextEditingController();
  bool listView = false;
  Map colorMap = new Map();
  List orderData = [];
  var orderItems;
  Map address = {};
  Map billingAddress = {};
  String gst = '';
  bool b2b = false;
  List<DropdownMenuItem> fetchedRiders = [];
  Map<String, dynamic> selectedRider={};

  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
//.where('shops',arrayContains: currentUser!.id)
  Future<void> getOrderItems() async {
    List ordersItems = [];
    for (int i = 0; i < Order!.orderDetails!.length; i++) {
      Map tempOrderData = new Map();
      tempOrderData['quantity'] = Order!.orderDetails![i].quantity;
      DocumentSnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
          .instance
          .collection('products')
          .doc(Order!.orderDetails![i].id)
          .get();
      tempOrderData['productImage'] = docRef.data()!['imageId'][0];
      tempOrderData['productName'] = docRef.data()!['name'];
      tempOrderData['price'] = Order!.orderDetails![i].price;
      ordersItems.add(tempOrderData);
    }
    if (mounted) {
      setState(() {
        orderData = ordersItems;
      });
    }
  }

  // getAddress() async {
  //   address = {};
  //   billingAddress = {};
  //
  //   DocumentSnapshot doc = await FirebaseFirestore.instance
  //       .collection('orders')
  //       .doc(widget.id)
  //       .get();
  //
  //   DocumentSnapshot user = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(Order!.userId)
  //       .get();
  //
  //   address = doc.get('shippingAddress');
  //
  //   if (Order!.orderStatus == 3 && user.get('b2b') == true) {
  //     gst = user.get('gst');
  //     b2b = user.get('b2b');
  //   }
  //
  //   if (b2b == true) {
  //     DocumentSnapshot doc = await FirebaseFirestore.instance
  //         .collection('b2bRequests')
  //         .doc(Order!.userId)
  //         .get();
  //
  //     List<Map<String, dynamic>> taxpayerInfo = [];
  //
  //     if (doc.exists) {
  //       if (doc.get('status') == 1) {
  //         taxpayerInfo.add(doc.get('taxpayerInfo'));
  //
  //         billingAddress = {};
  //       }
  //     }
  //   }
  //
  //   if (mounted) {
  //     setState(() {});
  //   }
  // }

  var token;
  var expreesBeetoken;
  int _selectedIndex1=1;
  List<dynamic> p=[];
  var partner;
  getPartner(){
    FirebaseFirestore.instance.collection('settings').doc('order').get().then((value) {
      p=value.data()!['partners'];
      print('---------');
      print(p);
    });
  }
  getorderspartner() {
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.id)
        .snapshots()
        .listen((event) {

      // partner=event.data()['partner'];
      try {
      } catch (e) {
        print(e.toString());
      }
      if (mounted) {
        setState(() {});
      }
    });
  }
  late int orderstatus;
  late int invoiceNumber;
  late double price;
  List orderProducts=[];
  String? shiprocket;
  CancelOrder? Order;
  getOrderDetails(){
    FirebaseFirestore.instance
        .collection('cancellationRequests')
        .doc(widget.id)
        .snapshots()
        .listen((event)  {
      Order = CancelOrder.fromJson(event.data()!);
      // awbCode.text=Order!.awb_code!;
      trackingUrl.text=Order!.trackingUrl!;
      statusController.text = (Order!.orderStatus == 0) ? 'Pending'
          : (Order!.orderStatus== 1)
          ? 'Accepted'
          : (Order!.orderStatus == 3)
          ? 'Shipped'
          : (Order!.orderStatus== 4)
          ? 'Delivered'
          : 'Cancelled';
      orderProducts=[];
      for(var a in Order!.orderDetails! ){

          orderProducts.add(a);

      }
      // getOrderItems();
      if (mounted) {
        setState(() {
          // getPartner();
          //
          // //getAddress();
          // getorderspartner();
        });
      }
    });
  }
  var ship;
  bool tharaShip=false;

  @override
  void initState() {

    getOrderDetails();
    // TODO: implement initState

    super.initState();



  }

  String awbNo = '';
  String trackingLink = '';

  getTrackingId() async {
    var list;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://apiv2.shiprocket.in/v1/external/courier/track?order_id=${Order!.shipRocketOrderId}&channel_id=1861189'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List body = json.decode(await response.stream.bytesToString());

      // print(await response.stream.bytesToString());

      if (body == null || body.length == 0) {
        showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                title: Text('Order Not Shipped'),
                content: SelectableText(trackingLink),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Ok')),
                ],
              );
            });
      } else {
        list = body[0]['tracking_data'];
        trackingLink = list['track_url'];
        List shipment_track = list['shipment_track'];
        print(shipment_track[0]['awb_code']);

        showDialog(
            context: context,
            builder: (buildContext) {
              return AlertDialog(
                title: Text('Tracking Url'),
                content: SelectableText(trackingLink),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel')),
                  TextButton(
                      onPressed: () async {
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                          'trackingUrl': trackingLink,
                          'awb_code': shipment_track[0]['awb_code'],
                        });
                        // widget.order.reference.update({
                        //
                        // });
                        Navigator.pop(context);
                        showUploadMessage(context, 'Tracking Url Updated...');
                      },
                      child: Text('Submit')),
                ],
              );
            });
      }
      setState(() {});
    } else {
      print(response.reasonPhrase);

      showDialog(
          context: context,
          builder: (buildContext) {
            return AlertDialog(
              title: Text('Order Not Shipped'),
              content: SelectableText(trackingLink),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text('Ok')),
              ],
            );
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Return Request",
            style: TextStyle(
              fontSize: h * 0.028,
            )),
        backgroundColor: primaryColor,

      ),
      body:SingleChildScrollView(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       InkWell(
            //         onTap: () async {
            //           await showDialog(
            //               context: context,
            //               builder: (context) {
            //                 return StatefulBuilder(
            //                   builder: (BuildContext context, void Function(void Function()) setState) {
            //                     return AlertDialog(
            //                         insetPadding: EdgeInsets.only(bottom: 200,top: 290,left: 50,right: 50),
            //                         title: Text(
            //                             'select shipping method'),
            //                         content: Column(
            //                           children: [
            //                             RadioListTile(
            //                               title: Text("Self Shipping"),
            //                               value:'Self Shipping',
            //                               groupValue: ship,
            //                               activeColor:primaryColor,
            //                               onChanged: (value){
            //                                 setState(() {
            //                                   ship=value;
            //                                   tharaShip=false;
            //                                 });
            //                               },
            //                             ),
            //                             RadioListTile(
            //                               title: Text("Ship Through Thara"),
            //                               value: 'Ship Through Thara',
            //                               groupValue: ship,
            //                               activeColor:primaryColor,
            //                               onChanged: (value){
            //                                 setState(() {
            //                                   ship=value;
            //                                   tharaShip=true;
            //
            //                                 });
            //                               },
            //                             ),
            //                           ],
            //                         ),
            //                         actions: [
            //                           TextButton(
            //                               child: Text(
            //                                 'Cancel',
            //                                 style: TextStyle(
            //                                     color:
            //                                     primaryColor),
            //                               ),
            //                               onPressed:
            //                                   () {
            //                                 Navigator.of(
            //                                     context)
            //                                     .pop();
            //                               }),
            //                           TextButton(
            //                               child: Text(
            //                                 'Ok',
            //                                 style: TextStyle(
            //                                     color:
            //                                     primaryColor),
            //                               ),
            //                               onPressed:
            //                                   () {
            //                                 var random = new Random();
            //                                 int deliveryPin=random.nextInt(899999)+100000;
            //                                 List shops=[];
            //                                 List products = [];
            //                                 for (var item in Order!.orderDetails??[]) {
            //                                   products.add({
            //                                     'color':item['selectedColor'],
            //                                     'id': item['id'],
            //                                     'name': item['name'],
            //                                     'quantity': item['quantity'],
            //                                     'size' :item['selectedSize'],
            //                                     'cut' :item['cut'],
            //                                     'gst': item['gst'],
            //                                     'unit' :item['unit'],
            //                                     'vendorId' :currentUser?.id,
            //                                     'status':1,
            //                                     'shopDiscount' :item['shopDiscount'],
            //                                     'price': item['price'],
            //                                     'image': item['image'],
            //                                     'productCode': item['productCode'],
            //                                     'hsnCode': item['hsnCode'],
            //                                     'shipThrough':tharaShip
            //                                   });
            //
            //                                   shops.add(currentUser?.id);
            //                                 }
            //                                 FirebaseFirestore.instance.collection('orders').doc(widget.id).update(
            //                                     {
            //                                       // 'userId':  Order!.userId,
            //                                       'items':products,
            //                                       'shippingAddress': Order!.shippingAddress,
            //                                       'shippingMethod': Order!.shippingMethod,
            //                                       'price': double.parse(Order!.price.toString()),
            //                                       'tip': double.parse(Order!.tip.toString()),
            //                                       'deliveryCharge': double.parse(Order!.deliveryCharge.toString()),
            //                                       'total': double.parse(Order!.total.toString()),
            //                                       'gst': double.parse(Order!.gst.toString()),
            //                                       'discount': double.parse(Order!.discount.toString()),
            //                                       // 'paymentCard': Order!.paymentCart,
            //                                       // 'referralCode': Order!.referralCode,
            //                                       // 'promoCode':Order!.promoCode,
            //                                       'placedDate': FieldValue.serverTimestamp(),
            //                                       'orderStatus' :0,
            //                                       'token' :FieldValue.arrayUnion([token]),
            //                                       'shops' :shops,
            //                                       'driverId' :'',
            //                                       'driverName' :'',
            //                                       // 'branchId' :Order!.branchId,
            //                                       'docImage':'',
            //                                       'orderId':widget.id,
            //                                       'view':false
            //                                     });
            //                                 Navigator.pop(context);
            //
            //
            //                               }),
            //
            //                         ]);
            //                   },
            //
            //                 );
            //               });
            //
            //           setState(()  {
            //             _selectedIndex1=1;
            //           });
            //         },
            //         child: Container(
            //           height: h*0.06,
            //           width: w/3.5,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               color: _selectedIndex1 == 1
            //                   ? primaryColor
            //                   : Colors.white,
            //               border: Border.all(color: primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Center(
            //               child: Text(
            //                 'ACCEPT',
            //                 style: GoogleFonts.roboto(
            //                     textStyle: TextStyle(
            //                         color: _selectedIndex1 == 1
            //                             ? Colors.white
            //                             : primaryColor,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: h * 0.015)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () async {
            //           setState(() {
            //             _selectedIndex1 =2;
            //           });
            //           bool proceed =
            //           await alert(context, 'this order is shipped?');
            //
            //           if (proceed) {
            //             final orderStatus = 3;
            //             DocumentSnapshot invoiceNoDoc =
            //             await FirebaseFirestore.instance
            //                 .collection('invoiceNo')
            //                 .doc(currentBranchId)
            //                 .get();
            //             FirebaseFirestore.instance
            //                 .collection('invoiceNo')
            //                 .doc(currentBranchId)
            //                 .update({
            //               'sales': FieldValue.increment(1),
            //             });
            //             int sales = invoiceNoDoc.get('sales');
            //             sales++;
            //             // await FirebaseFirestore.instance.collection('orders').doc(widget.id).update(ordersRecordData);
            //             // await orderDetailsOrdersRecord.reference
            //             //     .update(ordersRecordData);
            //             FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
            //               'search': setSearchParam(
            //                   '${sales.toString()} ${Order!.shipRocketOrderId}'),
            //               'orderStatus': orderStatus,
            //               'shippedDate': Timestamp.now(),
            //               'invoiceNo': sales,
            //               'invoiceDate': Timestamp.now(),
            //
            //             });
            //             // widget.order.reference.update({
            //             //   'search': setSearchParam(
            //             //       '${sales.toString()} ${widget.order.shipRocketOrderId}'),
            //             // });
            //             setState(() {
            //               statusController.text = 'Shipped';
            //             });
            //           }
            //         },
            //         child: Container(
            //           height: h*0.06,
            //           width: w/3.5,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               color: _selectedIndex1 == 2
            //                   ? primaryColor
            //                   : Colors.white,
            //               border: Border.all(color: primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Center(
            //               child: Text(
            //                 'SHIPPED',
            //                 style: GoogleFonts.roboto(
            //                     textStyle: TextStyle(
            //                         color: _selectedIndex1 == 2
            //                             ? Colors.white
            //                             : primaryColor,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: h * 0.015)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () async {
            //           //
            //           // setState(() {
            //           //   _selectedIndex1=3;
            //           //
            //           // });
            //           // List products = [];
            //           // for (var item in Order!.orderDetails??[]) {
            //           //   products.add({
            //           //     'gst': item['gst'],
            //           //     'hsnCode': item['hsnCode'],
            //           //     'id': item['id'],
            //           //     'image': item['image'],
            //           //     'name': item['name'],
            //           //     'price': item['price'],
            //           //     'productCode': item['productCode'],
            //           //     'quantity': item['quantity'],
            //           //     'status': item['status'],
            //           //   });
            //           // }
            //           //
            //           // bool proceed =
            //           // await alert(context, 'this order is delivered?');
            //           //
            //           // if (proceed) {
            //           //   if (Order!.referralCode != null) {
            //           //     QuerySnapshot rUsers = await FirebaseFirestore
            //           //         .instance
            //           //         .collection('users')
            //           //         .where('referralCode',
            //           //         isEqualTo: Order!.referralCode)
            //           //         .get();
            //           //     if (rUsers.docs.length > 0) {
            //           //       DocumentSnapshot rUser = rUsers.docs[0];
            //           //       double? referralCommission = 0;
            //           //       referralCommission = double.tryParse(
            //           //           rUser.get('referralCommission').toString());
            //           //       if (referralCommission != 0) {
            //           //         FirebaseFirestore.instance
            //           //             .collection('referralCommission')
            //           //             .add({
            //           //           'refferedBy': rUser.id,
            //           //           // 'referralCode': Order!.referralCode,
            //           //           'date': FieldValue.serverTimestamp(),
            //           //           // 'userId': Order!.userId,
            //           //           'items': products,
            //           //           'price': Order!.price,
            //           //           'tip': Order!.tip,
            //           //           'deliveryCharge': Order!.deliveryCharge,
            //           //           'total': Order!.total,
            //           //           'gst': Order!.gst,
            //           //           'discount':Order!.discount,
            //           //           'referralCommission': referralCommission,
            //           //           'amount': Order!.total! *
            //           //               referralCommission! /
            //           //               100,
            //           //         }).then((value) {
            //           //           rUser.reference.update({
            //           //             'wallet': FieldValue.increment(
            //           //                 Order!.total! *
            //           //                     referralCommission! /
            //           //                     100)
            //           //           });
            //           //         });
            //           //       }
            //           //     }
            //           //   }
            //           //   await FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
            //           //     'orderStatus':4,
            //           //     'deliveredDate':Timestamp.now(),
            //           //   });
            //           //   setState(() {
            //           //     statusController.text = 'Delivered';
            //           //   });
            //           //   await  FirebaseFirestore.instance.collection('users').doc(Order!.userId).update(
            //           //       {
            //           //         'currentB2cAmount':FieldValue.increment(Order!.price??0)
            //           //       });
            //           //
            //           // }
            //         },
            //         child: Container(
            //           height: h*0.06,
            //           width: w/3.5,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               color: _selectedIndex1 == 3
            //                   ? primaryColor
            //                   : Colors.white,
            //               border: Border.all(color: primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Center(
            //               child: Text(
            //                 'DELIVERED',
            //                 style: GoogleFonts.roboto(
            //                     textStyle: TextStyle(
            //                         color: _selectedIndex1 == 3
            //                             ? Colors.white
            //                             : primaryColor,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: h * 0.015)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       // InkWell(
            //       //   onTap: () {
            //       //     setState(() {
            //       //        _selectedIndex1 =4;
            //       //     });
            //       //   },
            //       //   child: Container(
            //       //     height: h*0.06,
            //       //     width: w/3.5,
            //       //     alignment: Alignment.center,
            //       //     decoration: BoxDecoration(
            //       //         color: _selectedIndex1 == 4
            //       //             ? primaryColor
            //       //             : Colors.white,
            //       //         border: Border.all(color: primaryColor),
            //       //         borderRadius: BorderRadius.circular(5)),
            //       //     child: Padding(
            //       //       padding: EdgeInsets.all(8.0),
            //       //       child: Center(
            //       //         child: Text(
            //       //           'REFUND',
            //       //           style: GoogleFonts.roboto(
            //       //               textStyle: TextStyle(
            //       //                   color: _selectedIndex1 == 4
            //       //                       ? Colors.white
            //       //                       :primaryColor,
            //       //                   fontWeight: FontWeight.bold,
            //       //                   fontSize: h * 0.015)),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //       InkWell(
            //         onTap: (){
            //           setState(() {
            //             _selectedIndex1 =5;
            //           });
            //
            //         },
            //         // onTap: () async {
            //         //   bool proceed = await alert(
            //         //       context, 'You want to cancel this order?');
            //         //   if (proceed) {
            //         //     final orderStatus = 2;
            //         //     if (Order.orderStatus! > 2) {
            //         //       final ordersRecordData = createOrdersRecordData(
            //         //         orderStatus: orderStatus,
            //         //         returnOrder: true,
            //         //         invoiceNo:
            //         //         orderDetailsOrdersRecord.invoiceNo ?? 0,
            //         //         cancelledDate: Timestamp.now(),
            //         //       );
            //         //       await FirebaseFirestore.instance.collection('orders').doc(widget.id).update(ordersRecordData);
            //         //       // await orderDetailsOrdersRecord.reference
            //         //       //     .update(ordersRecordData);
            //         //       setState(() {
            //         //         statusController.text = 'cancelled';
            //         //       });
            //         //     } else {
            //         //       final ordersRecordData = createOrdersRecordData(
            //         //         invoiceNo:
            //         //         orderDetailsOrdersRecord.invoiceNo ?? 0,
            //         //         returnOrder: false,
            //         //         orderStatus: orderStatus,
            //         //         cancelledDate: Timestamp.now(),
            //         //       );
            //         //       await FirebaseFirestore.instance.collection('orders').doc(widget.id).update(ordersRecordData);
            //         //       // await orderDetailsOrdersRecord.reference
            //         //       //     .update(ordersRecordData);
            //         //       setState(() {
            //         //         statusController.text = 'cancelled';
            //         //       });
            //         //     }
            //         //   }
            //         // },
            //         child: Container(
            //           height: h*0.06,
            //           width: w/3.5,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //               color: _selectedIndex1 == 5
            //                   ? primaryColor
            //                   : Colors.white,
            //               border: Border.all(color: primaryColor),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Padding(
            //             padding: EdgeInsets.all(8.0),
            //             child: Center(
            //               child: Text(
            //                 'CANCELLED',
            //                 style: GoogleFonts.roboto(
            //                     textStyle: TextStyle(
            //                         color: _selectedIndex1 == 5
            //                             ? Colors.white
            //                             : primaryColor,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: h * 0.015)),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       // InkWell(
            //       //   onTap: () {
            //       //     setState(() {
            //       //       _selectedIndex1 =6;
            //       //     });
            //       //     // onItemTapped(index);
            //       //   },
            //       //   child: Container(
            //       //     height: h*0.06,
            //       //     width: w/3.5,
            //       //     alignment: Alignment.center,
            //       //     decoration: BoxDecoration(
            //       //         color: _selectedIndex1 == 6
            //       //             ? primaryColor
            //       //             : Colors.white,
            //       //         border: Border.all(color: primaryColor),
            //       //         borderRadius: BorderRadius.circular(5)),
            //       //     child: Padding(
            //       //       padding: EdgeInsets.all(8.0),
            //       //       child: Center(
            //       //         child: Text(
            //       //           'EDIT',
            //       //           style: GoogleFonts.roboto(
            //       //               textStyle: TextStyle(
            //       //                   color: _selectedIndex1 == 6
            //       //                       ? Colors.white
            //       //                       : primaryColor,
            //       //                   fontWeight: FontWeight.bold,
            //       //                   fontSize: h * 0.015)),
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            //userDetails
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('User Details',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.62,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order?.shippingAddress!['name']??"",style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Reg Mob :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['mobileNumber'],style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Reg Date :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(  DateFormat("d-MM-y hh:mm")
                      .format(Order!.orderDate!),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            //Order Details
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Details',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.55,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Id :',style: TextStyle(fontWeight: FontWeight.w500),),
                 // Text(Order!.orderId.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Time:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('20-03-2023 02:8',style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Invoie No :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('TCE-'+Order!.invoiceNo.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logistics Order Id :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shipRocketOrderId.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Shippment Status:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(' ',style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Refered By :',style: TextStyle(fontWeight: FontWeight.w500),),
                  //Text(Order!.referralCode.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),

            // Padding(
            //   padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Refered By Affillicate :',style: TextStyle(fontWeight: FontWeight.w500),),
            //       Text('User Name',style: TextStyle(fontWeight: FontWeight.w500),),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Commission Reg No:',style: TextStyle(fontWeight: FontWeight.w500),),
            //       Text('2222',style: TextStyle(fontWeight: FontWeight.w500),),
            //     ],
            //   ),
            // ),
            //Logistics
            // Padding(
            //   padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text('Logistics',style: TextStyle(fontWeight: FontWeight.bold),),
            //       SizedBox(
            //         height: h * 0.0020,
            //         width: w * 0.69,
            //         child: DecoratedBox(
            //             decoration: BoxDecoration(color:Colors.black12)),
            //       ),
            //
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
            //   child: Container(
            //     width: double.infinity,
            //     decoration: BoxDecoration(
            //         color: Colors.white,
            //         border: Border.all(
            //           color: primaryColor,
            //         ),
            //         borderRadius: BorderRadius.circular(2)),
            //     child: DropdownButtonFormField<String>(
            //       value: partner,
            //       decoration: InputDecoration(
            //         hintText: "Partners",
            //         border: OutlineInputBorder(),
            //       ),
            //       onChanged: (crs) {
            //         partner = crs;
            //         print(partner);
            //         setState(() {});
            //       },
            //       validator: (value) =>
            //       value == null ? 'field required' : null,
            //       items: p.toList()
            //           .map<DropdownMenuItem<String>>((value) {
            //         return DropdownMenuItem<String>(
            //           value: value,
            //           child: Text(value),
            //         );
            //       }).toList(),
            //     ),
            //   ),
            // ),



            //Order Amount
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Amount',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.55,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Promo Code :',style: TextStyle(fontWeight: FontWeight.w500),),
                 // Text(Order!.promoCode.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹'+Order!.discount.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Delivery Charge :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹'+Order!.deliveryCharge.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total (excl.GST) :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹'+Order!.total!.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('GST :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹'+Order!.gst!.toStringAsFixed(2),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount :',style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor),),
                  Text('₹ ${Order!.price}',style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor),),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Payment Method :',style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor),),
                  Text(Order!.shippingMethod.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: primaryColor),),

                ],
              ),
            ),
//address
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Address',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.45,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (buildContext) {
                            return AddressPopUp(
                              name: Order!.shippingAddress!['name'],
                              address: Order!.shippingAddress!['address'],
                              landMark: Order!.shippingAddress!['landMark'],
                              area: Order!.shippingAddress!['area'],
                              pincode: Order!.shippingAddress!['pinCode'],
                              state: Order!.shippingAddress!['state'],
                              orderId: widget.id,
                              // customerId: Order!.userId??"",
                              city: Order!.shippingAddress!['city'],
                            );
                          });
                    },
                    child: Container(
                      height: h*0.035,
                      width: w/4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color:  primaryColor,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'edit',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color:  Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.015)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Name :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['name'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text('Address:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['address'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Land Mark:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['landMark'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Area :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['area'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('State:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['state'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Pincode:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['pinCode'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Moible No:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text(Order!.shippingAddress!['mobileNumber'].toString(),style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            //product
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Products',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.66,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),
                ],
              ),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount:orderProducts.length,
                padding: EdgeInsets.all(10),
                itemBuilder: (buildContext, int index) {
                  final itemsItem = orderProducts[index];
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(
                              0, 0, 0, 8),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize:
                                    MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .center,
                                    children: [
                                      Column(
                                        mainAxisSize:
                                        MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding:
                                            EdgeInsetsDirectional
                                                .fromSTEB(
                                                12,
                                                0,
                                                0,
                                                0),
                                            child: Card(
                                              clipBehavior: Clip
                                                  .antiAliasWithSaveLayer,
                                              color: Color(
                                                  0xFFF1F5F8),
                                              shape:
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    8),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    2,
                                                    2,
                                                    2,
                                                    2),
                                                child:
                                                ClipRRect(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(8),
                                                  child:
                                                  CachedNetworkImage(
                                                    imageUrl:itemsItem['productImage']??'',
                                                    width: 90,
                                                    height:
                                                    90,
                                                    fit: BoxFit
                                                        .cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                          EdgeInsetsDirectional
                                              .fromSTEB(12,
                                              0, 0, 0),
                                          child: Column(
                                            mainAxisSize:
                                            MainAxisSize
                                                .max,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(itemsItem['productName'],
                                                style: TextStyle(
                                                  fontFamily:
                                                  'Lexend Deca',
                                                  color: Color(
                                                      0xFF111417),
                                                  fontSize: 12,
                                                  fontWeight:
                                                  FontWeight
                                                      .w600,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0,
                                                    4,
                                                    0,
                                                    4),
                                                child: Text(
                                                  itemsItem['quantity'].toString() + ' x ' + itemsItem['discountPrice']
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Lexend Deca',
                                                    color: Color(
                                                        0xFF090F13),
                                                    fontSize:
                                                    14,
                                                    fontWeight:
                                                    FontWeight
                                                        .normal,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),


                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
            SizedBox(height: h*0.05,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(text: 'Approve', onPressed: () async {
                  bool pressed=await alert(context, 'Do you want to Accept?');
                  if(pressed){
                    FirebaseFirestore.instance.collection('cancellationRequests').doc(widget.id).update({
                      'cancellationStatus':1,
                    });
                    Navigator.pop(context);
                    showUploadMessage(context, 'Request Accepted...');
                  }

                }, color: Colors.green),
                CustomButton(text: 'Reject', onPressed: () async {
                  bool pressed=await alert(context, 'Do you want to Reject?');
                  if(pressed){
                    FirebaseFirestore.instance.collection('cancellationRequests').doc(widget.id).update({
                      'cancellationStatus':2,
                    });
                    Navigator.pop(context);

                    showUploadMessage(context, 'Request Rejected...');
                  }

                }, color: Colors.red)
              ],
            ),
            Container(
              height: h * 0.050,
              width: w * 1,
              decoration: BoxDecoration(
                color: primaryColor,
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                ),
              ),

            ),
          ],
        ),
      ),
    );
  }
}

