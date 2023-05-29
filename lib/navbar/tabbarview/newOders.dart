import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../../globals/colors.dart';
import '../../login/otplogin.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders> {
  int _selectedIndex1 = -1;
  bool b2c = true;
  bool b2b = false;
  int _selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List overview = [
    {"text": "Pending"},
    {"text": "Accepted"},
    {"text": "Cancelled"},
    {"text": "Shipped"},
    {"text": "Deliverd"},
    {"text": "Refund"},
  ];
  TextEditingController hi = TextEditingController();
  List<String> items = ["Today", "This Week", " This Month", "This Year"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: h*0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: w * 0.02,
              ),
              Text(
                "B2C Orders",
                style: TextStyle(
                    color: primaryColor,
                    fontSize: h * 0.015,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: w * 0.02,
              ),
              SizedBox(
                height: h * 0.0020,
                width: w * 0.36,
                child: DecoratedBox(
                    decoration: BoxDecoration(color: primaryColor)),
              ),
              SizedBox(
                width: w * 0.02,
              ),
              Column(
                children: [
// Container(
//     height: h * 0.050,
//     width: w * 0.320,
//     child: CustomDropdown(
//       fieldSuffixIcon: Icon(
//         Icons.arrow_drop_down_outlined,
//         color: Colors.white,
//         size: h * 0.035,
//       ),
//       listItemStyle: TextStyle(fontSize: w * 0.025),
//       selectedStyle:
//           TextStyle(fontSize: w * 0.025, color: Colors.white),
//       fillColor: primaryColor,
//       hintStyle: TextStyle(fontSize: 6, color: Colors.white),
//       items: items,
//       controller: hi,
//     )),
                ],
              ),
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            children: [
              Container(
                height: h * 0.050,
                width: w * 0.350,
                decoration: BoxDecoration(
                  border: Border.all(color: primaryColor),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              Container(
                height: h * 0.050,
                width: w * 0.350,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Icon(
                      Icons.calendar_today,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: w * 0.02,
              ),
              Container(
                height: h * 0.050,
                width: w * 0.200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor),
                child: Center(
                    child: Text(
                  "Go",
                  style: GoogleFonts.roboto(
                      textStyle:
                          TextStyle(fontSize: h * 0.02, color: Colors.white)),
                )),
              )
            ],
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: w * 0.03,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    b2b = false;
                    b2c = true;
                  });
                },
                child: Container(
                  height: h * 0.050,
                  width: w * 0.45,
                  decoration: BoxDecoration(
                    color: b2c == true ? Colors.deepPurple : Colors.green,
                    border: Border.all(color: primaryColor),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "B2C Orders",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    b2c = false;
                    b2b = true;
                  });
                },
                child: Container(
                    height: h * 0.050,
                    width: w * 0.45,
                    decoration: BoxDecoration(
                        color: b2b == true ? Colors.deepPurple : Colors.green,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                        )),
                    child: Center(
                        child: Text(
                      "B2B Orders",
                      style: TextStyle(color: Colors.white),
                    ))),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
              flex: 0,
              child: b2c == true || b2b == true
                  ? GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 140,
                              mainAxisExtent: 45,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                      itemCount: overview.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex1 = index;
                            });
                            onItemTapped(index);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: _selectedIndex1 == index
                                    ? primaryColor
                                    : Colors.white,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.01,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: w * 0.01),
                                        child: Text(
                                          overview[index]["text"],
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color:
                                                      _selectedIndex1 == index
                                                          ? Colors.white
                                                          : Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: h * 0.015)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : SizedBox()),
          ListView.builder(
              shrinkWrap: true,
              itemCount:2,
              itemBuilder: (buildContext,int index){
                // Map shippingAddress=data[index]['shippingAddress'];
                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                  child: InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>QuotationDetails(
                      //   id: data[index].id,
                      // )));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 1,
                            color: Color(0x28000000),
                            offset: Offset(0, 1),
                          )
                        ],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Color(0xFFDBE2E7),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(4, 10, 4, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Invoice NO: TCE-233',
                                                // + data[index].id,
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text('Requested Date: 19-02-2023 02:36',
                                            // data[index]['placedDate'].toDate().toString().substring(0,16),
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 12, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('OrderId :10005544',
                                            // shippingAddress['name'],
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,

                                            ),
                                          ),
                                          Text('cash of delivery',
                                            // shippingAddress['name'],
                                            style: TextStyle(
                                              fontFamily: 'Lexend Deca',
                                              color: primaryColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,

                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          12, 0, 12, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0, 4, 0, 0),
                                            child: Text(
                                                'Name',
                                                    // '${data[index]['shippingMethod']}',
                                                style:GoogleFonts.poppins(

                                                    fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black
                                                )
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                0, 4, 0, 0),
                                            child: Text(
                                                '₹ 9865.654',
                                                    // '${data[index]['shippingMethod']}',
                                                style:GoogleFonts.poppins(

                                                    fontSize: 12,fontWeight: FontWeight.bold,color: Colors.green
                                                )
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: EdgeInsetsDirectional.fromSTEB(
                                          //       0, 4, 0, 0),
                                          //   child: Text(
                                          //       '\₹${data[index]['price'].toStringAsFixed(2)}',
                                          //       style:GoogleFonts.poppins(
                                          //
                                          //           fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black
                                          //       )
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              })
        ]),
      ),
    );
  }
}

// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(children: [
// SizedBox(
// height: h * 0.03,
// ),
// Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "B2C Orders",
// style: TextStyle(
// color: primaryColor,
// fontSize: h * 0.015,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// SizedBox(
// height: h * 0.0020,
// width: w * 0.36,
// child: DecoratedBox(
// decoration: BoxDecoration(color: primaryColor)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Column(
// children: [
// // Container(
// //     height: h * 0.050,
// //     width: w * 0.320,
// //     child: CustomDropdown(
// //       fieldSuffixIcon: Icon(
// //         Icons.arrow_drop_down_outlined,
// //         color: Colors.white,
// //         size: h * 0.035,
// //       ),
// //       listItemStyle: TextStyle(fontSize: w * 0.025),
// //       selectedStyle:
// //           TextStyle(fontSize: w * 0.025, color: Colors.white),
// //       fillColor: primaryColor,
// //       hintStyle: TextStyle(fontSize: 6, color: Colors.white),
// //       items: items,
// //       controller: hi,
// //     )),
// ],
// ),
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// Container(
// height: h * 0.050,
// width: w * 0.350,
// decoration: BoxDecoration(
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(15),
// bottomLeft: Radius.circular(15)),
// ),
// child: Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Icon(
// Icons.calendar_today,
// color: primaryColor,
// ),
// ],
// ),
// ),
// Container(
// height: h * 0.050,
// width: w * 0.350,
// decoration: BoxDecoration(
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(15),
// bottomRight: Radius.circular(15))),
// child: Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Icon(
// Icons.calendar_today,
// color: primaryColor,
// ),
// ],
// ),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Container(
// height: h * 0.050,
// width: w * 0.200,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(15),
// color: primaryColor),
// child: Center(
// child: Text(
// "Go",
// style: GoogleFonts.roboto(
// textStyle:
// TextStyle(fontSize: h * 0.02, color: Colors.white)),
// )),
// )
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// SizedBox(
// width: w * 0.03,
// ),
// InkWell(
// onTap: () {
// setState(() {
// b2b = false;
// b2c = true;
// });
// },
// child: Container(
// height: h * 0.050,
// width: w * 0.45,
// decoration: BoxDecoration(
// color: b2c == true ? Colors.deepPurple : Colors.green,
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(15),
// ),
// ),
// child: Center(
// child: Text(
// "B2C Orders",
// style: TextStyle(color: Colors.white),
// ),
// ),
// ),
// ),
// InkWell(
// onTap: () {
// setState(() {
// b2c = false;
// b2b = true;
// });
// },
// child: Container(
// height: h * 0.050,
// width: w * 0.45,
// decoration: BoxDecoration(
// color: b2b == true ? Colors.deepPurple : Colors.green,
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(15),
// )),
// child: Center(
// child: Text(
// "B2B Orders",
// style: TextStyle(color: Colors.white),
// ))),
// ),
// ],
// ),
// SizedBox(
// height: 16,
// ),
// Expanded(
// flex: 0,
// child: b2c == true || b2b == true
// ? GridView.builder(
// shrinkWrap: true,
// physics: ScrollPhysics(),
// gridDelegate:
// const SliverGridDelegateWithMaxCrossAxisExtent(
// maxCrossAxisExtent: 140,
// mainAxisExtent: 45,
// childAspectRatio: 3 / 2,
// crossAxisSpacing: 10,
// mainAxisSpacing: 20),
// itemCount: overview.length,
// itemBuilder: (BuildContext ctx, index) {
// return InkWell(
// onTap: () {
// setState(() {
// _selectedIndex1=index;
// });
// onItemTapped(index);
// },
// child: Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// color: _selectedIndex1 == index ? primaryColor : Colors.white,
//
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.circular(5)),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// children: [
// SizedBox(
// height: h * 0.01,
// ),
// Padding(
// padding:
// EdgeInsets.only(left: w * 0.01),
// child: Text(
// overview[index]["text"],
// style: GoogleFonts.roboto(
// textStyle: TextStyle( color: _selectedIndex1==index? Colors.white:Colors.black,
// fontWeight: FontWeight.bold,
// fontSize: h*0.015)),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// );
// })
// : SizedBox()),
// ]),
// ),
