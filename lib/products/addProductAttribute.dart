import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals/colors.dart';


class ProductAttributes extends StatefulWidget {
  const ProductAttributes({Key? key}) : super(key: key);

  @override
  State<ProductAttributes> createState() => _ProductAttributesState();
}

class _ProductAttributesState extends State<ProductAttributes> {
  List<String> EditValue1 = [
    "B2C Product",
    "B2B Product",
    "Ascending",
    "Descending",
    "Active List",
    "Inactive list",
  ];
  int _selectedIndex1 = -1;
  int _selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextEditingController attributeName = TextEditingController();
  TextEditingController EditValue = TextEditingController();
  bool ProductAttributes = false;
  bool Editvalue = false;
  bool Attributesdetailes = false;
  bool Addattributes = false;
  List PAttributes = [
    {"quantity": "Litre", "value": "1L"},
    {"quantity": "Litre", "value": "1L"}
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
                          value: ProductAttributes,
                          onChanged: (bool? value) {
                            setState(() {
                              ProductAttributes = value!;
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
                            Addattributes = true;
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
                                "Add Attributes",
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
                                "Attribute Details",
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
                          ListView.builder(
                              itemCount: PAttributes.length,
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
                                        value: Attributesdetailes,
                                        onChanged: (bool? value) {},
                                      ),
                                      title: Text(
                                        PAttributes[index]["quantity"],
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: w * 0.025)),
                                      ),
                                      subtitle: Text(
                                        "Values:${PAttributes[index]?["value"]}",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: w * 0.025)),
                                      ),
                                      trailing: InkWell(
                                        onTap: () {
                                          setState(() {
                                            Editvalue = true;
                                            _selectedIndex1 = index;
                                          });
                                          onItemTapped(index);
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
                              }),
                        ]),
                      ),
                    ),
                    Addattributes == true
                        ? Positioned(
                      bottom: 0,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                        child: Container(
                          height: h * 0.27,
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
                                      Text("Add Attributes",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.030,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold))),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              Addattributes = false;
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
                                      "Attribute Name",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    TextFormField(
                                      controller: attributeName,
                                      decoration: InputDecoration(
                                        hintText:
                                        "Type Attribute Name eg: Litre",
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
                                    InkWell(
                                      onTap: () {

                                      },
                                      child: Container(
                                        height: h * 0.04,
                                        width: w,
                                        decoration: BoxDecoration(
                                            gradient: gradient,
                                            borderRadius:
                                            BorderRadius.circular(
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
                    Editvalue == true
                        ? Positioned(
                      bottom: 0,
                      child: Padding(
                        padding:
                        EdgeInsets.only(left: w * 0.03, bottom: h * 0.01),
                        child: Container(
                          height: h * 0.45,
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
                                            setState(() {
                                              Editvalue = false;
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
                                      "Attribute Name",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: w * 0.030,
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    CustomDropdown(
                                      hintText: "Litre",
                                      // borderSide: BorderSide(color: primaryColor),
                                      // borderRadius: BorderRadius.circular(h * 0.01),
                                      fieldSuffixIcon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: primaryColor,
                                        size: h * 0.035,
                                      ),
                                      listItemStyle:
                                      TextStyle(fontSize: w * 0.025),
                                      selectedStyle: TextStyle(
                                          fontSize: w * 0.018,
                                          color: Colors.black),
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          fontSize: w * 0.020,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      items: EditValue1,
                                      controller: EditValue,
                                    ),
                                    SizedBox(
                                      height: h * 0.01,
                                    ),
                                    Text("Attributes Values",
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontSize: w * 0.030,
                                                color: primaryColor,
                                                fontWeight:
                                                FontWeight.bold))),
                                    TextFormField(
                                      controller: attributeName,
                                      decoration: InputDecoration(
                                        // hintText:
                                        // "Type Attribute Name eg: Litre",
                                        // hintStyle: TextStyle(
                                        //     color: const Color(0xffB3B3B3),
                                        //     fontSize: h * 0.015),
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
                                    Container(
                                      height: h * 0.04,
                                      width: w * 0.250,
                                      decoration: BoxDecoration(
                                          gradient: gradient,
                                          borderRadius: BorderRadius.circular(
                                              w * 0.02)),
                                      child: Center(
                                        child: Text(
                                          "Add Values",
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  fontSize: w * 0.030,
                                                  color: Colors.white,
                                                  fontWeight:
                                                  FontWeight.bold)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: h * 0.02,
                                    ),
                                    Container(
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