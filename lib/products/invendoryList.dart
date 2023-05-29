import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../globals/colors.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  bool sellectinventory=false;
  bool variablrpro = false;
  List Inventorylist=[{
    "text": "10,12,1555"
  }];
  bool selectall=false;
  TextEditingController inventorySortby = TextEditingController();
  List<String> inventorySortby1 = [
    "B2C Product",
    "B2B Product",
    "Ascending",
    "Descending",
    "Active List",
    "Inactive list",
  ];
  bool Activate=false;
  bool Deactivate=false;
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
                  height: h * 0.005,
                ),
                Divider(
                  thickness: h * 0.001,
                ),
                SizedBox(
                  height: h * 0.005,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activate",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: w * 0.025,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: w*0.01,),
                    FlutterSwitch(
                      activeColor:
                      const Color(0xff66BD46),
                      width: w * 0.1,
                      height: h * 0.030,
                      valueFontSize: 0.0,
                      toggleSize: 15.0,
                      value: Activate,
                      borderRadius: 30.0,
                      padding: 8.0,
                      onToggle: (val) {
                        setState(() {
                          Activate = val;
                        });
                      },
                    ),
                    SizedBox(width: w*0.124,),
                    Text(
                      "Deactivate",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: primaryColor,
                              fontSize: w * 0.025,
                              fontWeight: FontWeight.bold)),
                    ),
                    SizedBox(width: w*0.01,),
                    FlutterSwitch(
                      activeColor:
                      const Color(0xff66BD46),
                      width: w * 0.1,
                      height: h * 0.030,
                      valueFontSize: 0.0,
                      toggleSize: 15.0,
                      value:Deactivate,
                      borderRadius: 30.0,
                      padding: 8.0,
                      onToggle: (val) {
                        setState(() {
                          Deactivate = val;
                        });
                      },
                    ),
                    SizedBox(width: w*0.130,),
                    Container(
                      height: h * 0.04,
                      width: w * 0.200,
                      decoration: BoxDecoration(
                        color: Color(0xffFF0000),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          "Delete",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: w * 0.03,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: h*0.01,),
                Divider(thickness: h*0.0015,),
                SizedBox(height: h*0.01,),
                Container(
                  // height: h * 0.04,
                    width: w ,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Colors.grey,
                          blurRadius: w*0.01

                      )],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:   Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Checkbox(
                                activeColor: primaryColor,
                                value: selectall,
                                onChanged: (bool? value) {
                                  setState(() {
                                    selectall=value!;
                                  });

                                },
                              ),
                              Text("Sellect All", style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: w * 0.02,
                                      fontWeight: FontWeight.bold)),),
                              SizedBox(width: w*0.02,),
                              Container(height: h*0.04,
                                  width: w*0.320,
                                  decoration: BoxDecoration(color: primaryColor,
                                      borderRadius: BorderRadius.circular(w*0.02)),
                                  child:
                                  Center(
                                    child: Text(
                                      "Pending Approval(1)",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: w * 0.02,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  )),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Container(
                                height: h * 0.04,
                                width: w * 0.320,
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
                                      fontSize: w * 0.020, color: primaryColor,
                                      fontWeight: FontWeight.bold),
                                  items: inventorySortby1,
                                  controller: inventorySortby,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h * 1,
                            width: double.maxFinite,
                            child: Expanded(
                              flex: 0,
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                itemCount: Inventorylist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: h * 0.26,
                                    width: w * 0.9,
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
                                              Checkbox(
                                                  activeColor:primaryColor,
                                                  value: sellectinventory, onChanged: (bool?value){
                                                setState(() {
                                                  sellectinventory=value!;
                                                });
                                              }),
                                              Container(
                                                height: h * 0.1,
                                                width: w * 0.250,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey.shade300,
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
                                                        "Request Date :",
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
                                                      Text(
                                                        Inventorylist[index]![
                                                        "text"],
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
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Text(
                                                    "Pisang 8MM Bold Green Cardamom\n(Elaichi) Pisang 8MM Bold Green\nCardamom (Elaichi),Bold Green Cardamom :",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: Colors.black,
                                                            fontSize:
                                                            w * 0.018)),
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text("Selling Price:",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  color: Color(
                                                                      0xff298E03),
                                                                  fontSize: w *
                                                                      0.025))),
                                                      SizedBox(
                                                        width: w * 0.230,
                                                      ),
                                                      Text("Stock:",
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
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              SizedBox(width: w*0.110,),
                                              Text("Variable Product",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: w * 0.025,
                                                          fontWeight: FontWeight
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
                                                width: w * 0.020,
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
                                                width: w * 0.039,
                                              ),
                                              //
                                              Container(height: h*0.04,
                                                width: w*0.25,
                                                decoration: BoxDecoration(color: Colors.white,
                                                    border: Border.all(color: primaryColor),
                                                    borderRadius: BorderRadius.circular(w*0.02)),
                                                child: Center(child: Text("Edit", style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        fontSize: w * 0.030,
                                                        color: primaryColor,
                                                        fontWeight:
                                                        FontWeight.bold)))),)
                                            ],
                                          ),

                                          SizedBox(
                                            height: h * 0.01,
                                          ),

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        ]


                    )
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: h*0.05,),
        Container(height: h*0.05,
          width: w*2,
          decoration: BoxDecoration(gradient: gradient,borderRadius: BorderRadius.only(topLeft: Radius.circular(w*0.03),topRight: Radius.circular(w*0.02))),
        )



      ]
      ),

    );
  }
}