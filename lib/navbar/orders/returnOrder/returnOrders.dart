import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../globals/colors.dart';
import '../../../login/splashscreen.dart';
import '../../../model/usermodel.dart';
import 'cancelRequestView.dart';

class ReturnRequest extends StatefulWidget {
  const ReturnRequest({Key? key}) : super(key: key);

  @override
  State<ReturnRequest> createState() => _ReturnRequestState();
}

class _ReturnRequestState extends State<ReturnRequest> with TickerProviderStateMixin {
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
        .collection("cancellationRequests")
        .where('cancellationStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains: currentUser?.id)
        .orderBy('cancellationDate', descending: true)
        .limit(limit)
        .snapshots()
        :FirebaseFirestore.instance
        .collection("cancellationRequests")
        .where('cancellationStatus', isEqualTo: _b2cSelectedIndex).where('shops',arrayContains: currentUser?.id)
        .where('cancellationDate',isGreaterThanOrEqualTo:sortController.text=='Today'?
    today:sortController.text=='This Week'?week:sortController.text=='This Month'?month:year)
        .orderBy('cancellationDate', descending: true)
        .limit(limit)
        .snapshots();


    // TODO: implement initState
    super.initState();
  }
  List<String> sorting = ["Today", "This Week", "This Month", "This Year"];


  Stream<QuerySnapshot>? userStream1;
  Stream<QuerySnapshot>? userStream2;
  List overview = [
    {"text": "Requests"},
    {"text": "Approved"},
    {"text": "Rejected"},

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
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  children: [
                    Text(
                      "Return Request",
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
                      width: w * 0.46,
                      child: DecoratedBox(
                          decoration: BoxDecoration(color: primaryColor)),
                    ),
                    SizedBox(
                      width: w * 0.01,
                    ),
                    Container(
                        height: h * 0.045,
                        width: w * 0.275,
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
                        width: w * 0.30,
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
                        FirebaseFirestore.instance
                            .collection('cancellationRequests')
                            .where('cancellationStatus', isEqualTo: _b2cSelectedIndex)
                            .where('cancellationDate', isGreaterThanOrEqualTo: selectedDate1)
                            .where('cancellationDate', isLessThanOrEqualTo: selectedDate2)
                            .orderBy('cancellationDate', descending: true)
                            .limit(100)
                            .snapshots();
                        setState(() {});
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
                SizedBox(
                  height: h * 0.01,
                ),
                GridView.builder(
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
                                .collection("cancellationRequests")
                                .where('cancellationStatus',
                                isEqualTo: index)
                                .orderBy('cancellationDate',
                                descending: true)
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
                    }),
                SizedBox(
                  height: h * 0.01,),
                Container(
                  height: 200,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: userStream1,
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return Center(
                              child: CircularProgressIndicator());
                        }
                        b2cData = snapshot.data!.docs;
                        if (b2cData.isEmpty) {
                          return const Center(
                              child: Text('No Cancelled Orders'));
                        }
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: b2cData.length,
                            itemBuilder: (buildContext, int listViewIndex) {
                              Timestamp cancellationDate= Timestamp.fromDate(b2cData[listViewIndex]['cancellationDate'].toDate());
                              String date=DateFormat('dd-MM-yyyy hh:mm').format(cancellationDate.toDate());

                              String cancelledDate1= b2cData[listViewIndex]['cancelledDate']!=null
                                  ?DateFormat('dd-MM-yyyy hh:mm').format((Timestamp.fromDate(b2cData[listViewIndex]['cancelledDate']).toDate()))
                                  :"";
                              String acceptedDate= b2cData[listViewIndex]['acceptedDate']!=null
                                  ?DateFormat('dd-MM-yyyy hh:mm').format((Timestamp.fromDate(b2cData[listViewIndex]['acceptedDate']).toDate()))
                                  :"";
                              String status = b2cData[listViewIndex]['cancellationStatus'] ==
                                  0
                                  ? 'pending'
                                  : b2cData[listViewIndex]['cancellationStatus'] ==
                                  1
                                  ? 'Accepted'
                                  : 'Rejected';

                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          CancelViewPage(
                                            id: b2cData[listViewIndex].id,
                                          )));
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
                                            Text('TCE-${b2cData[listViewIndex]['invoiceNo'].toString()}',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            SizedBox(
                                              height: w * 0.01,
                                            ),
                                            Text('OrderId :',
                                              style: TextStyle(
                                                  color:
                                                  primaryColor),
                                            ),
                                            SizedBox(
                                              height: w * 0.01,
                                            ),
                                            Text(b2cData[listViewIndex]['shippingAddress']['name'],
                                              style: TextStyle(
                                                  color:Colors.black),
                                            ),
                                            SizedBox(
                                              height: w * 0.01,
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
                                              'Requested Date:$date',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black,
                                                  fontSize: w *
                                                      0.040),
                                            ),
                                            SizedBox(
                                              height: w * 0.01,
                                            ),
                                            status==1?Text(
                                              'Requested Date:$acceptedDate',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black,
                                                  fontSize: w *
                                                      0.040),
                                            ):Container(),
                                            SizedBox(
                                              height: w * 0.01,
                                            ),
                                            status==2?Text(
                                              'Rejected Date:$cancelledDate1',
                                              style: TextStyle(
                                                  color: Colors
                                                      .black,
                                                  fontSize: w *
                                                      0.040),
                                            ):Container(),
                                            Row(
                                              children: [
                                                Text(
                                                  b2cData[listViewIndex]['shippingMethod'],
                                                  style: TextStyle(
                                                      color:primaryColor,
                                                      fontSize: w *
                                                          0.040),
                                                ),
                                                SizedBox(width: 5,),
                                                Text('₹ ' +b2cData[listViewIndex]['price'].toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .green,
                                                      fontSize: w *
                                                          0.040),
                                                ),
                                              ],
                                            ),

                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                ),
              ]),
        ),
      ),
    );
  }
}
