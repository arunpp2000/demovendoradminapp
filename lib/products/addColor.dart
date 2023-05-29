import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../globals/colors.dart';
import '../model/productModel.dart';
import 'media.dart';

class ProductColor extends StatefulWidget {
  const ProductColor({Key? key}) : super(key: key);

  @override
  State<ProductColor> createState() => _ProductColorState();
}

class _ProductColorState extends State<ProductColor> {
  List<String> EditValue1 = [
    "B2C Product",
    "B2B Product",
    "Ascending",
    "Descending",
    "Active List",
    "Inactive list",
  ];
  List Addcolorslist = [
    {"colorName": "white", "ColorCode": "66BD46"}
  ];
  TextEditingController colorName = TextEditingController();
  TextEditingController colorCode = TextEditingController();
  TextEditingController EditValue = TextEditingController();
  bool PColor = false;
  bool Editvaluecolour = false;
  bool AddColor = false;
  bool Addcolourcontainer = false;
  bool Sellectallcolor = false;
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
                child: Column(children: [
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
                      Container(
                        height: h * 0.04,
                        width: w * 0.250,
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
                      )
                    ],
                  ),
                  SizedBox(
                    height: h * 0.01,
                  ),
                  Divider(
                    thickness: h * 0.002,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Checkbox(
                          activeColor: primaryColor,
                          value: Sellectallcolor,
                          onChanged: (bool? value) {
                            setState(() {
                              Sellectallcolor = value!;
                            });
                          }),
                      Text(
                        "Sellect All",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: w * 0.025)),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Addcolourcontainer = true;
                          });
                        },
                        child: Container(
                          height: h * 0.04,
                          width: w * 0.300,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(w * 0.02)),
                          child: Center(
                              child: Text(
                                "Add Colors",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.025)),
                              )),
                        ),
                      ),
                      Container(
                        height: h * 0.04,
                        width: w * 0.250,
                        decoration: BoxDecoration(
                            color: Color(0xffFF0000),
                            borderRadius: BorderRadius.circular(w * 0.02)),
                        child: Center(
                            child: Text(
                              "Delete",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: w * 0.025)),
                            )),
                      )
                    ],
                  ),
                  Divider(
                    thickness: h * 0.002,
                  ),
                  Stack(children: [
                    Container(
                      height: h * 0.555,
                      width: w,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(w * 0.02),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: w * 0.005)
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: h * 0.02, left: w * 0.02, right: w * 0.02),
                        child: Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Colors",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.025)),
                              ),
                              Text(
                                "Options",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: w * 0.025)),
                              )
                            ],
                          ),
                          // Divider(thickness: h*0.002,),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("products")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                var product = snapshot.data!.docs;
                                return product.isEmpty
                                    ? CircularProgressIndicator() :
                                ListView.builder(
                                    itemCount: Addcolorslist.length,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        children: [
                                          Divider(
                                            thickness: h * 0.002,
                                          ),
                                          ListTile(
                                            leading: Checkbox(
                                              value: PColor,
                                              onChanged: (bool? value) {},
                                            ),
                                            title: Text(
                                              product[index]["productColor"]["colorName"]??'',
                                              style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: w * 0.025)),
                                            ),
                                            subtitle: Text(
                                              "Color Code:${product[index]["productColor"]["colorCode"]}",
                                              style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: w * 0.025)),
                                            ),
                                            trailing: InkWell(
                                              onTap: () {
                                                setState(() {
                                                  Editvaluecolour = true;
                                                });
                                              },
                                              child: Container(
                                                height: h * 0.04,
                                                width: w * 0.25,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border:
                                                    Border.all(color: primaryColor),
                                                    borderRadius:
                                                    BorderRadius.circular(w * 0.01)),
                                                child: Center(
                                                    child: Text("Edit Values",
                                                        style: GoogleFonts.roboto(
                                                            textStyle: TextStyle(
                                                                fontSize: w * 0.030,
                                                                color: primaryColor,
                                                                fontWeight:
                                                                FontWeight.bold)))),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });

                              }
                          ),
                        ]),
                      ),
                    ),
                    Addcolourcontainer == true
                        ? Positioned(
                      bottom: 0,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                        child: Container(
                          height: h * 0.35,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, blurRadius: w * 0.01)
                              ],
                              borderRadius: BorderRadius.circular(w * 0.02)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * 0.07,
                                width: w,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: w * 0.01)
                                    ],
                                    gradient: gradient,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(w * 0.02),
                                        topLeft: Radius.circular(w * 0.02))),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Add Color",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.030,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold))),
                                      InkWell(
                                          onTap: () {
                                            Addcolourcontainer=false;
                                            setState(() {

                                            });
                                          },
                                          child: SvgPicture.asset(
                                            "assets/Close.svg",
                                            height: h * 0.03,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(w * 0.04),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Color Name",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextFormField(
                                      controller: colorName,
                                      decoration: InputDecoration(
                                        hintText: "Enter Color Name",
                                        hintStyle: TextStyle(
                                            color: const Color(0xffB3B3B3),
                                            fontSize: h * 0.015),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Text(
                                      "Color Code",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextFormField(
                                      controller: colorCode,
                                      decoration: InputDecoration(
                                        hintText:
                                        "Enter Color Code eg:#66BD46",
                                        hintStyle: TextStyle(
                                            color: const Color(0xffB3B3B3),
                                            fontSize: h * 0.015),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    InkWell(onTap: (){
                                      var updateColor = Product!.copyWith(productcolor: {
                                        "colorName":colorName.text,
                                        "colorCode":colorCode.text,
                                        "status":0
                                      });
                                      FirebaseFirestore.instance
                                          .collection("products")
                                          .doc(productId)
                                          .update(updateColor.toJson())
                                          .then((value) {
                                        Addcolourcontainer=false;
                                        setState(() {

                                        });
                                      });

                                    },

                                      child: Container(
                                        height: h * 0.04,
                                        width: w,
                                        decoration: BoxDecoration(
                                            gradient: gradient,
                                            borderRadius: BorderRadius.circular(
                                                w * 0.02)),
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.030,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                        : Container(),
                    Editvaluecolour == true
                        ? Positioned(
                      bottom: 0,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                        child: Container(
                          height: h * 0.35,
                          width: w * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, blurRadius: w * 0.01)
                              ],
                              borderRadius: BorderRadius.circular(w * 0.02)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: h * 0.07,
                                width: w,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          blurRadius: w * 0.01)
                                    ],
                                    gradient: gradient,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(w * 0.02),
                                        topLeft: Radius.circular(w * 0.02))),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Edit Values",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.030,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold))),
                                      InkWell(
                                          onTap: () {
                                            Editvaluecolour=false;
                                            setState(() {

                                            });
                                          },
                                          child: SvgPicture.asset(
                                            "assets/Close.svg",
                                            height: h * 0.03,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(w * 0.04),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Color Name",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextFormField(
                                      controller: colorName,
                                      decoration: InputDecoration(
                                        hintText: "Enter Color Name",
                                        hintStyle: TextStyle(
                                            color: const Color(0xffB3B3B3),
                                            fontSize: h * 0.015),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Text(
                                      "Color Code",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextFormField(
                                      controller: colorCode,
                                      decoration: InputDecoration(
                                        hintText:
                                        "Enter Color Code eg:#66BD46",
                                        hintStyle: TextStyle(
                                            color: const Color(0xffB3B3B3),
                                            fontSize: h * 0.015),
                                        enabledBorder:
                                        const UnderlineInputBorder(
                                          //<-- SEE HERE
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    InkWell(onTap: (){
                                      var updateColor = Product!.copyWith(productcolor: {
                                        "colorName":colorName.text,
                                        "colorCode":colorCode.text,
                                        "status":0
                                      });
                                      FirebaseFirestore.instance
                                          .collection("products")
                                          .doc(productId)
                                          .update(updateColor.toJson())
                                          .then((value) {
                                        Addcolourcontainer=false;
                                        setState(() {

                                        });
                                      });

                                    },

                                      child: Container(
                                        height: h * 0.04,
                                        width: w,
                                        decoration: BoxDecoration(
                                            gradient: gradient,
                                            borderRadius: BorderRadius.circular(
                                                w * 0.02)),
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    fontSize: w * 0.030,
                                                    color: Colors.white,
                                                    fontWeight:
                                                    FontWeight.bold)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    )
                        : Container(),
                  ]),
                ]),
              )),
          Container(
            height: h * 0.05,
            width: w * 2,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(w * 0.03),
                    topRight: Radius.circular(w * 0.02))),
          ),
        ]));
  }
}