// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../globals/colors.dart';
// import '../../login/otplogin.dart';
// import '../../widgets/util.dart';
// import 'orderDetailsPage.dart';
//
// class AdminOrdersw extends StatefulWidget {
//   const AdminOrdersw({Key? key}) : super(key: key);
//
//   @override
//   State<AdminOrdersw> createState() => _AdminOrdersState();
// }
//
// class _AdminOrdersState extends State<AdminOrdersw> {
//   int _b2cSelectedIndex = 0;
//   int _b2bselectedIndex = 0;
//   bool b2c = true;
//   bool b2b = false;
//   int b2ctapIndex = 0;
//   int b2btapIndex = 0;
//
//   void onItemTapped(int index) {
//     setState(() {
//       b2ctapIndex = index;
//     });
//   }
//   void onItemTapped1(int index) {
//     setState(() {
//       b2btapIndex = index;
//     });
//   }
//
//   Map<String, dynamic> userName = {};
//   Map<String, dynamic> userEmail = {};
//   Map<String, dynamic> userPhoto = {};
//   Map<String, dynamic> userDataMap = {};
//   int statusCode = 0;
//   getUser() async {
//     QuerySnapshot snap =
//     await FirebaseFirestore.instance.collection('users').get();
//     for (DocumentSnapshot doc in snap.docs) {
//       try {
//         userDataMap[doc.id] = doc.data();
//         userName[doc.id] = doc['fullName'];
//         userEmail[doc.id] = doc['email'];
//         userPhoto[doc.id] = doc['photoUrl'];
//       } catch (e) {
//         print(e);
//       }
//     }
//     if (mounted) {
//       setState(() {});
//     }
//   }
//
//   List b2cData = [];
//   List b2bData = [];
//   late Timestamp datePicked1;
//   late Timestamp datePicked2;
//   DateTime selectedDate1 = DateTime.now();
//   DateTime selectedDate2 = DateTime.now();
//   @override
//   void initState() {
//     getUser();
//     DateTime time = DateTime.now();
//     datePicked1 =
//         Timestamp.fromDate(DateTime(time.year, time.month, time.day, 0, 0, 0));
//     datePicked2 = Timestamp.fromDate(
//         DateTime(time.year, time.month, time.day, 23, 59, 59));
//     _b2cSelectedIndex = 0;
//     _b2bselectedIndex = 0;
//     userStream1 = FirebaseFirestore.instance
//         .collection("orders")
//         .where('orderStatus', isEqualTo: _b2cSelectedIndex)
//         .orderBy('placedDate', descending: true)
//         .limit(limit)
//         .snapshots();
//     userStream2 = FirebaseFirestore.instance
//         .collection("b2bOrders")
//         .where('orderStatus', isEqualTo: _b2bselectedIndex)
//         .orderBy('placedDate', descending: true)
//         .limit(limit)
//         .snapshots();
//     // TODO: implement initState
//     super.initState();
//   }
//
//   late Stream userStream1;
//   late Stream userStream2;
//   List overview = [
//     {"text": "Pending"},
//     {"text": "Accepted"},
//     {"text": "Cancelled"},
//     {"text": "Shipped"},
//     {"text": "Delivered"},
//     {"text": "Refund"},
//   ];
//   List overview1 = [
//     {"text": "Pendingg"},
//     {"text": "Accepted"},
//     {"text": "Cancelled"},
//     {"text": "Shipped"},
//     {"text": "Delivered"},
//     {"text": "Refund"},
//   ];
//   int limit = 150;
//   TextEditingController dateInput = TextEditingController();
//   TextEditingController EndDate = TextEditingController();
//   TextEditingController weekController = TextEditingController();
//   List<String> items = ["Today", "This Week", " This Month", "This Year"];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(children: [
//             SizedBox(
//               height: h * 0.01,
//             ),
//             Row(
//               children: [
//                 SizedBox(
//                   width: w * 0.02,
//                 ),
//                 Text(
//                   "Admin B2C Orders",
//                   style: TextStyle(
//                       color: primaryColor,
//                       fontSize: h * 0.014,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(
//                   width: w * 0.01,
//                 ),
//                 SizedBox(
//                   height: h * 0.0020,
//                   width: w * 0.35,
//                   child: DecoratedBox(
//                       decoration: BoxDecoration(color: primaryColor)),
//                 ),
//                 SizedBox(
//                   width: w * 0.01,
//                 ),
//                 Container(
//                     height: h * 0.050,
//                     width: w * 0.278,
//                     child: CustomDropdown(
//                       borderRadius: BorderRadius.circular(5),
//                       fieldSuffixIcon: Icon(
//                         Icons.arrow_drop_down_outlined,
//                         color: Colors.white,
//                         size: h * 0.035,
//                       ),
//                       listItemStyle: TextStyle(fontSize: w * 0.025),
//                       selectedStyle:
//                       TextStyle(fontSize: w * 0.025, color: Colors.white),
//                       fillColor: primaryColor,
//                       hintStyle: TextStyle(fontSize: 6, color: Colors.white),
//                       items: items,
//                       controller: weekController,
//                       onChanged: (value) {
//                         if (value == 'Today') {
//                         } else if (value == 'This Week') {
//                         } else if (value == 'This Month') {
//                         } else if (value == 'This Year') {}
//                         setState(() {});
//                       },
//                     )),
//               ],
//             ),
//             SizedBox(
//               height: h * 0.01,
//             ),
//             Row(
//               children: [
//                 Container(
//                     height: h * 0.050,
//                     width: w * 0.310,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: h * 0.01),
//                       child: TextField(
//                           controller: dateInput,
//                           style: TextStyle(fontSize: 12),
//                           decoration: InputDecoration(
//                               icon: Icon(
//                                 Icons.calendar_today,
//                                 color: primaryColor,
//                               ),
//                               border: InputBorder.none),
//                           readOnly: true,
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1950),
//                                 //DateTime.now() - not to allow to choose before today.
//                                 lastDate: DateTime(2100));
//                             if (pickedDate != null) {
//                               print(
//                                   pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                               String formattedDate =
//                               DateFormat('dd/MM/yyyy').format(pickedDate);
//                               print(
//                                   formattedDate); //formatted date output using intl package =>  2021-03-16
//                               setState(() {
//                                 dateInput.text =
//                                     formattedDate; //set output date to TextField value.
//                               });
//                             }
//                           }),
//                     )),
//                 Container(
//                     height: h * 0.050,
//                     width: w * 0.310,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: primaryColor),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: h * 0.01),
//                       child: TextField(
//                           controller: EndDate,
//                           style: TextStyle(fontSize: 12),
//                           decoration: InputDecoration(
//                               icon: Icon(
//                                 Icons.calendar_today,
//                                 color: primaryColor,
//                               ),
//                               border: InputBorder.none),
//                           readOnly: true,
//                           onTap: () async {
//                             DateTime? pickedDate = await showDatePicker(
//                                 context: context,
//                                 initialDate: DateTime.now(),
//                                 firstDate: DateTime(1950),
//                                 //DateTime.now() - not to allow to choose before today.
//                                 lastDate: DateTime(2100));
//                             if (pickedDate != null) {
//                               print(
//                                   pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                               String formattedDate =
//                               DateFormat('dd/MM/yyyy').format(pickedDate);
//                               print(
//                                   formattedDate); //formatted date output using intl package =>  2021-03-16
//                               setState(() {
//                                 EndDate.text =
//                                     formattedDate; //set output date to TextField value.
//                               });
//                             }
//                           }),
//                     )),
//                 SizedBox(
//                   width: w * 0.01,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     userStream1 = FirebaseFirestore.instance
//                         .collection('orders')
//                         .where('orderStatus', isEqualTo: _b2cSelectedIndex)
//                         .where('placedDate',
//                         isGreaterThanOrEqualTo: datePicked1)
//                         .where('placedDate', isLessThanOrEqualTo: datePicked2)
//                         .orderBy('placedDate', descending: true)
//                         .snapshots();
//                     setState(() {});
//                   },
//                   child: Container(
//                     height: h * 0.050,
//                     width: w * 0.276,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(h * 0.01),
//                         color: primaryColor),
//                     child: Center(
//                         child: Text(
//                           "Go",
//                           style: GoogleFonts.roboto(
//                               textStyle: TextStyle(
//                                   fontSize: h * 0.02, color: Colors.white)),
//                         )),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: h * 0.01,
//             ),
//             Column(
//               children: [
//                 DefaultTabController(
//                     length: 2,
//                     child: Column(
//                       children: [
//                         Container(
//                           height: h * 0.05,
//                           width: w * 0.98,
//                           decoration: BoxDecoration(
//                               color: primaryColor,
//                               borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(10),
//                                   topLeft: Radius.circular(10))),
//                           child: TabBar(
//                             indicatorColor: Colors.transparent,
//                             indicator: BoxDecoration(
//                                 color: Colors.green,
//                                 borderRadius: BorderRadius.only(
//                                     topRight: Radius.circular(10),
//                                     topLeft: Radius.circular(10))),
//                             tabs: [
//                               Tab(text: 'B2C Orders'),
//                               Tab(text: 'B2B Orders')
//                             ],
//                             labelColor: Colors.white,
//                           ),
//                         ),
//                         SizedBox(
//                           height: h,
//                           width: double.infinity,
//                           child: TabBarView(children: [
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Expanded(
//                                     flex: 0,
//                                     child: b2c == true || b2b == true
//                                         ? GridView.builder(
//                                         shrinkWrap: true,
//                                         physics: ClampingScrollPhysics(),
//                                         gridDelegate:
//                                         SliverGridDelegateWithMaxCrossAxisExtent(
//                                             maxCrossAxisExtent: 140,
//                                             mainAxisExtent: 45,
//                                             childAspectRatio: 3 / 2,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: h * 0.01),
//                                         itemCount: overview.length,
//                                         itemBuilder:
//                                             (BuildContext ctx, index) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 onItemTapped(index);
//                                                 _b2cSelectedIndex = index;
//                                                 userStream1 = FirebaseFirestore
//                                                     .instance
//                                                     .collection("orders")
//                                                     .where('orderStatus',
//                                                     isEqualTo: index)
//                                                     .where('vendorId',
//                                                     isEqualTo:
//                                                     'bGa7yjwM1DV4hPpbqksXEoh6DEb2')
//                                                     .orderBy('placedDate',
//                                                     descending: true)
//                                                     .limit(limit)
//                                                     .snapshots();
//                                               });
//                                             },
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                   color: _b2cSelectedIndex ==
//                                                       index
//                                                       ? primaryColor
//                                                       : Colors.white,
//                                                   border: Border.all(
//                                                       color: primaryColor),
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       5)),
//                                               child: Padding(
//                                                 padding:
//                                                 EdgeInsets.all(8.0),
//                                                 child: Center(
//                                                   child: Text(
//                                                     overview[index]["text"],
//                                                     style: GoogleFonts.roboto(
//                                                         textStyle: TextStyle(
//                                                             color: _b2cSelectedIndex ==
//                                                                 index
//                                                                 ? Colors
//                                                                 .white
//                                                                 : Colors
//                                                                 .black,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold,
//                                                             fontSize:
//                                                             h * 0.015)),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         })
//                                         : SizedBox()),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Container(
//                                   height: h * 0.050,
//                                   width: w * 1,
//                                   decoration: BoxDecoration(
//                                     color: primaryColor,
//                                     border: Border.all(color: primaryColor),
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Add Order",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 StreamBuilder(
//                                     stream: userStream1,
//                                     builder: (context, snapshot) {
//                                       print(snapshot.error);
//                                       print(snapshot);
//                                       // Customize what your widget looks like when it's loading.
//                                       if (!snapshot.hasData) {
//                                         return Center(
//                                             child: CircularProgressIndicator());
//                                       }
//                                       b2cData = snapshot.data.docs;
//                                       print(b2cData.length);
//
//                                       // Customize what your widget looks like with no query results.
//                                       if (b2cData.isEmpty) {
//                                         return Center(
//                                             child: Text('No admin Orders'));
//                                         // For now, we'll just include some dummy data.
//                                       }
//                                       return Expanded(
//                                         child: ListView.builder(
//                                             physics: BouncingScrollPhysics(),
//                                             shrinkWrap: true,
//                                             itemCount: b2cData.length,
//                                             itemBuilder: (buildContext,
//                                                 int listViewIndex) {
//                                               String status = b2cData[
//                                               listViewIndex]
//                                               ['orderStatus'] ==
//                                                   0
//                                                   ? 'pending'
//                                                   : b2cData[listViewIndex]
//                                               ['orderStatus'] ==
//                                                   1
//                                                   ? 'Accepted'
//                                                   : b2cData[listViewIndex][
//                                               'orderStatus'] ==
//                                                   2
//                                                   ? 'Cancelled'
//                                                   : b2cData[listViewIndex][
//                                               'orderStatus'] ==
//                                                   3
//                                                   ? 'shipped'
//                                                   : 'Delivered';
//                                               DateTime invoiceDate;
//                                               int invoiceNo;
//                                               String shipRocketOrderId;
//                                               String awbNumber;
//                                               String partner;
//                                               String Id;
//                                               try {
//                                                 partner = b2cData[listViewIndex]
//                                                 ['partner']
//                                                     .toString();
//                                               } catch (e) {
//                                                 print(e);
//                                               }
//                                               try {
//                                                 invoiceDate =
//                                                     b2cData[listViewIndex]
//                                                     ['invoiceDate']
//                                                         .toDate();
//                                                 invoiceNo = b2cData[listViewIndex]
//                                                 ['invoiceNo'];
//                                                 Id = b2cData[listViewIndex]
//                                                 ['orderId'];
//                                                 shipRocketOrderId =
//                                                 b2cData[listViewIndex]
//                                                 ['shipRocketOrderId'];
//                                                 awbNumber = b2cData[listViewIndex]
//                                                 ['awb_code'];
//                                               } catch (e) {
//                                                 invoiceDate = DateTime.now();
//                                                 invoiceNo = 0;
//                                                 Id = '';
//                                                 shipRocketOrderId = '';
//                                               }
//                                               // Map shippingAddress=data[index]['shippingAddress'];
//                                               return Padding(
//                                                 padding: EdgeInsetsDirectional
//                                                     .fromSTEB(10, 5, 10, 10),
//                                                 child: InkWell(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 OrderDetailsPage(
//                                                                   id: b2cData[
//                                                                   listViewIndex]
//                                                                       .id,
//                                                                   email: userDataMap[
//                                                                   b2cData[listViewIndex]
//                                                                   [
//                                                                   'userId']]
//                                                                   ['email'],
//                                                                 )));
//                                                   },
//                                                   child: Container(
//                                                     width: w * 1,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.white,
//                                                       boxShadow: [
//                                                         BoxShadow(
//                                                           blurRadius: 1,
//                                                           color:
//                                                           Color(0x28000000),
//                                                           offset: Offset(0, 1),
//                                                         )
//                                                       ],
//                                                       borderRadius:
//                                                       BorderRadius.circular(
//                                                           8),
//                                                       border: Border.all(
//                                                         color:
//                                                         Color(0xFFDBE2E7),
//                                                         width: 1,
//                                                       ),
//                                                     ),
//                                                     child: Padding(
//                                                       padding:
//                                                       EdgeInsetsDirectional
//                                                           .fromSTEB(
//                                                           4, 10, 4, 10),
//                                                       child: Row(
//                                                         mainAxisSize:
//                                                         MainAxisSize.max,
//                                                         mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .start,
//                                                         children: [
//                                                           Padding(
//                                                             padding:
//                                                             const EdgeInsets
//                                                                 .all(5.0),
//                                                             child: Column(
//                                                               children: [
//                                                                 CircleAvatar(
//                                                                   radius: 20,
//                                                                   backgroundColor:
//                                                                   primaryColor,
//                                                                   child:
//                                                                   CachedNetworkImage(
//                                                                     imageUrl: userPhoto[b2cData[listViewIndex]['userId']] ==
//                                                                         ''
//                                                                         ? 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png'
//                                                                         : userPhoto[b2cData[listViewIndex]
//                                                                     [
//                                                                     'userId']],
//                                                                   ),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           ),
//                                                           SizedBox(
//                                                             width: w * 0.04,
//                                                           ),
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .start,
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .start,
//                                                             children: [
//                                                               Text(
//                                                                 b2cData[listViewIndex]
//                                                                 [
//                                                                 'shippingAddress']
//                                                                 ['name'],
//                                                                 style: TextStyle(
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                               ),
//                                                               Text(
//                                                                 b2cData[listViewIndex]
//                                                                 [
//                                                                 'shippingMethod'],
//                                                                 style: TextStyle(
//                                                                     color:
//                                                                     primaryColor),
//                                                               ),
//                                                               Text(
//                                                                 '₹ ' +
//                                                                     b2cData[listViewIndex]
//                                                                     [
//                                                                     'price']
//                                                                         .toString(),
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .green),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                           Spacer(),
//                                                           Column(
//                                                             crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .end,
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .end,
//                                                             children: [
//                                                               Text(
//                                                                 'Order No :' +
//                                                                     Id,
//                                                                 style: TextStyle(
//                                                                     fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                     fontSize: w *
//                                                                         0.030),
//                                                               ),
//                                                               Text(
//                                                                 'Order Date :' +
//                                                                     dateTimeFormat(
//                                                                         'd-MM-y hh:mm',
//                                                                         b2cData[listViewIndex]['placedDate']
//                                                                             .toDate()),
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize: w *
//                                                                         0.025),
//                                                               ),
//                                                               new RichText(
//                                                                 text:
//                                                                 new TextSpan(
//                                                                   text: '',
//                                                                   children: <
//                                                                       TextSpan>[
//                                                                     new TextSpan(
//                                                                         text:
//                                                                         'Status : ',
//                                                                         style: new TextStyle(
//                                                                             color:
//                                                                             Colors.black,
//                                                                             fontWeight: FontWeight.bold,
//                                                                             fontSize: w * 0.025)),
//                                                                     new TextSpan(
//                                                                         text:
//                                                                         status,
//                                                                         style: new TextStyle(
//                                                                             color:
//                                                                             primaryColor,
//                                                                             fontSize:
//                                                                             w * 0.030)),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               Text(
//                                                                 'Logistics ID :' +
//                                                                     shipRocketOrderId,
//                                                                 style: TextStyle(
//                                                                     color: Colors
//                                                                         .black,
//                                                                     fontSize: w *
//                                                                         0.030),
//                                                               ),
//                                                             ],
//                                                           )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               );
//                                             }),
//                                       );
//                                     }),
//                               ],
//                             ),
//                             Column(
//                               children: [
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Expanded(
//                                     flex: 0,
//                                     child: b2c == true || b2b == true
//                                         ? GridView.builder(
//                                         shrinkWrap: true,
//                                         physics: ClampingScrollPhysics(),
//                                         gridDelegate:
//                                         SliverGridDelegateWithMaxCrossAxisExtent(
//                                             maxCrossAxisExtent: 140,
//                                             mainAxisExtent: 45,
//                                             childAspectRatio: 3 / 2,
//                                             crossAxisSpacing: 10,
//                                             mainAxisSpacing: h * 0.01),
//                                         itemCount: overview1.length,
//                                         itemBuilder:
//                                             (BuildContext ctx, index) {
//                                           return InkWell(
//                                             onTap: () {
//                                               setState(() {
//                                                 onItemTapped1(index);
//                                                 _b2bselectedIndex = index;
//                                                 userStream2 = FirebaseFirestore.instance
//                                                     .collection("b2bOrders")
//                                                     .where('orderStatus', isEqualTo:    index)
//                                                     .where('vendorId',isEqualTo: 'bGa7yjwM1DV4hPpbqksXEoh6DEb2')
//                                                     .orderBy('placedDate', descending: true)
//                                                     .limit(limit)
//                                                     .snapshots();
//                                               });
//
//                                             },
//                                             child: Container(
//                                               alignment: Alignment.center,
//                                               decoration: BoxDecoration(
//                                                   color: _b2bselectedIndex ==
//                                                       index
//                                                       ? primaryColor
//                                                       : Colors.white,
//                                                   border: Border.all(
//                                                       color: primaryColor),
//                                                   borderRadius:
//                                                   BorderRadius.circular(
//                                                       5)),
//                                               child: Padding(
//                                                 padding:
//                                                 EdgeInsets.all(8.0),
//                                                 child: Center(
//                                                   child: Text(
//                                                     overview1[index]["text"],
//                                                     style: GoogleFonts.roboto(
//                                                         textStyle: TextStyle(
//                                                             color: _b2bselectedIndex ==
//                                                                 index
//                                                                 ? Colors
//                                                                 .white
//                                                                 : Colors
//                                                                 .black,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .bold,
//                                                             fontSize:
//                                                             h * 0.015)),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         })
//                                         : SizedBox()),
//                                 SizedBox(
//                                   height: h * 0.01,
//                                 ),
//                                 Container(
//                                   height: h * 0.050,
//                                   width: w * 1,
//                                   decoration: BoxDecoration(
//                                     color: primaryColor,
//                                     border: Border.all(color: primaryColor),
//                                     borderRadius: BorderRadius.only(
//                                       bottomRight: Radius.circular(15),
//                                       bottomLeft: Radius.circular(15),
//                                     ),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       "Add Order",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   child: StreamBuilder(
//                                       stream: userStream2,
//                                       builder: (context, snapshot) {
//                                         print(snapshot.error);
//                                         print(snapshot);
//                                         // Customize what your widget looks like when it's loading.
//                                         if (!snapshot.hasData) {
//                                           return Center(
//                                               child: CircularProgressIndicator());
//                                         }
//                                         b2bData = snapshot.data.docs;
//                                         print(b2cData.length);
//
//                                         // Customize what your widget looks like with no query results.
//                                         if (b2bData.isEmpty) {
//                                           return Center(
//                                               child: Text('No admin Orders'));
//                                           // For now, we'll just include some dummy data.
//                                         }
//                                         return Expanded(
//                                           child: ListView.builder(
//                                               physics: BouncingScrollPhysics(),
//                                               shrinkWrap: true,
//                                               itemCount: b2bData.length,
//                                               itemBuilder: (buildContext,
//                                                   int listViewIndex) {
//                                                 String status = b2bData[
//                                                 listViewIndex]
//                                                 ['orderStatus'] ==
//                                                     0
//                                                     ? 'pending'
//                                                     : b2bData[listViewIndex]
//                                                 ['orderStatus'] ==
//                                                     1
//                                                     ? 'Accepted'
//                                                     : b2bData[listViewIndex][
//                                                 'orderStatus'] ==
//                                                     2
//                                                     ? 'Cancelled'
//                                                     : b2bData[listViewIndex][
//                                                 'orderStatus'] ==
//                                                     3
//                                                     ? 'shipped'
//                                                     : 'Delivered';
//                                                 DateTime invoiceDate;
//                                                 int invoiceNo;
//                                                 String shipRocketOrderId;
//                                                 String awbNumber;
//                                                 String partner;
//                                                 String Id;
//                                                 try {
//                                                   partner = b2bData[listViewIndex]
//                                                   ['partner']
//                                                       .toString();
//                                                 } catch (e) {
//                                                   print(e);
//                                                 }
//                                                 try {
//                                                   invoiceDate =
//                                                       b2bData[listViewIndex]
//                                                       ['invoiceDate']
//                                                           .toDate();
//                                                   invoiceNo = b2bData[listViewIndex]
//                                                   ['invoiceNo'];
//                                                   Id = b2bData[listViewIndex]
//                                                   ['orderId'];
//                                                   shipRocketOrderId =
//                                                   b2bData[listViewIndex]
//                                                   ['shipRocketOrderId'];
//                                                   awbNumber = b2bData[listViewIndex]
//                                                   ['awb_code'];
//                                                 } catch (e) {
//                                                   invoiceDate = DateTime.now();
//                                                   invoiceNo = 0;
//                                                   Id = '';
//                                                   shipRocketOrderId = '';
//                                                 }
//                                                 // Map shippingAddress=data[index]['shippingAddress'];
//                                                 return Padding(
//                                                   padding: EdgeInsetsDirectional
//                                                       .fromSTEB(10, 5, 10, 10),
//                                                   child: InkWell(
//                                                     onTap: () {
//                                                       Navigator.push(
//                                                           context,
//                                                           MaterialPageRoute(
//                                                               builder: (context) =>
//                                                                   OrderDetailsPage(
//                                                                     id: b2bData[
//                                                                     listViewIndex]
//                                                                         .id,
//                                                                     email: userDataMap[
//                                                                     b2bData[listViewIndex]
//                                                                     [
//                                                                     'userId']]
//                                                                     ['email'],
//                                                                   )));
//                                                     },
//                                                     child: Container(
//                                                       width: w * 1,
//                                                       decoration: BoxDecoration(
//                                                         color: Colors.white,
//                                                         boxShadow: [
//                                                           BoxShadow(
//                                                             blurRadius: 1,
//                                                             color:
//                                                             Color(0x28000000),
//                                                             offset: Offset(0, 1),
//                                                           )
//                                                         ],
//                                                         borderRadius:
//                                                         BorderRadius.circular(
//                                                             8),
//                                                         border: Border.all(
//                                                           color:
//                                                           Color(0xFFDBE2E7),
//                                                           width: 1,
//                                                         ),
//                                                       ),
//                                                       child: Padding(
//                                                         padding:
//                                                         EdgeInsetsDirectional
//                                                             .fromSTEB(
//                                                             4, 10, 4, 10),
//                                                         child: Row(
//                                                           mainAxisSize:
//                                                           MainAxisSize.max,
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                           children: [
//                                                             Padding(
//                                                               padding:
//                                                               const EdgeInsets
//                                                                   .all(5.0),
//                                                               child: Column(
//                                                                 children: [
//                                                                   CircleAvatar(
//                                                                     radius: 20,
//                                                                     backgroundColor:
//                                                                     primaryColor,
//                                                                     child:
//                                                                     CachedNetworkImage(
//                                                                       imageUrl: userPhoto[b2bData[listViewIndex]['userId']] ==
//                                                                           ''
//                                                                           ? 'https://cdn1.iconfinder.com/data/icons/ecommerce-gradient/512/ECommerce_Website_App_Online_Shop_Gradient_greenish_lineart_Modern_profile_photo_person_contact_account_buyer_seller-512.png'
//                                                                           : userPhoto[b2bData[listViewIndex]
//                                                                       [
//                                                                       'userId']],
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             SizedBox(
//                                                               width: w * 0.04,
//                                                             ),
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                               mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                               children: [
//                                                                 Text(
//                                                                   b2bData[listViewIndex]
//                                                                   [
//                                                                   'shippingAddress']
//                                                                   ['name'],
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                       FontWeight
//                                                                           .bold),
//                                                                 ),
//                                                                 Text(
//                                                                   b2bData[listViewIndex]
//                                                                   [
//                                                                   'shippingMethod'],
//                                                                   style: TextStyle(
//                                                                       color:
//                                                                       primaryColor),
//                                                                 ),
//                                                                 Text(
//                                                                   '₹ ' +
//                                                                       b2bData[listViewIndex]
//                                                                       [
//                                                                       'price']
//                                                                           .toString(),
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .green),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             Spacer(),
//                                                             Column(
//                                                               crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .end,
//                                                               mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .end,
//                                                               children: [
//                                                                 Text(
//                                                                   'Order No :' +
//                                                                       Id,
//                                                                   style: TextStyle(
//                                                                       fontWeight:
//                                                                       FontWeight
//                                                                           .bold,
//                                                                       fontSize: w *
//                                                                           0.030),
//                                                                 ),
//                                                                 Text(
//                                                                   'Order Date :' +
//                                                                       dateTimeFormat(
//                                                                           'd-MM-y hh:mm',
//                                                                           b2bData[listViewIndex]['placedDate']
//                                                                               .toDate()),
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .black,
//                                                                       fontSize: w *
//                                                                           0.025),
//                                                                 ),
//                                                                 new RichText(
//                                                                   text:
//                                                                   new TextSpan(
//                                                                     text: '',
//                                                                     children: <
//                                                                         TextSpan>[
//                                                                       new TextSpan(
//                                                                           text:
//                                                                           'Status : ',
//                                                                           style: new TextStyle(
//                                                                               color:
//                                                                               Colors.black,
//                                                                               fontWeight: FontWeight.bold,
//                                                                               fontSize: w * 0.025)),
//                                                                       new TextSpan(
//                                                                           text:
//                                                                           status,
//                                                                           style: new TextStyle(
//                                                                               color:
//                                                                               primaryColor,
//                                                                               fontSize:
//                                                                               w * 0.030)),
//                                                                     ],
//                                                                   ),
//                                                                 ),
//                                                                 Text(
//                                                                   'Logistics ID :' +
//                                                                       shipRocketOrderId,
//                                                                   style: TextStyle(
//                                                                       color: Colors
//                                                                           .black,
//                                                                       fontSize: w *
//                                                                           0.030),
//                                                                 ),
//                                                               ],
//                                                             )
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 );
//                                               }),
//                                         );
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           ]),
//                         )
//                       ],
//                     )),
//               ],
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
