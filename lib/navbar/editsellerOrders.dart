import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../globals/colors.dart';

import '../login/splashscreen.dart';
import '../model/usermodel.dart';

import 'orders/b2c/orderDetailsPage.dart';
class sellerOrders extends StatefulWidget {
  const sellerOrders({Key? key}) : super(key: key);

  @override
  State<sellerOrders> createState() => _sellerOrdersState();
}

class _sellerOrdersState extends State<sellerOrders> with TickerProviderStateMixin {
  int _b2cSelectedIndex = 0;
  int _b2bselectedIndex = 0;
  bool b2c = true;
  bool b2b = false;
  int b2ctapIndex = 0;
  int b2btapIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      b2ctapIndex = index;
    });
  }

  void onItemTapped1(int index) {
    setState(() {
      b2btapIndex = index;
    });
  }

  Map<String, dynamic> userName = {};
  Map<String, dynamic> userEmail = {};
  Map<String, dynamic> userPhoto = {};
  Map<String, dynamic> userDataMap = {};
  int statusCode = 0;
  getUser() async {
    QuerySnapshot snap =
    await FirebaseFirestore.instance.collection('users').get();
    for (DocumentSnapshot doc in snap.docs) {
      try {
        userDataMap[doc.id] = doc.data();
        userName[doc.id] = doc['fullName'];
        userEmail[doc.id] = doc['email'];
        userPhoto[doc.id] = doc['photoUrl'];
      } catch (e) {
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  List b2cData = [];
  List b2bData = [];
  late Timestamp datePicked1;
  late Timestamp datePicked2;
  late Timestamp pickedDate;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TabController? _controller;
  int? index;
  @override
  void initState() {


    print(currentUser?.id);
    print('currentUser?.id');
    DateTime now=DateTime.now();
    /// today
    DateTime today=DateTime(now.year,now.month,now.day);

    /// week
    DateTime week= now.subtract(Duration(days: 7));

    ///month
    DateTime month=DateTime(now.year,now.month,1);

    ///Year
    DateTime year=DateTime(now.year,1,1);

    ///
    getUser();
    DateTime time = DateTime.now();
    datePicked1 =
        Timestamp.fromDate(DateTime(time.year, time.month, time.day, 0, 0, 0));
    datePicked2 = Timestamp.fromDate(
        DateTime(time.year, time.month, time.day, 23, 59, 59));
    _b2cSelectedIndex = 0;
    _b2bselectedIndex = 0;
    _controller = TabController(length: 2, vsync: this);
    _controller?.addListener(() {
      setState(() {
        index = _controller?.index ?? 0;
      });
    });
    userStream1 = sortController.text.isEmpty?FirebaseFirestore.instance
        .collection("orders")
        .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains:currentUser?.id)
        .orderBy('placedDate', descending: true)
        .limit(limit)
        .snapshots()
        :FirebaseFirestore.instance
        .collection("orders")
        .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains: currentUser?.id)
        .where('placedDate',isGreaterThanOrEqualTo:sortController.text=='Today'?
    today:sortController.text=='This Week'?week:sortController.text=='This Month'?month:year)
        .orderBy('placedDate', descending: true)
        .limit(limit)
        .snapshots();

    //  userStream2 = sortController.text.isEmpty?FirebaseFirestore.instance
    // .collection("b2bOrders")
    // .where('orderStatus', isEqualTo: _b2bselectedIndex).where('shops',arrayContains: currentUser?.id)
    // .orderBy('placedDate', descending: true)
    // .limit(limit)
    // .snapshots():FirebaseFirestore.instance
    // .collection("b2bOrders")
    // .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains: currentUser?.id)
    // .where('placedDate',isGreaterThanOrEqualTo:sortController.text=='Today'?
    // today:sortController.text=='This Week'?week:sortController.text=='This Month'?month:year)
    // .orderBy('placedDate', descending: true)
    // .limit(limit)
    // .snapshots();


    // TODO: implement initState
    super.initState();
  }
  List<String> sorting = ["Today", "This Week", "This Month", "This Year"];

  // sortByMonth(String type){
  //
  //
  //   FirebaseFirestore.instance.collection('orders')
  //       .where('placedDate',isGreaterThanOrEqualTo:type=='Today'?today:type=='This Week'?week:type=='This Month'?month:year)
  //       .get().then((value) {
  //
  //     if(mounted){
  //       setState(() {
  //
  //       });
  //     }
  //     print('sorttttttttttttttttttttttt');
  //     print(sorting);
  //
  //       });
  // }

  Stream<QuerySnapshot>? userStream1;
  Stream<QuerySnapshot>? userStream2;
  List overview = [
    {"text": "Pending"},
    {"text": "Accepted"},
    {"text": "Cancelled"},
    {"text": "Shipped"},
    {"text": "Delivered"},
    {"text": "Refund"},
  ];
  List overview1 = [
    {"text": "Pending"},
    {"text": "Accepted"},
    {"text": "Cancelled"},
    {"text": "Shipped"},
    {"text": "Delivered"},
    {"text": "Refund"},
  ];
  int limit = 150;
  TextEditingController dateInput = TextEditingController();
  TextEditingController EndDate = TextEditingController();
  TextEditingController sortController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    DateTime now=DateTime.now();
    /// today
    DateTime today=DateTime(now.year,now.month,now.day);

    /// week
    DateTime week= now.subtract(Duration(days: 7));

    ///month
    DateTime month=DateTime(now.year,now.month,1);

    ///Year
    DateTime year=DateTime(now.year,1,1);
    ///
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10,right: 10),
          child: Column(children: [
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              children: [
                Text(
                  "B2C Orders",
                  style: TextStyle(
                      color: primaryColor1,
                      fontSize: h * 0.014,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                SizedBox(
                  height: h * 0.0020,
                  width: w * 0.50,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: primaryColor)),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                Container(
                    height: h * 0.045,
                    width: w * 0.279,
                    child:CustomDropdown(
                      borderRadius: BorderRadius.circular(5),
                      fieldSuffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.white,
                        size: h * 0.035,
                      ),
                      listItemStyle: TextStyle(fontSize: w * 0.025),
                      selectedStyle: TextStyle(
                          fontSize: w * 0.025, color: Colors.white),
                      fillColor: Color(0xFF7C29E5),
                      hintStyle: TextStyle(
                          fontSize: h * 0.011, color: Colors.white),
                      items:sorting,
                      controller: sortController,
                      onChanged: (value) {
                        setState(() {

                          // sortController.text=value;

                        });

                      },

                    )),
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Row(
              children: [
                Container(
                    height: h * 0.050,
                    width: w * 0.33,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),bottomLeft:Radius.circular(5) )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: h * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: selectedDate1,
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050),
                              );
                              if (selected != null && selected != selectedDate1){
                                datePicked1=Timestamp.fromDate(selectedDate1);
                                setState(() {
                                  selectedDate1 = selected;
                                });
                              }


                            },
                            child: Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                              size: h*0.025,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "${selectedDate1.day}/${selectedDate1.month}/${selectedDate1.year}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: primaryColor1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                Container(
                    height: h * 0.050,
                    width: w * 0.33,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),bottomRight:Radius.circular(5) )
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: h * 0.01),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: selectedDate2,
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2050),
                              );
                              if (selected != null && selected != selectedDate2){
                                datePicked2=Timestamp.fromDate(selectedDate2);
                                setState(() {
                                  selectedDate2 = selected;
                                });

                              }
                            },
                            child: Icon(
                              Icons.calendar_today,
                              color: primaryColor,
                              size: h*0.025,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text(
                            "${selectedDate2.day}/${selectedDate2.month}/${selectedDate2.year}",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: primaryColor1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                InkWell(
                  onTap: () {

                    userStream1 = FirebaseFirestore.instance
                        .collection('orders')
                        .where('orderStatus', isEqualTo: _b2cSelectedIndex)
                        .where('shipThrough',isEqualTo: true)
                        .where('placedDate', isGreaterThanOrEqualTo: datePicked1)
                        .where('placedDate', isLessThanOrEqualTo: datePicked2)
                        .orderBy('placedDate', descending: true)
                        .snapshots();
                    setState(() {});
                    setState(() {

                    });

                  },
                  child: Container(
                    height: h * 0.048,
                    width: w * 0.275,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: primaryColor),
                    child: Center(
                        child: Text(
                          "Go",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: h * 0.02, color: Colors.white)),
                        )),
                  ),
                )
              ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Column(
              children: [
                DefaultTabController(
                    initialIndex: 0 ,
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          height: h * 0.05,
                          width: w * 0.98,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                          child: TabBar(
                            physics: ClampingScrollPhysics(),
                            onTap: (value) {
                              index = value;
                            },
                            // controller: _controller,
                            indicatorColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            tabs: [
                              Tab(text: 'B2C Orders'),
                              Tab(text: 'B2B Orders')
                            ],
                            labelColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: h,
                          width: double.infinity,
                          child: TabBarView(
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Expanded(
                                        flex: 0,
                                        child: b2c == true || b2b == true
                                            ? GridView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 140,
                                                mainAxisExtent: 45,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: h * 0.01),
                                            itemCount: overview.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    onItemTapped(index);
                                                    _b2cSelectedIndex = index;
                                                    userStream1 = FirebaseFirestore
                                                        .instance
                                                        .collection("orders")
                                                        .where('orderStatus', isEqualTo: index)
                                                        .where('shipThrough',isEqualTo: true)
                                                        .orderBy('placedDate', descending: true)
                                                        .limit(limit)
                                                        .snapshots();
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      _b2cSelectedIndex ==
                                                          index
                                                          ? primaryColor
                                                          : Colors.white,
                                                      border: Border.all(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(8.0),
                                                    child: Center(
                                                      child: Text(
                                                        overview[index]["text"],
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: _b2cSelectedIndex ==
                                                                    index
                                                                    ? Colors
                                                                    .white
                                                                    : Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                h * 0.015)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                            : SizedBox()),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                        stream: userStream1,


                                        // sortController.text.isEmpty?FirebaseFirestore.instance
                                        //     .collection("orders")
                                        //     .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains:currentUser?.id )
                                        //     .orderBy('placedDate', descending: true)
                                        //     .limit(limit)
                                        //     .snapshots()
                                        //     :FirebaseFirestore.instance
                                        //     .collection("orders")
                                        //     .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains:currentUser?.id )
                                        //     .where('placedDate',isGreaterThanOrEqualTo:sortController.text=='Today'?today:sortController.text=='This Week'?week:
                                        // sortController.text=='This Month'?month:year)
                                        //     .orderBy('placedDate', descending: true)
                                        //     .limit(limit)
                                        //     .snapshots(),

                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                          b2cData = snapshot.data!.docs;
                                          if (b2cData.isEmpty) {
                                            return const Center(
                                                child: Text('No Orders'));
                                          }
                                          return Expanded(
                                            child: ListView.builder(
                                                physics: BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: b2cData.length,

                                                itemBuilder: (buildContext, int listViewIndex) {
                                                  Timestamp placedDate=b2cData[listViewIndex]['placedDate'];
                                                  String date=DateFormat('dd-MM-yyyy hh:mm').format(placedDate.toDate().toLocal());
                                                  String status = b2cData[
                                                  listViewIndex]
                                                  ['orderStatus'] ==
                                                      0
                                                      ? 'pending'
                                                      : b2cData[listViewIndex]
                                                  ['orderStatus'] ==
                                                      1
                                                      ? 'Accepted'
                                                      : b2cData[listViewIndex][
                                                  'orderStatus'] ==
                                                      2
                                                      ? 'Cancelled'
                                                      : b2cData[listViewIndex]
                                                  ['orderStatus'] == 3
                                                      ? 'shipped'
                                                      : b2cData[listViewIndex]
                                                  ['orderStatus'] == 4?'Delivered':'Refund';
                                                  DateTime invoiceDate;
                                                  int invoiceNo;
                                                  String awbNumber;
                                                  String partner;

                                                  try {
                                                    // partner = b2cData[listViewIndex]
                                                    //         ['partner']
                                                    //     .toString();
                                                  } catch (e) {
                                                    print(e);
                                                  }
                                                  try {
                                                    invoiceDate = b2cData[listViewIndex]['invoiceDate'].toDate();
                                                    invoiceNo =
                                                    b2cData[listViewIndex]
                                                    ['invoiceNo'];


                                                    awbNumber =
                                                    b2cData[listViewIndex]
                                                    ['awb_code'];

                                                  } catch (e) {
                                                    invoiceDate = DateTime.now();
                                                    invoiceNo = 0;
                                                  }
                                                  // Map shippingAddress=data[index]['shippingAddress'];
                                                  return InkWell(
                                                    onTap: () {
                                                      // Navigator.push(context, MaterialPageRoute(
                                                      //     builder: (context) =>
                                                      //         OrderDetailsPage(
                                                      //             id: b2cData[
                                                      //             listViewIndex]
                                                      //                 .id,
                                                      //
                                                      //         )));
                                                    },
                                                    child: Container(
                                                      width: w * 1,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            blurRadius: 1,
                                                            color:
                                                            Color(0x28000000),
                                                            offset: Offset(0, 1),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                        border: Border.all(
                                                          color:
                                                          Color(0xFFDBE2E7),
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            4, 10, 4, 10),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                              child: Column(
                                                                children: [
                                                                  userPhoto[b2cData[listViewIndex]['userId']]==''?CircleAvatar(
                                                                      radius: 20,
                                                                      backgroundColor:
                                                                      primaryColor,
                                                                      child: CachedNetworkImage(
                                                                        imageUrl: userPhoto[b2cData[listViewIndex]['userId']]??"",
                                                                      )
                                                                  )
                                                                      :const CircleAvatar(
                                                                    radius: 20,
                                                                    backgroundImage: AssetImage('assets/images/User Icon.jpg'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: w * 0.04,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Text(
                                                                  b2cData[listViewIndex]
                                                                  ['shippingAddress']['name'],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                                ),
                                                                SizedBox(
                                                                  height: w * 0.01,
                                                                ),
                                                                Text(
                                                                  b2cData[listViewIndex]
                                                                  [
                                                                  'shippingMethod'],
                                                                  style: TextStyle(
                                                                      color:
                                                                      primaryColor),
                                                                ),
                                                                SizedBox(
                                                                  height: w * 0.01,
                                                                ),
                                                                Text(
                                                                  '₹ ' +
                                                                      b2cData[listViewIndex]
                                                                      [
                                                                      'price']
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green),
                                                                ),
                                                              ],
                                                            ),
                                                            Spacer(),
                                                            Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                              children: [
                                                                Text(
                                                                  'Order No :' +
                                                                      b2cData[listViewIndex]
                                                                      ['orderId'],
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                      fontSize: w *
                                                                          0.030),
                                                                ),
                                                                SizedBox(
                                                                  height: w * 0.01,
                                                                ),
                                                                Text(
                                                                  'Order Date :' +
                                                                      date,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: w *
                                                                          0.030),
                                                                ),
                                                                SizedBox(
                                                                  height: w * 0.01,
                                                                ),
                                                                new RichText(
                                                                  text:
                                                                  new TextSpan(
                                                                    text: '',
                                                                    children: <
                                                                        TextSpan>[
                                                                      new TextSpan(
                                                                          text:
                                                                          'Status : ',
                                                                          style: new TextStyle(
                                                                              color:
                                                                              Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: w * 0.025)),
                                                                      new TextSpan(
                                                                          text:
                                                                          status,
                                                                          style: new TextStyle(
                                                                              color:
                                                                              primaryColor,
                                                                              fontSize:
                                                                              w * 0.030)),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: w * 0.01,
                                                                ),
                                                                // b2cData[listViewIndex]
                                                                // ['orderStatus']==3?Text(
                                                                //   'Logistics ID :' + b2cData[listViewIndex]['shipRocketOrderId'],
                                                                //   style: TextStyle(
                                                                //       color: Colors
                                                                //           .black,
                                                                //       fontSize: w *
                                                                //           0.030),
                                                                // ):Container(),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          );
                                        }),
                                  ],
                                ),

                                Column(
                                  children: [
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Expanded(
                                        flex: 0,
                                        child: b2c == true || b2b == true
                                            ? GridView.builder(
                                            shrinkWrap: true,
                                            physics: ClampingScrollPhysics(),
                                            gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                                maxCrossAxisExtent: 140,
                                                mainAxisExtent: 45,
                                                childAspectRatio: 3 / 2,
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: h * 0.01),
                                            itemCount: overview1.length,
                                            itemBuilder:
                                                (BuildContext ctx, index) {
                                              return InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    onItemTapped1(index);

                                                    _b2bselectedIndex = index;
                                                    userStream2 = FirebaseFirestore
                                                        .instance
                                                        .collection("b2bOrders")
                                                        .where('orderStatus',
                                                        isEqualTo: index)
                                                        .where('shops',
                                                        arrayContains:currentUser?.id
                                                    )
                                                        .orderBy('placedDate',
                                                        descending: true)
                                                        .limit(limit)
                                                        .snapshots();
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                      _b2bselectedIndex ==
                                                          index
                                                          ? primaryColor
                                                          : Colors.white,
                                                      border: Border.all(
                                                          color: primaryColor),
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5)),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.all(8.0),
                                                    child: Center(
                                                      child: Text(
                                                        overview1[index]
                                                        ["text"],
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: _b2bselectedIndex ==
                                                                    index
                                                                    ? Colors
                                                                    .white
                                                                    : Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontSize:
                                                                h * 0.015)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                            : SizedBox()),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),

                                    StreamBuilder<QuerySnapshot>(
                                        stream: sortController.text.isEmpty?FirebaseFirestore.instance
                                            .collection("b2bOrders")
                                            .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains:currentUser?.id )
                                            .orderBy('placedDate', descending: true)
                                            .limit(limit)
                                            .snapshots()
                                            :FirebaseFirestore.instance
                                            .collection("b2bOrders")
                                            .where('orderStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains:currentUser?.id )
                                            .where('placedDate',isGreaterThanOrEqualTo:sortController.text=='Today'?today:sortController.text=='This Week'?week:
                                        sortController.text=='This Month'?month:year)
                                            .orderBy('placedDate', descending: true)
                                            .limit(limit)
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          // Customize what your widget looks like when it's loading.
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child: CircularProgressIndicator());
                                          }
                                          b2bData = snapshot.data!.docs;
                                          // Customize what your widget looks like with no query results.
                                          if (b2bData.isEmpty) {
                                            return Center(
                                                child: Text('No Orders'));
                                            // For now, we'll just include some dummy data.
                                          }
                                          return Expanded(
                                            child: ListView.builder(
                                                physics: BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: b2bData.length,
                                                itemBuilder: (buildContext,
                                                    int listViewIndex) {
                                                  Timestamp placedDate=b2bData[listViewIndex]['placedDate'];
                                                  String date=DateFormat('dd-MM-yyyy hh:mm').format(placedDate.toDate().toLocal());
                                                  String status = b2bData[
                                                  listViewIndex]
                                                  ['orderStatus'] ==
                                                      0
                                                      ? 'pending'
                                                      : b2bData[listViewIndex]
                                                  ['orderStatus'] ==
                                                      1
                                                      ? 'Accepted'
                                                      : b2bData[listViewIndex][
                                                  'orderStatus'] ==
                                                      2
                                                      ? 'Cancelled'
                                                      : b2bData[listViewIndex]
                                                  [
                                                  'orderStatus'] ==
                                                      3
                                                      ? 'shipped'
                                                      : b2bData[listViewIndex]
                                                  ['orderStatus'] == 4?'Delivered':'Refund';
                                                  return Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(5, 5, 5, 10),
                                                    child: InkWell(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (context) =>
                                                        //             b2bOrderDetails(
                                                        //                 id: b2bData[
                                                        //                 listViewIndex]
                                                        //                     .id,
                                                        //
                                                        //             )));
                                                      },
                                                      child: Container(
                                                        width: w * 1,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              blurRadius: 1,
                                                              color:
                                                              Color(0x28000000),
                                                              offset: Offset(0, 1),
                                                            )
                                                          ],
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                          border: Border.all(
                                                            color:
                                                            Color(0xFFDBE2E7),
                                                            width: 1,
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              4, 10, 4, 10),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize.max,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(5.0),
                                                                child: Column(
                                                                  children: [
                                                                    userPhoto[b2bData[listViewIndex]['userId']]==''?CircleAvatar(
                                                                        radius: 20,
                                                                        backgroundColor:
                                                                        primaryColor,
                                                                        child: CachedNetworkImage(
                                                                          imageUrl: userPhoto[b2bData[listViewIndex]['userId']]??"",
                                                                        )
                                                                    ):CircleAvatar(
                                                                      radius: 20,
                                                                      backgroundImage: AssetImage('assets/images/User Icon.jpg'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: w * 0.04,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    b2bData[listViewIndex]['shippingAddress']['name'],
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: w * 0.01,
                                                                  ),
                                                                  Text(
                                                                    b2bData[listViewIndex]
                                                                    [
                                                                    'shippingMethod'],
                                                                    style: TextStyle(
                                                                        color:
                                                                        primaryColor),
                                                                  ),
                                                                  SizedBox(
                                                                    height: w * 0.01,
                                                                  ),
                                                                  Text(
                                                                    '₹ ' +
                                                                        b2bData[listViewIndex]
                                                                        [
                                                                        'price']
                                                                            .toString(),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .green),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                                children: [
                                                                  Text(
                                                                    'Order No :' +
                                                                        b2bData[listViewIndex]
                                                                        ['orderId'],
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        fontSize: w *
                                                                            0.030),
                                                                  ),
                                                                  SizedBox(
                                                                    height: w * 0.01,
                                                                  ),
                                                                  Text(
                                                                    'Order Date :' +
                                                                        date,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize: w *
                                                                            0.025),
                                                                  ),
                                                                  SizedBox(
                                                                    height: w * 0.01,
                                                                  ),
                                                                  new RichText(
                                                                    text:
                                                                    new TextSpan(
                                                                      text: '',
                                                                      children: <
                                                                          TextSpan>[
                                                                        new TextSpan(
                                                                            text:
                                                                            'Status : ',
                                                                            style: new TextStyle(
                                                                                color:
                                                                                Colors.black,
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: w * 0.025)),
                                                                        new TextSpan(
                                                                            text:
                                                                            status,
                                                                            style: new TextStyle(
                                                                                color:
                                                                                primaryColor,
                                                                                fontSize:
                                                                                w * 0.030)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: w * 0.01,
                                                                  ),
                                                                  // b2bData[listViewIndex]['shipRocketOrderId']==""? Text(
                                                                  //   'Logistics ID :' +
                                                                  //       b2bData[listViewIndex]['shipRocketOrderId'],
                                                                  //   style: TextStyle(
                                                                  //       color: Colors
                                                                  //           .black,
                                                                  //       fontSize: w *
                                                                  //           0.030),
                                                                  // ):Container(),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          );
                                        }),
                                  ],
                                ),
                              ]),
                        )
                      ],
                    )),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
