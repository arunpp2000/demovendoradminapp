import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../globals/colors.dart';
import '../model/usermodel.dart';

class PendingApproval extends StatefulWidget {
  PendingApproval({Key? key}) : super(key: key);

  String? user;

  @override
  State<PendingApproval> createState() => _PendingApprovalState();
}

class _PendingApprovalState extends State<PendingApproval> {
  List products = [];
  TextEditingController Sortby = TextEditingController();
  bool variablrpro = false;

  List<String> Sortby1 = [
    "Approved",
    "Not Approved",
    "Ascending",
    "Descending"
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: ListView(children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: h * 0.04,
                    width: w,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          hintStyle:
                          TextStyle(fontSize: w * 0.030, color: Colors.black),
                          hintText: 'Search Product',
                          contentPadding: EdgeInsets.only(top: 1),
                          prefixIcon: Icon(
                            Icons.search,
                            color: primaryColor,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Seller",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold)),
                      ),
                      Text(
                        "-Thara Online Store",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        width: w * 0.01,
                      ),
                      SizedBox(
                        height: h * 0.0015,
                        width: w * 0.22,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffB3B3B3)),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.01,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: h * 0.04,
                          width: w * 0.258,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: primaryColor)),
                          child: Center(
                            child: Text(
                              "Manage",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: w * 0.03,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  SingleChildScrollView(
                    child: Container(
                      height: h * 1.2,
                      width: w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.grey,
                            blurRadius: w * 0.015,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    height: h * 0.04,
                                    width: w * 0.330,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                        BorderRadius.circular(w * 0.02)),
                                    child: Center(
                                      child: Text(
                                        "pending Approval(${products.length})",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: w * 0.02,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    )),
                                SizedBox(
                                  width: w * 0.2,
                                ),
                                Container(
                                  height: h * 0.04,
                                  width: w * 0.330,
                                  child: CustomDropdown(
                                    hintText: "Sort by",
                                    borderSide: BorderSide(color: primaryColor),
                                    borderRadius: BorderRadius.circular(h * 0.01),
                                    fieldSuffixIcon: Icon(
                                      Icons.arrow_drop_down_outlined,
                                      color: primaryColor,
                                      size: h * 0.035,
                                    ),
                                    listItemStyle: TextStyle(fontSize: w * 0.025),
                                    selectedStyle: TextStyle(
                                        fontSize: w * 0.018, color: Colors.black),
                                    fillColor: Colors.white,
                                    hintStyle: TextStyle(
                                        fontSize: w * 0.018, color: primaryColor),
                                    items: Sortby1,
                                    controller: Sortby,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 1,
                              width: double.maxFinite,
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("products")
                                      .where("status", isEqualTo: 0)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if(!snapshot.hasData){
                                      return CircularProgressIndicator();
                                    }
                                    products = snapshot.data!.docs;
                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      physics: ScrollPhysics(),
                                      itemCount: products.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Timestamp reqdate = products[index]["date"];
                                        var a = products[index];
                                        String date = DateFormat('dd-MM-yyyy')
                                            .format(reqdate.toDate());
                                        return Container(
                                          height: h * 0.26,
                                          width: w * 0.800,
                                          decoration:
                                          BoxDecoration(color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Divider(
                                                  thickness: h * 0.002,
                                                ),
                                                SizedBox(
                                                  height: h * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: h * 0.1,
                                                      width: w * 0.250,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                products[index]['imageId'][0]),
                                                              fit: BoxFit.fill),
                                                          color:
                                                          Colors.grey.shade300,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              w * 0.02)),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.015,
                                                    ),
                                                    Column(
                                                      // mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Request Date :${date}",
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                      w * 0.030,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                            // Text(
                                                            //   products[index],
                                                            //   style: GoogleFonts.roboto(
                                                            //       textStyle: TextStyle(
                                                            //           color: Colors
                                                            //               .black,
                                                            //           fontSize:
                                                            //               w * 0.030,
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .bold)),
                                                            // ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: h * 0.01,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                           a["name"],
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    color:
                                                                    Colors.black,
                                                                    fontSize:
                                                                    w * 0.040)),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: h * 0.01,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text("Selling Price : " ,
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: TextStyle(
                                                                        color: Color(
                                                                            0xff298E03),
                                                                        fontSize: w *
                                                                            0.025))),
                                                            SizedBox(
                                                              width: w * 0.230,
                                                            ),
                                                            Text("Stock:    ",
                                                                style: GoogleFonts.roboto(
                                                                    textStyle: TextStyle(
                                                                        color: Color(
                                                                            0xff298E03),
                                                                        fontSize: w *
                                                                            0.025)))
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.015,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Text("Variable Product",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: w * 0.025,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                    SizedBox(
                                                      width: w * 0.03,
                                                    ),
                                                    FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.1,
                                                      height: h * 0.030,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: variablrpro,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          variablrpro = val;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.02,
                                                    ),
                                                    Text(
                                                      variablrpro == true
                                                          ? "Active"
                                                          : "Inactive",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: primaryColor,
                                                              fontWeight:
                                                              FontWeight.bold)),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.049,
                                                    ),
                                                    Container(
                                                      height: h * 0.04,
                                                      width: w * 0.265,
                                                      decoration: BoxDecoration(
                                                          color: products[index]
                                                          ["status"] ==
                                                              1
                                                              ? Color(0xff298E03)
                                                              : primaryColor,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              w * 0.02)),
                                                      child: Center(
                                                        child: Text(
                                                            products[index][
                                                            "status"] ==
                                                                1
                                                                ? "Approved"
                                                                : "Not approved",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                    w * 0.025,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .bold))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.01,
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text("Approved Date:",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: Colors.black,
                                                              fontWeight: FontWeight
                                                                  .bold))),
                                                ),
                                                SizedBox(
                                                  height: h * 0.01,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Container(
            height: h * 0.05,
            width: w * 2,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(w * 0.03),
                    topRight: Radius.circular(w * 0.02))),
          )
        ]));
  }
}