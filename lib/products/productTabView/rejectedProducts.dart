import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../../model/addProductModel.dart';
import '../../model/usermodel.dart';
import '../pendingApprovalView.dart';


AddProductModel?penProduct;

class RejectedProducts extends StatefulWidget {
  RejectedProducts({Key? key}) : super(key: key);

  String? user;

  @override
  State<RejectedProducts> createState() => _RejectedProductsState();
}

class _RejectedProductsState extends State<RejectedProducts> {
  Stream<List<AddProductModel>> getProduct() =>
      FirebaseFirestore.instance
          .collection("products")
          .where('status', isEqualTo: 2)
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());



  Stream<List<AddProductModel>> getSearchProduct() => FirebaseFirestore.instance
      .collection('products').where("status",isEqualTo: 2)
      .where("search",arrayContains:searchProduct.text.toUpperCase())
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());


  TextEditingController Sortby = TextEditingController();
  TextEditingController searchProduct = TextEditingController();
  bool variablrpro = false;
  List<String> Sortby1 = [
    "Approved",
    "Not Approved",
    "Ascending",
    "Descending"
  ];
  int index = 0;
  List sort = [];


  @override
  void initState() {
    Sortby = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
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
                      child: TextFormField(
                        onFieldSubmitted: (value){
                          setState(() {

                          });
                        },
                        controller:searchProduct ,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Seller",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: primaryColor,
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: h * 0.0015,
                        width: w * 0.03,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color:Colors.black),
                        ),
                      ),

                      Text(
                        currentUser?.Fullname ?? "",
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
                        width: w * 0.2,
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
                          width: w * 0.2,
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
                  Container(
                    height: h*0.63,
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
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: h * 0.04,
                                  width: w * 0.280,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Center(
                                    child: Text(
                                      "Rejected products",
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
                              // Container(
                              //   height: h * 0.04,
                              //   width: w * 0.300,
                              //   child: CustomDropdown(
                              //     onChanged: (index) {
                              //
                              //       setState(() {
                              //         index.isEmpty
                              //             ? FirebaseFirestore.instance
                              //             .collection("products")
                              //             .where('vendorId',
                              //             isEqualTo: currentUser?.id)
                              //             .snapshots().map((snapshot) =>
                              //             snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                              //             : index == 'Approved'
                              //             ? FirebaseFirestore.instance
                              //             .collection("products")
                              //             .where('vendorId',
                              //             isEqualTo: currentUser?.id)
                              //             .where('status', isEqualTo: 1)
                              //             .snapshots().map((snapshot) =>
                              //             snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                              //             : index=='Not Approved'
                              //             ? FirebaseFirestore.instance
                              //             .collection("products")
                              //             .where('vendorId',
                              //             isEqualTo: currentUser?.id)
                              //             .where('status', isEqualTo: 0)
                              //             .snapshots().map((snapshot) =>
                              //             snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                              //             : index == 'Descending'
                              //             ? FirebaseFirestore.instance
                              //             .collection("products")
                              //             .where('vendorId',
                              //             isEqualTo:
                              //             currentUser?.id)
                              //             .orderBy('date',
                              //             descending: true)
                              //             .snapshots().map((snapshot) =>
                              //             snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                              //             : FirebaseFirestore.instance
                              //             .collection("products")
                              //             .where('vendorId',
                              //             isEqualTo:
                              //             currentUser?.id)
                              //             .snapshots()
                              //             .map((snapshot) =>
                              //             snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());
                              //       });
                              //     },
                              //     hintText: "Sort by",
                              //     borderSide: BorderSide(color: primaryColor),
                              //     borderRadius: BorderRadius.circular(5),
                              //     fieldSuffixIcon: Icon(
                              //       Icons.arrow_drop_down_outlined,
                              //       color: primaryColor,
                              //       size: h * 0.035,
                              //     ),
                              //     listItemStyle: TextStyle(fontSize: w * 0.025),
                              //     selectedStyle: TextStyle(
                              //         fontSize: w * 0.018, color: Colors.black),
                              //     fillColor: Colors.white,
                              //     hintStyle: TextStyle(
                              //         fontSize: w * 0.020, color: primaryColor),
                              //     items: Sortby1,
                              //     controller: Sortby,
                              //   ),
                              // ),
                            ],
                          ),
                          Expanded(
                            child: StreamBuilder<List<AddProductModel>>(
                                stream:searchProduct.text.isEmpty? getProduct():getSearchProduct() ,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  var pendingProduct = snapshot.data;
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: pendingProduct?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DateTime requestedDate = pendingProduct![index].date!;
                                      String date = DateFormat('dd/MM/yyy').format(requestedDate);
                                      DateTime acceptedDate = pendingProduct[index].acceptedDate!;
                                      String acceptedDate1 = DateFormat('dd/MM/yyy').format(acceptedDate);


                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      pendingApprovalView(
                                                        productData:pendingProduct[index],
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Divider(
                                              thickness: h * 0.001,
                                            ),
                                            SizedBox(
                                              height: h * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                pendingProduct[index].imageId! .isNotEmpty
                                                    ? Container(
                                                  height: h * 0.1,
                                                  width: w * 0.250,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              pendingProduct[index].imageId![0]),
                                                          fit: BoxFit
                                                              .fill),
                                                      color: Colors.grey
                                                          .shade300,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(w *
                                                          0.02)),
                                                )
                                                    : Container(
                                                  height: h * 0.1,
                                                  width: w * 0.250,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              'https://logowik.com/content/uploads/images/flutter5786.jpg'),
                                                          fit: BoxFit
                                                              .fill),
                                                      color: Colors.grey
                                                          .shade300,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(w *
                                                          0.02)),
                                                ),
                                                SizedBox(
                                                  width: w * 0.015,
                                                ),
                                                Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "Request Date :",
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: w *
                                                                          0.030,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                            Text(
                                                              date,
                                                              style: GoogleFonts.roboto(
                                                                  textStyle: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: w *
                                                                          0.030,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: h * 0.0015,
                                                          width: w * 0.35,
                                                          child: DecoratedBox(
                                                            decoration: BoxDecoration(color: Color(0xffB3B3B3)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.01,
                                                    ),
                                                    Container(
                                                      width: w*0.500,
                                                      child: Text(
                                                        pendingProduct[index].name!,
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                color: Color(0xff1E3354),
                                                                fontSize: h*0.015,fontWeight: FontWeight.bold
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: h * 0.01,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.end,                                                            children: [
                                                      // pendingProduct[index].status==
                                                      //     1
                                                      //     ? Row(
                                                      //   children: [
                                                      //     Text(
                                                      //         "Selling Price:",
                                                      //         style: GoogleFonts.roboto(
                                                      //             textStyle:
                                                      //             TextStyle(color: Color(0xff298E03), fontSize: w * 0.025))),
                                                      //     pendingProduct[index].b2b==true?
                                                      //     Text(
                                                      //    "₹${ pendingProduct[index].b2bP}"
                                                      //             .toString(),
                                                      //         style: GoogleFonts.roboto(
                                                      //             textStyle:
                                                      //             TextStyle(color: Color(0xff298E03), fontSize: w * 0.010))):
                                                      //     Text(
                                                      //         "₹${pendingProduct[index].b2cP}         "
                                                      //             .toString(),
                                                      //         style: GoogleFonts.roboto(
                                                      //             textStyle:
                                                      //             TextStyle(color: Color(0xff298E03), fontSize: w * 0.025)))
                                                      //   ],
                                                      // )
                                                      //     : Text(''),
                                                      // // SizedBox(
                                                      // //   width: w * 0.05,
                                                      // // ),
                                                      Text('Stock : ',
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xff298E03),
                                                                  fontSize:
                                                                  w * 0.025))),
                                                      Text(
                                                          pendingProduct[index].stock

                                                              .toString(),
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xff298E03),
                                                                  fontSize:
                                                                  w * 0.025)))
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
                                                // Text("Variable Product",
                                                //     style: GoogleFonts.roboto(
                                                //         textStyle: TextStyle(
                                                //             color:
                                                //             Colors.black,
                                                //             fontSize:
                                                //             w * 0.025,
                                                //             fontWeight:
                                                //             FontWeight
                                                //                 .bold))),
                                                SizedBox(
                                                  width: w * 0.03,
                                                ),
                                                Row(
                                                  children: [
                                                    FlutterSwitch(
                                                      activeColor: pendingProduct[index].available
                                                          ==false
                                                          ? Color(0xff66BD46)
                                                          : Colors.green,
                                                      width: w * 0.1,
                                                      height: h * 0.030,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: pendingProduct[index].available!,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          // variablrpro = val;
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.02,
                                                    ),
                                                    Text(
                                                      pendingProduct[index].available ==
                                                          true
                                                          ? "Active"
                                                          : "Inactive",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                              fontSize: w * 0.025,
                                                              color: primaryColor,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold)),
                                                    ),
                                                  ],
                                                ),

                                                SizedBox(
                                                  width: w * 0.049,
                                                ),
                                                Container(
                                                  height: h * 0.04,
                                                  width: w * 0.265,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(5)),
                                                  child: Center(
                                                    child: Text(
                                                        "Rejected",
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
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                Text("Approved Date:",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            h * 0.015,
                                                            color:
                                                            Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold))),
                                                pendingProduct[index].status==
                                                    1?
                                                Text(
                                                    acceptedDate1,
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            fontSize:
                                                            h * 0.015,
                                                            color:
                                                            Colors.black,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold)))
                                                    :Container(),
                                              ],
                                            ),
                                          ],
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

                ]),
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
        ],
      ),
    );
  }
}
