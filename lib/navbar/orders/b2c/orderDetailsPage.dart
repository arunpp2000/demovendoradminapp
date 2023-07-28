import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import '../../../globals/colors.dart';
import '../../../login/splashscreen.dart';
import '../../../model/invoice.dart';
import '../../../model/orderModel.dart';
import '../../../widgets/button.dart';
import '../../../widgets/uploadmedia.dart';
import 'package:intl/intl.dart';

import '../../Navbar.dart';
import '../b2cPdf.dart';
import '../editAddressPop.dart';
import '../pdfApi.dart';
String currentBranchId='XaGJz72DaZdJ4S9g7PkO';

class OrderDetailsPage extends StatefulWidget {

  final String id;

  var email;
  OrderDetailsPage({Key? key,  required this.id, required this.email,  }) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController statusController = TextEditingController();
  TextEditingController awbCode= TextEditingController();
  TextEditingController trackingUrl= TextEditingController();
  bool listView = false;
  Map colorMap = new Map();

  _launchURL(String urls) async {
    var url = urls;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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


  getAddress() async {
    address = {};
    billingAddress = {};

    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.id)
        .get();

    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(Order?.userId)
        .get();

    address = doc.get('shippingAddress');
    print('customer place ' + address['state']);

    if (Order!.orderStatus == 3 && user.get('b2b') == true) {
      gst = user.get('gst');
      b2b = user.get('b2b');
    }

    if (b2b == true) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('b2bRequests')
          .doc(Order!.userId)
          .get();

      List<Map<String, dynamic>> taxpayerInfo = [];

      if (doc.exists) {
        if (doc.get('status') == 1) {
          taxpayerInfo.add(doc.get('taxpayerInfo'));
          billingAddress = {};
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  var expreesBeetoken;
  shipRocket() async {
    List items = [];

    if (token != null || token != '') {
      print('1');
      DocumentSnapshot invoiceNoDoc = await FirebaseFirestore.instance
          .collection('invoiceNo')
          .doc(currentBranchId)
          .get();
      FirebaseFirestore.instance
          .collection('invoiceNo')
          .doc(currentBranchId)
          .update({
        'orderId': FieldValue.increment(1),
      });
      int orderId = invoiceNoDoc.get('orderId');
      orderId++;
      var header = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      print('2');
      print(token);
      print('pppp');

      double amount = 0;
      String method = '';
      if (Order!.shippingMethod == 'Cash On Delivery') {
        amount = Order!.total! + Order!.gst! + 33;
        method = "COD";
      } else {
        amount = (Order!.total! + Order!.gst!);
        method = "Prepaid";
      }

      for (var data in Order!.items!) {
        items.add({
          'name': data['name'],
          'sku': data['productCode'],
          'units': data['quantity'].toInt(),
          'selling_price': data['price'],
          'tax': data['gst'].toInt(),
          'hsn': data['hsnCode'],
        });
      }

      var request = http.Request(
          'POST',
          Uri.parse(
              'https://apiv2.shiprocket.in/v1/external/orders/create/adhoc'));
      request.body = json.encode({
        "order_id": 'THARAE$orderId',
        "order_date": DateTime.now().toString().substring(0, 16),
        "pickup_location": "THARA CART",
        "billing_customer_name": Order!.shippingAddress!['name'],
        "billing_last_name": "",
        "billing_city": Order!.shippingAddress!['city'],
        "billing_pincode": Order!.shippingAddress!['pinCode'],
        "billing_state": Order!.shippingAddress!['state'],
        "billing_address": Order!.shippingAddress!['address'],
        "billing_country": "India",
        "billing_email": widget.email,
        "billing_phone": Order!.shippingAddress!['mobileNumber'],
        "shipping_is_billing": true,
        "shipping_customer_name": Order!.shippingAddress!['name'],
        "shipping_address": Order!.shippingAddress!['address'],
        "shipping_address_2": Order!.shippingAddress!['area'],
        "shipping_city": Order!.shippingAddress!['city'],
        "shipping_pincode": Order!.shippingAddress!['pinCode'],
        "shipping_country": "India",
        "shipping_state": Order!.shippingAddress!['state'],
        "shipping_email": widget.email,
        "shipping_phone": Order!.shippingAddress!['mobileNumber'],
        "order_items": items,
        "payment_method": method,
        "shipping_charges": Order!.deliveryCharge?.toInt(),
        "total_discount": Order!.discount?.toInt(),
        "sub_total": amount.toInt(),
        "length": '10.0',
        "breadth": '15.0',
        "height": '20.0',
        "weight": '2.5'
      });
      request.headers.addAll(header);

      http.StreamedResponse response = await request.send();
      print('-----');
      if (response.statusCode == 200) {
        print('1');
        print(await response.stream.bytesToString());
        // final ordersRecordData = createOrdersRecordData(
        //     orderStatus: 1,
        //     acceptedDate: Timestamp.now(),
        //     shipRocketOrderId: 'THARAE$orderId');
        // var
        var data={
          'orderStatus':1,
          'acceptedDate':DateTime.now(),
          'shipRocketOrderId':'THARAE$orderId'
        };

        await FirebaseFirestore.instance.collection('orders').doc(widget.id).update(data);
        //  await widget.order.reference.update(ordersRecordData);
        showUploadMessage(context, 'Order Accepted...');
        Navigator.pop(context);
      } else {
        print(response.statusCode);
        print(response.reasonPhrase);
        print(await response.stream.bytesToString());
        showUploadMessage(context, response.reasonPhrase??'');
      }
    }
  }
  late bool  _selectedIndex1=false;
  // ExpressBees() async {
  //   List items = [];
  //   if (expreesBeetoken != null || expreesBeetoken != '') {
  //     DocumentSnapshot invoiceNoDoc = await FirebaseFirestore.instance
  //         .collection('invoiceNo')
  //         .doc(currentBranchId)
  //         .get();
  //     FirebaseFirestore.instance
  //         .collection('invoiceNo')
  //         .doc(currentBranchId)
  //         .update({
  //       'orderId': FieldValue.increment(1),
  //     });
  //     int orderId = invoiceNoDoc.get('orderId');
  //     orderId++;
  //
  //     var header = {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $expreesBeetoken'
  //     };
  //
  //     print(token);
  //     double amount = 0;
  //     double codCharge = 0;
  //     if (Order.shippingMethod == 'Cash On Delivery') {
  //       amount = Order.total + Order.gst + 33;
  //       codCharge = 33;
  //     } else {
  //       codCharge = 0;
  //       amount = (Order.total! + Order.gst)!;
  //     }
  //
  //     for (var data in Order.items!) {
  //       items.add({
  //         'product_name': data.name,
  //         'product_qty': data.quantity.toInt(),
  //         'product_price': data.price * 100 / (100 + data.gst.toInt()),
  //         'product_tax_per': data.gst.toInt(),
  //         'product_sku': data.productCode,
  //         'product_hsn': data.hsnCode,
  //       });
  //     }
  //     String payment_method = '';
  //
  //     if (Order.shippingMethod == 'Cash On Delivery') {
  //       payment_method = "COD";
  //     } else {
  //       payment_method = "prepaid";
  //     }
  //
  //     var request = http.Request('POST',
  //         Uri.parse('https://ship.xpressbees.com/api/franchise/shipments'));
  //     request.body = json.encode({
  //       "id": 'THARAE$orderId',
  //       "payment_method": payment_method,
  //
  //       //thara
  //       "consigner_name": "Thara Online Store",
  //       "consigner_phone": "8589858588",
  //       "consigner_pincode": "679322",
  //       "consigner_city": "Malappuram",
  //       "consigner_state": "Kerala",
  //       "consigner_address":
  //       "11/321,Thara Appartments,Hospital Road,Perinthalmanna",
  //       "consigner_gst_number": "32JDVPS7635J1ZK",
  //
  //       //customer
  //       "consignee_name": Order.shippingAddress!['name'],
  //       "consignee_phone": Order.shippingAddress!['mobileNumber'],
  //       "consignee_pincode":Order.shippingAddress!['pinCode'],
  //       "consignee_city":Order.shippingAddress!['city'],
  //       "consignee_state": Order.shippingAddress!['state'],
  //       "consignee_address":Order.shippingAddress!['address'],
  //       "consignee_gst_number": "",
  //
  //       //items
  //       "products": items,
  //
  //       //invoiceData
  //       "invoice": [
  //         {
  //           "invoice_number": "",
  //           "invoice_date": "",
  //           "ebill_number": "",
  //           "ebill_expiry_date": ""
  //         }
  //       ],
  //
  //       "length": "",
  //       "breadth": "",
  //       "height": "",
  //       "weight": "",
  //
  //       //courierId air or surface
  //
  //       "courier_id": "1025",
  //       "pickup_location": "franchise",
  //       "shipping_charges": '',
  //       "cod_charges": '',
  //       "discount": '',
  //       "order_amount": Order.price?.toInt(),
  //     });
  //     request.headers.addAll(header);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //     } else {
  //       print(response.statusCode);
  //       print(response.reasonPhrase);
  //       print(await response.stream.bytesToString());
  //       showUploadMessage(context, response.reasonPhrase??'');
  //     }
  //   }
  // }
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
        print('========');
        print(widget.id);
        partner=event.get('partner');
        print('========');
        print(partner);
        print('========');
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
  String? shiprocket;
  OrderModel? Order;
  getOrderDetails(){
    FirebaseFirestore.instance
        .collection('orders')
        .doc(widget.id)
        .snapshots()
        .listen((event) async {

      print(event.data());
      Order = OrderModel.fromJson(event.data()!);
      for(var a in Order!.items??[]){
          orderData.add(a);
      }
      print(Order?.awb_code);
      print('awbCode');
      awbCode.text=Order!.awb_code!;
      trackingUrl.text=Order!.trackingUrl!;
      print(Order!.orderStatus);
      statusController.text = (Order!.orderStatus == 0) ? 'Pending'
          : (Order!.orderStatus== 1)
          ? 'Accepted'
          : (Order!.orderStatus == 3)
          ? 'Shipped'
          : (Order!.orderStatus== 4)
          ? 'Delivered'
          : 'Cancelled';

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {

    getOrderDetails();
    // TODO: implement initState
    getPartner();
    getAddress();
    getorderspartner();
    // ExpressBees();
    super.initState();
  }





  void colorLists() async {
    Map colorMaps = Map();

    DocumentSnapshot<Map<String, dynamic>> colorRef = await FirebaseFirestore
        .instance
        .collection('colors')
        .doc('colors')
        .get();
    List colorList = colorRef.data()!['colorList'];
    for (int i = 0; i < colorList.length; i++) {
      colorMaps[colorList[i]['code']] = colorList[i]['name'];
    }

    setState(() {
      colorMap = colorMaps;
    });
    // getOrderItems();
  }

  String colorList(String colorName) {
    print(colorName);
    if (colorMap[colorName] != null) {
      return colorMap[colorName];
    } else {
      return 'NotFound';
    }
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
            'https://apiv2.shiprocket.in/v1/external/courier/track?order_id=${Order?.shipRocketOrderId}&channel_id=1861189'));
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

  int  _selectOption1 = 0;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // automaticallyImplyLeading: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)),
        title: Text(
          statusController.text + ' Order',
          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: [
          Order?.orderStatus == 2&&Order?.invoiceNo!=0
              ? TextButton(
              onPressed: () async {
                bool proceed = await alert(
                    context, 'Do You want to change invoice Number?');
                if (proceed) {
                  FirebaseFirestore.instance
                      .collection('orders')
                      .doc(widget.id)
                      .update({
                    "invoiceNo":0,
                  });
                  showUploadMessage(context,'Successfully invoice number changed');
                }

              },
              child: Text(
                'Invalidate \ninvoice',
                style: TextStyle(color: Colors.white),
              ))
              : Container(),
          Order!.orderStatus != 3
              ? Container()
              : IconButton(
              iconSize: 27,
              onPressed: () {
                getTrackingId();
              },
              icon: Icon(Icons.report)),
          Order!.orderStatus == 3
              ? IconButton(
              iconSize: 27,
              onPressed: () async {
                print(orderItems);

                Map items = {};
                List products = [];
                for (var item in Order!.items!) {
                  // print(item.name);
                  items = {
                    'productName': item['name'],
                    'price': item['price'],
                    'quantity': item['quantity'].toInt(),
                    'total': item['price'] * item['quantity'],
                    'gst': item['gst'],
                  };
                  products.add(items);
                }

                print(items);

                print(b2b);
                List<InvoiceItem> item = [];

                int? amount =
                int.tryParse(Order!.price?.toInt().toString()??'');


                print(amount.toString());

                String number = NumberToWord().convert('en-in', amount!);
                for (var data in products) {
                  item.add(
                    InvoiceItem(
                      description: data['productName'],
                      gst: data['total'] -
                          data['quantity'] *
                              data['price'] *
                              100 /
                              (100 + data['gst']),
                      // gst: items['quantity']*items['price']*100/(100+items['gst'])* items['gst']/100,
                      price: data['price'].toDouble(),
                      quantity: data['quantity'],
                      tax: data['quantity'] *
                          data['price'] *
                          100 /
                          (100 + data['gst']),
                      total: data['total'].toDouble(),
                      unitPrice: data['price'] * 100 / (100 + data['gst']),
                    ),
                  );
                }

                final invoice = Invoice(
                  invoiceNo: Order!.invoiceNo,
                  discount: Order!.discount,
                  shipRocketId: Order!.shipRocketOrderId,
                  invoiceNoDate: Order!.invoiceDate,
                  orderId: widget.id,
                  shipping: Order!.deliveryCharge,
                  orderDate: Order!.placedDate,
                  total: Order!.total,
                  price: Order!.price,
                  gst: Order!.gst,
                  amount: number,
                  method: Order!.shippingMethod,
                  b2b: b2b,
                  shippingAddress: [
                    ShippingAddress(
                      gst: Order!.gst.toString(),
                      name: Order!.shippingAddress!['name'],
                      area: Order!.shippingAddress!['area'],
                      address: Order!.shippingAddress!['address'],
                      mobileNumber: Order!.shippingAddress!['mobileNumber'],
                      pincode: Order!.shippingAddress!['pinCode'],
                      city: Order!.shippingAddress!['city'],
                      state: Order!.shippingAddress!['state'],
                    ),
                  ],
                  salesItems: item,
                );
                final pdfFile = await B2cPdfInvoiceApi.generate(invoice);
                await PdfApi.openFile(pdfFile);
                // await save
              },
              icon: Icon(Icons.picture_as_pdf))
              : Container()
        ],
        backgroundColor: primaryColor,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _selectOption1=1;
                      });
                      bool proceed = await alert(
                          context, 'You want to accept this order?');
                      if (proceed) {
                        shipRocket();
                      }

                    },
                    child: Container(
                      height: h*0.06,
                      width: w/3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectOption1 == 1
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'ACCEPT',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: _selectOption1 == 1
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.015)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _selectOption1=2;
                      });
                      bool proceed = await alert(
                          context, 'You want to cancel this order?');
                      if (proceed) {
                        final orderStatus = 2;
                        if (Order!.orderStatus! > 2) {
                          // final ordersRecordData = createOrdersRecordData(
                          //   orderStatus: orderStatus,
                          //   returnOrder: true,
                          //   invoiceNo:
                          //   orderDetailsOrdersRecord.invoiceNo ?? 0,
                          //   cancelledDate: Timestamp.now(),
                          // );
                          await FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                            'orderStatus':2,
                            'returnOrder':true,
                            'invoiceNo':Order!.invoiceNo,
                            'cancelledDate':Timestamp.now(),
                          });
                          // await orderDetailsOrdersRecord.reference
                          //     .update(ordersRecordData);
                          setState(() {
                            statusController.text = 'cancelled';
                          });
                        } else {
                          // final ordersRecordData = createOrdersRecordData(
                          //   invoiceNo:
                          //   orderDetailsOrdersRecord.invoiceNo ?? 0,
                          //   returnOrder: false,
                          //   orderStatus: orderStatus,
                          //   cancelledDate: Timestamp.now(),
                          // );
                          await FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                            'orderStatus':2,
                            'returnOrder':false,
                            'invoiceNo':Order!.invoiceNo,
                            'cancelledDate':Timestamp.now(),
                          });
                          // await orderDetailsOrdersRecord.reference
                          //     .update(ordersRecordData);
                          setState(() {
                            statusController.text = 'cancelled';
                          });
                        }
                      }

                    },
                    child: Container(
                      height: h*0.06,
                      width: w/3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectOption1 ==2
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'CANCELLED',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: _selectOption1 == 2
                                        ? Colors.white
                                        : Colors.black,
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       // _selectedIndex1 =true;
                  //     });
                  //   },
                  //   child: Container(
                  //     height: h*0.06,
                  //     width: w/3.5,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: _selectedIndex1 == true
                  //             ? primaryColor
                  //             : Colors.white,
                  //         border: Border.all(color: primaryColor),
                  //         borderRadius: BorderRadius.circular(5)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Center(
                  //         child: Text(
                  //           'REFUND',
                  //           style: GoogleFonts.roboto(
                  //               textStyle: TextStyle(
                  //                   color: _selectedIndex1 == true
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: h * 0.015)),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _selectOption1=3;
                      });

                      bool proceed =
                      await alert(context, 'this order is shipped?');

                      if (proceed) {
                        final orderStatus = 3;
                        DocumentSnapshot invoiceNoDoc =
                        await FirebaseFirestore.instance
                            .collection('invoiceNo')
                            .doc(currentBranchId)
                            .get();
                        FirebaseFirestore.instance
                            .collection('invoiceNo')
                            .doc(currentBranchId)
                            .update({
                          'sales': FieldValue.increment(1),
                        });
                        int sales = invoiceNoDoc.get('sales');
                        sales++;
                        // final ordersRecordData = createOrdersRecordData(
                        //   orderStatus: orderStatus,
                        //   shippedDate: Timestamp.now(),
                        //   invoiceNo: sales,
                        //   invoiceDate: Timestamp.now(),
                        // );
                        await FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                          'orderStatus':orderStatus,
                          'shippedDate':Timestamp.now(),
                          'invoiceNo':sales,
                          'invoiceDate': Timestamp.now(),
                        });
                        // await orderDetailsOrdersRecord.reference
                        //     .update(ordersRecordData);
                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                          'search': setSearchParam(
                              '${sales.toString()} ${Order?.shipRocketOrderId}'),

                        });
                        // widget.order.reference.update({
                        //   'search': setSearchParam(
                        //       '${sales.toString()} ${widget.order.shipRocketOrderId}'),
                        // });
                        setState(() {
                          statusController.text = 'Shipped';
                        });
                      }
                    },
                    child: Container(
                      height: h*0.06,
                      width: w/3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectOption1 == 3
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'SHIPPED',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: _selectOption1 ==3
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.015)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        _selectOption1=4;
                      });
                      List products = [];
                      for (var item in Order!.items??[]) {
                        products.add({
                          'gst': item['gst'],
                          'hsnCode': item['hsnCode'],
                          'id': item['id'],
                          'image': item['image'],
                          'name': item['name'],
                          'price': item['price'],
                          'productCode': item['productCode'],
                          'quantity': item['quantity'],
                          'status': item['status'],
                        });
                      }

                      bool proceed =
                      await alert(context, 'this order is delivered?');

                      if (proceed) {
                        final orderStatus = 4;
                        // final ordersRecordData = createOrdersRecordData(
                        //   orderStatus: orderStatus,
                        //   deliveredDate: Timestamp.now(),
                        // );
                        if (Order!.referralCode != null) {
                          QuerySnapshot rUsers = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .where('referralCode',
                              isEqualTo: Order!.referralCode)
                              .get();
                          if (rUsers.docs.length > 0) {
                            DocumentSnapshot rUser = rUsers.docs[0];
                            double? referralCommission = 0;
                            referralCommission = double.tryParse(
                                rUser.get('referralCommission').toString());
                            if (referralCommission != 0) {
                              print("commission");
                              FirebaseFirestore.instance
                                  .collection('referralCommission')
                                  .add({
                                'refferedBy': rUser.id,
                                'referralCode': Order!.referralCode,
                                'date': FieldValue.serverTimestamp(),
                                'userId': Order!.userId,
                                'items': products,
                                'price': Order!.price,
                                'tip': Order!.tip,
                                'deliveryCharge': Order!.deliveryCharge,
                                'total': Order!.total,
                                'gst': Order!.gst,
                                'discount':Order!.discount,
                                'referralCommission': referralCommission,
                                'amount': Order!.total! *
                                    referralCommission! /
                                    100,
                              }).then((value) {
                                rUser.reference.update({
                                  'wallet': FieldValue.increment(
                                      Order!.total! *
                                          referralCommission! /
                                          100)
                                });
                              });
                            }
                          }
                          print("finish");
                        }
                        await FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                          'orderStatus':4,
                          'deliveredDate':Timestamp.now(),
                        });
                        // await orderDetailsOrdersRecord.reference
                        //     .update(ordersRecordData);
                        setState(() {
                          statusController.text = 'Delivered';
                        });
                        await  FirebaseFirestore.instance.collection('users').doc(Order!.userId).update(
                            {
                              'currentB2cAmount':FieldValue.increment(Order!.price??0)
                            });

                      }

                    },
                    child: Container(
                      height: h*0.06,
                      width: w/3.5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectOption1 == 4
                              ? primaryColor
                              : Colors.white,
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'DELIVERED',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: _selectOption1 ==4
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.015)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       // _selectedIndex1 =true;
                  //     });
                  //     // onItemTapped(index);
                  //   },
                  //   child: Container(
                  //     height: h*0.06,
                  //     width: w/3.5,
                  //     alignment: Alignment.center,
                  //     decoration: BoxDecoration(
                  //         color: _selectedIndex1 == true
                  //             ? primaryColor
                  //             : Colors.white,
                  //         border: Border.all(color: primaryColor),
                  //         borderRadius: BorderRadius.circular(5)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Center(
                  //         child: Text(
                  //           'EDIT',
                  //           style: GoogleFonts.roboto(
                  //               textStyle: TextStyle(
                  //                   color: _selectedIndex1 == true
                  //                       ? Colors.white
                  //                       : Colors.black,
                  //                   fontWeight: FontWeight.bold,
                  //                   fontSize: h * 0.015)),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
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
                  Text(Order!.shippingAddress!['name'],style: TextStyle(fontWeight: FontWeight.w500),),
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
                      .format(Order!.placedDate!.toDate()),style: TextStyle(fontWeight: FontWeight.w500),),
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
                  Text(Order!.orderId.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
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
                  Text('THARAE704',style: TextStyle(fontWeight: FontWeight.w500),),
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
                  Text(Order!.referralCode.toString(),style: TextStyle(fontWeight: FontWeight.w500),),
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
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logistics',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.69,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color:Colors.black12)),
                  ),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(2)),
                child: DropdownButtonFormField<String>(
                  value: partner,
                  decoration: InputDecoration(
                    hintText: "Partners",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (crs) {
                    partner = crs;
                    print(partner);
                    setState(() {});
                  },
                  validator: (value) =>
                  value == null ? 'field required' : null,
                  items: p.toList()
                      .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: w/1.6,
                    height: h*0.08,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: primaryColor,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: TextFormField(
                        controller: awbCode,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'AWD Code',
                          labelStyle:
                          TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: 'Enter your AWB Code',
                          hintStyle:
                          TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF8B97A2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      // if(awbCode.text!=''){
                      bool pressed =
                      await alert(context, 'Update AWB');
                      if (pressed) {
                        // FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                        //
                        // })

                        FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                          'awb_code': awbCode.text,
                        });
                        // orderDetailsOrdersRecord.reference.update({
                        //
                        // });
                      }
                      showUploadMessage(context, 'AWB updated...');
                      // }else{
                      //   showUploadMessage(context, 'Please Enter AWB Code...');
                      // }
                    },
                    text: 'Update',
                    options: FFButtonOptions(
                      height:h*0.08,
                      color: primaryColor,
                      textStyle:
                      TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 12, 0, 10),
              child: Row(
                children: [
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFE6E6E6),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: TextFormField(
                        maxLines: 3,
                        controller: trackingUrl,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Tracking Url',
                          labelStyle:
                          TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                          ),
                          hintText: 'Enter your AWB Code',
                          hintStyle:
                          TextStyle(
                            fontFamily: 'Montserrat',
                            color: Color(0xFF8B97A2),
                            fontWeight: FontWeight.w500,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(4.0),
                              topRight: Radius.circular(4.0),
                            ),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Color(0xFF8B97A2),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.01,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FFButtonWidget(
                    onPressed: () async {
                      if(trackingUrl.text!=''){
                        bool pressed =
                        await alert(context, 'Update Tracking Url');
                        if (pressed) {
                          FirebaseFirestore.instance.collection('orders').doc(widget.id).update({
                            'trackingUrl': trackingUrl.text,
                            'partner':partner
                          });
                          // orderDetailsOrdersRecord.reference.update({
                          //   'trackingUrl': trackingUrl.text,
                          //   'partner':partner
                          // });
                        }
                        showUploadMessage(
                            context, 'Tracking Url updated...');
                      }else{
                        showUploadMessage(context, 'Please Enter Tracking Url...');
                      }
                    },
                    text: 'Update',
                    options: FFButtonOptions(
                      height: 40,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      if (trackingUrl.text != '') {
                        bool pressed = await alert(
                            context, 'Launch Tracking Url');
                        if (pressed) {
                          _launchURL(trackingUrl.text);
                        }
                      } else {
                        showUploadMessage(
                            context, 'Please Enter Tracking Url...');
                      }
                    },
                    text: 'Launch',
                    options: FFButtonOptions(
                      height: 40,
                      color: primaryColor,
                      textStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),
                ],
              ),
            ),
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
                  Text(Order!.promoCode.toString(),style: TextStyle(fontWeight: FontWeight.w500,color: primaryColor),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Discount :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹ ${Order!.discount}',style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery Charge :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹ ${Order!.deliveryCharge}',style: TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total (excel.GST) :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹ ${Order!.total!.toStringAsFixed(2)}',style: const TextStyle(fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(left: w*0.05,top: h*0.02,right: w*0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('GST :',style: TextStyle(fontWeight: FontWeight.w500),),
                  Text('₹ ${Order!.gst!.toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.w500),),
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
                              customerId: Order!.userId??"",
                              city: Order!.shippingAddress!['city'],
                            );
                          });
                    },
                    child: Container(
                      height: h*0.06,
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
                children: [
                  Text('Address:',style: TextStyle(fontWeight: FontWeight.w500),),
                  Spacer(),
                  Expanded(child: Text(Order!.shippingAddress!['address'].toString(),style: TextStyle(fontWeight: FontWeight.w500),)),
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
                itemCount:orderData.length,
                itemBuilder: (buildContext, int index) {
                  final itemsItem = Order!.items![index];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                        0, 12, 0, 0),
                    child: Row(
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
                                            InkWell(
                                              onTap:() async {
                                                bool proceed = await alert(
                                                    context, 'You want to accept this product?');
                                                if (proceed) {

                                                }

                                              },
                                              child: Padding(
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
                                                        imageUrl:itemsItem['image'],
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
                                                Text(itemsItem['name'],
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
                                                    itemsItem['quantity'].toString() + ' x ' + itemsItem['price']
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
                                                Padding(
                                                  padding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      0,
                                                      4,
                                                      0,
                                                      4),
                                                  child: Text(itemsItem['status']==0?'pending':'Accepted',
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
                    ),
                  );
                }),
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
