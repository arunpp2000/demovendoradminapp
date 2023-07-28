// import 'package:animated_custom_dropdown/custom_dropdown.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import '../../../globals/colors.dart';
// import '../../../main.dart';
// import '../../../model/usermodel.dart';
//
// class ProductAttributes extends StatefulWidget {
//   const ProductAttributes({Key? key}) : super(key: key);
//
//   @override
//   State<ProductAttributes> createState() => _ProductAttributesState();
// }
//
// var attributeId;
// List attributes = [];
// Map checkmap = {};
// var atributename;
// List aValus = [];
//
// class _ProductAttributesState extends State<ProductAttributes> {
//   List<String> EditValue1 = [
//     "Kg",
//     "Litre",
//     "Gm",
//     "ml",
//   ];
//   int _selectedIndex1 = -1;
//   int _selectedIndex = 0;
//   void onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   TextEditingController attributeName = TextEditingController();
//   TextEditingController attributeValue = TextEditingController();
//   TextEditingController editValue = TextEditingController();
//   bool selectall = false;
//   bool check = false;
//   bool Editvalue = false;
//   bool Attributesdetailes = false;
//   bool Addattributes = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // body: ListView(shrinkWrap: true, children: [
//         //   Padding(
//         //     padding:
//         //     const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
//         //     child: StreamBuilder<QuerySnapshot>(
//         //         stream: db
//         //             .collection("vendor")
//         //             .doc(currentUser!.id)
//         //             .collection("attributes")
//         //             .snapshots(),
//         //         builder: (context, snapshot) {
//         //           if (!snapshot.hasData) {
//         //             return Center(
//         //               child: CircularProgressIndicator(),
//         //             );
//         //           }
//         //           attributes = snapshot.data!.docs;
//         //           return Column(children: [
//         //             Container(
//         //               height: h * 0.04,
//         //               width: w,
//         //               decoration: BoxDecoration(
//         //                   border: Border.all(color: primaryColor),
//         //                   color: Colors.white,
//         //                   borderRadius: BorderRadius.circular(5)),
//         //               child: Center(
//         //                 child: TextField(
//         //                   decoration: InputDecoration(
//         //                     hintStyle:
//         //                     TextStyle(fontSize: w * 0.030, color: Colors.black),
//         //                     hintText: 'Search Product',
//         //                     contentPadding: EdgeInsets.only(top: 1),
//         //                     prefixIcon: Icon(
//         //                       Icons.search,
//         //                       color: primaryColor,
//         //                     ),
//         //                     border: OutlineInputBorder(
//         //                       borderSide: BorderSide.none,
//         //                       borderRadius: BorderRadius.circular(10),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               ),
//         //             ),
//         //             SizedBox(
//         //               height: h * 0.02,
//         //             ),
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //               children: [
//         //                 Text(
//         //                   "Seller",
//         //                   style: GoogleFonts.roboto(
//         //                       textStyle: TextStyle(
//         //                           color: primaryColor1,
//         //                           fontSize: w * 0.03,
//         //                           fontWeight: FontWeight.bold)),
//         //                 ),
//         //                 Text(
//         //                   "-Thara Online Store",
//         //                   style: GoogleFonts.roboto(
//         //                       textStyle: TextStyle(
//         //                           color: Colors.black,
//         //                           fontSize: w * 0.03,
//         //                           fontWeight: FontWeight.bold)),
//         //                 ),
//         //                 SizedBox(
//         //                   width: w * 0.01,
//         //                 ),
//         //                 SizedBox(
//         //                   height: h * 0.0015,
//         //                   width: w * 0.22,
//         //                   child: DecoratedBox(
//         //                     decoration: BoxDecoration(color: Color(0xffB3B3B3)),
//         //                   ),
//         //                 ),
//         //                 SizedBox(
//         //                   width: w * 0.01,
//         //                 ),
//         //                 Container(
//         //                   height: h * 0.04,
//         //                   width: w * 0.250,
//         //                   decoration: BoxDecoration(
//         //                       color: Colors.white,
//         //                       borderRadius: BorderRadius.circular(5),
//         //                       border: Border.all(color: primaryColor)),
//         //                   child: Center(
//         //                     child: Text(
//         //                       "Manage",
//         //                       style: GoogleFonts.roboto(
//         //                           textStyle: TextStyle(
//         //                               color: primaryColor1,
//         //                               fontSize: w * 0.03,
//         //                               fontWeight: FontWeight.bold)),
//         //                     ),
//         //                   ),
//         //                 )
//         //               ],
//         //             ),
//         //             SizedBox(
//         //               height: h * 0.01,
//         //             ),
//         //             Divider(
//         //               thickness: h * 0.002,
//         //             ),
//         //             Row(
//         //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //               children: [
//         //                 Checkbox(
//         //                     activeColor: primaryColor,
//         //                     value: selectall,
//         //                     onChanged: (bool? valu) {
//         //                       if (selectall) {
//         //                         for (var a in attributes) {
//         //                           checkmap.remove(a["attributeId"]);
//         //                         }
//         //                       } else {
//         //                         for (var a in attributes) {
//         //                           checkmap[a["attributeId"]] = true;
//         //                         }
//         //                       }
//         //                       setState(() {
//         //                         selectall = valu!;
//         //                       });
//         //                     }),
//         //                 Text(
//         //                   "Sellect All",
//         //                   style: GoogleFonts.roboto(
//         //                       textStyle: TextStyle(
//         //                           fontWeight: FontWeight.bold,
//         //                           fontSize: w * 0.025)),
//         //                 ),
//         //                 InkWell(
//         //                   onTap: () {
//         //                     setState(() {
//         //                       Addattributes = true;
//         //                     });
//         //                   },
//         //                   child: Container(
//         //                     height: h * 0.04,
//         //                     width: w * 0.300,
//         //                     decoration: BoxDecoration(
//         //                         color: primaryColor,
//         //                         borderRadius: BorderRadius.circular(w * 0.02)),
//         //                     child: Center(
//         //                         child: Text(
//         //                           "Add Attributes",
//         //                           style: GoogleFonts.roboto(
//         //                               textStyle: TextStyle(
//         //                                   color: Colors.white,
//         //                                   fontWeight: FontWeight.bold,
//         //                                   fontSize: w * 0.025)),
//         //                         )),
//         //                   ),
//         //                 ),
//         //                 Container(
//         //                   height: h * 0.04,
//         //                   width: w * 0.250,
//         //                   decoration: BoxDecoration(
//         //                       color: Color(0xffFF0000),
//         //                       borderRadius: BorderRadius.circular(w * 0.02)),
//         //                   child: Center(
//         //                       child: Text(
//         //                         "Delete",
//         //                         style: GoogleFonts.roboto(
//         //                             textStyle: TextStyle(
//         //                                 color: Colors.white,
//         //                                 fontWeight: FontWeight.bold,
//         //                                 fontSize: w * 0.025)),
//         //                       )),
//         //                 )
//         //               ],
//         //             ),
//         //             Divider(
//         //               thickness: h * 0.002,
//         //             ),
//         //             Stack(children: [
//         //               Container(
//         //                 height: h * 0.555,
//         //                 width: w,
//         //                 decoration: BoxDecoration(
//         //                     color: Colors.white,
//         //                     borderRadius: BorderRadius.circular(w * 0.02),
//         //                     boxShadow: [
//         //                       BoxShadow(color: Colors.grey, blurRadius: w * 0.005)
//         //                     ]),
//         //                 child: SingleChildScrollView(
//         //                   child: Padding(
//         //                     padding: EdgeInsets.only(
//         //                         top: h * 0.02, left: w * 0.02, right: w * 0.02),
//         //                     child: Column(children: [
//         //                       Row(
//         //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         //                         children: [
//         //                           Text(
//         //                             "Attribute Details",
//         //                             style: GoogleFonts.roboto(
//         //                                 textStyle: TextStyle(
//         //                                     fontWeight: FontWeight.bold,
//         //                                     fontSize: w * 0.025)),
//         //                           ),
//         //                           Text(
//         //                             "Options",
//         //                             style: GoogleFonts.roboto(
//         //                                 textStyle: TextStyle(
//         //                                     fontWeight: FontWeight.bold,
//         //                                     fontSize: w * 0.025)),
//         //                           )
//         //                         ],
//         //                       ),
//         //                       // Divider(thickness: h*0.002,),
//         //                       StreamBuilder<QuerySnapshot>(
//         //                           stream: db
//         //                               .collection("vendor")
//         //                               .doc(currentUser!.id)
//         //                               .collection("attributes")
//         //                               .snapshots(),
//         //                           builder: (context, snapshot) {
//         //                             if (!snapshot.hasData) {
//         //                               return Center(
//         //                                 child: CircularProgressIndicator(),
//         //                               );
//         //                             } else if (snapshot.hasData &&
//         //                                 snapshot.data!.docs.isEmpty) {
//         //                               return Container(
//         //                                 height: 100,
//         //                                 width: w * 0.8,
//         //                                 color: Colors.indigo,
//         //                               );
//         //                             } else {
//         //                               attributes = snapshot.data!.docs;
//         //                               return ListView.builder(
//         //                                   itemCount: attributes.length,
//         //                                   shrinkWrap: true,
//         //                                   physics: ScrollPhysics(),
//         //                                   itemBuilder:
//         //                                       (BuildContext context, int index) {
//         //                                     return Column(
//         //                                       children: [
//         //                                         Divider(
//         //                                           thickness: h * 0.002,
//         //                                         ),
//         //                                         ListTile(
//         //                                           leading: Checkbox(
//         //                                             activeColor: primaryColor,
//         //                                             value: checkmap.containsKey(
//         //                                                 attributes[index]
//         //                                                 ["attributeId"]),
//         //                                             onChanged: (val) {
//         //                                               if (checkmap.containsKey(
//         //                                                   attributes[index]
//         //                                                   ["attributeId"])) {
//         //                                                 checkmap.remove(
//         //                                                     attributes[index]
//         //                                                     ["attributeId"]);
//         //                                               } else {
//         //                                                 checkmap[attributes[index]
//         //                                                 ['attributeId']] = true;
//         //                                               }
//         //
//         //                                               setState(() {});
//         //                                             },
//         //                                           ),
//         //                                           title: Text(
//         //                                             attributes[index]
//         //                                             ["attributeName"],
//         //                                             style: GoogleFonts.roboto(
//         //                                                 textStyle: TextStyle(
//         //                                                     fontWeight:
//         //                                                     FontWeight.w400,
//         //                                                     fontSize: w * 0.025)),
//         //                                           ),
//         //                                           subtitle: Text(
//         //                                             "Values:${attributes[index]["attributeValues"]}",
//         //                                             style: GoogleFonts.roboto(
//         //                                                 textStyle: TextStyle(
//         //                                                     color: Colors.black,
//         //                                                     fontWeight:
//         //                                                     FontWeight.bold,
//         //                                                     fontSize: w * 0.025)),
//         //                                           ),
//         //                                           trailing: InkWell(
//         //                                             onTap: () {
//         //                                               Editvalue = true;
//         //                                               atributename =
//         //                                               attributes[index]
//         //                                               ["attributeName"];
//         //                                               setState(() {
//         //                                                 _selectedIndex1 = index;
//         //                                               });
//         //                                               onItemTapped(index);
//         //
//         //                                               attributeId =
//         //                                               attributes[index]
//         //                                               ["attributeId"];
//         //
//         //                                               print("===================");
//         //                                               print(attributeId);
//         //                                               // id = color[index]['colorId'];
//         //                                             },
//         //                                             child: Container(
//         //                                               height: h * 0.04,
//         //                                               width: w * 0.25,
//         //                                               decoration: BoxDecoration(
//         //                                                   color: Colors.white,
//         //                                                   border: Border.all(
//         //                                                       color: primaryColor),
//         //                                                   borderRadius:
//         //                                                   BorderRadius.circular(
//         //                                                       w * 0.01)),
//         //                                               child: Center(
//         //                                                   child: Text("Edit Values",
//         //                                                       style: GoogleFonts.roboto(
//         //                                                           textStyle: TextStyle(
//         //                                                               fontSize:
//         //                                                               w * 0.030,
//         //                                                               color:
//         //                                                               primaryColor1,
//         //                                                               fontWeight:
//         //                                                               FontWeight
//         //                                                                   .bold)))),
//         //                                             ),
//         //                                           ),
//         //                                         ),
//         //                                       ],
//         //                                     );
//         //                                   });
//         //                             }
//         //                           }),
//         //                     ]),
//         //                   ),
//         //                 ),
//         //               ),
//         //               Addattributes == true
//         //                   ? Positioned(
//         //                 bottom: 0,
//         //                 child: Padding(
//         //                   padding: EdgeInsets.only(
//         //                       left: w * 0.03, bottom: h * 0.01),
//         //                   child: Container(
//         //                     height: h * 0.27,
//         //                     width: w * 0.9,
//         //                     decoration: BoxDecoration(
//         //                         color: Colors.white,
//         //                         boxShadow: [
//         //                           BoxShadow(
//         //                               color: Colors.grey,
//         //                               blurRadius: w * 0.01)
//         //                         ],
//         //                         borderRadius:
//         //                         BorderRadius.circular(w * 0.02)),
//         //                     child: Column(
//         //                       crossAxisAlignment: CrossAxisAlignment.start,
//         //                       children: [
//         //                         Container(
//         //                           height: h * 0.07,
//         //                           width: w,
//         //                           decoration: BoxDecoration(
//         //                               boxShadow: [
//         //                                 BoxShadow(
//         //                                     color: Colors.grey,
//         //                                     blurRadius: w * 0.01)
//         //                               ],
//         //                               gradient: gradient,
//         //                               borderRadius: BorderRadius.only(
//         //                                   topRight: Radius.circular(w * 0.02),
//         //                                   topLeft:
//         //                                   Radius.circular(w * 0.02))),
//         //                           child: Padding(
//         //                             padding: EdgeInsets.all(8.0),
//         //                             child: Row(
//         //                               mainAxisAlignment:
//         //                               MainAxisAlignment.spaceBetween,
//         //                               children: [
//         //                                 Text("Add Attributes",
//         //                                     style: GoogleFonts.roboto(
//         //                                         textStyle: TextStyle(
//         //                                             fontSize: w * 0.030,
//         //                                             color: Colors.white,
//         //                                             fontWeight:
//         //                                             FontWeight.bold))),
//         //                                 InkWell(
//         //                                     onTap: () {
//         //                                       setState(() {
//         //                                         Addattributes = false;
//         //                                       });
//         //                                     },
//         //                                     child: SvgPicture.asset(
//         //                                       "assets/Close.svg",
//         //                                       height: h * 0.03,
//         //                                     ))
//         //                               ],
//         //                             ),
//         //                           ),
//         //                         ),
//         //                         Padding(
//         //                           padding: EdgeInsets.all(w * 0.04),
//         //                           child: Column(
//         //                             crossAxisAlignment:
//         //                             CrossAxisAlignment.start,
//         //                             children: [
//         //                               Text(
//         //                                 "Attribute Name",
//         //                                 style: GoogleFonts.roboto(
//         //                                     textStyle: TextStyle(
//         //                                         fontSize: w * 0.030,
//         //                                         color: primaryColor,
//         //                                         fontWeight: FontWeight.bold)),
//         //                               ),
//         //                               TextFormField(
//         //                                 controller: attributeName,
//         //                                 decoration: InputDecoration(
//         //                                   hintText:
//         //                                   "Type Attribute Name eg: Litre",
//         //                                   hintStyle: TextStyle(
//         //                                       color: const Color(0xffB3B3B3),
//         //                                       fontSize: h * 0.015),
//         //                                   enabledBorder:
//         //                                   const UnderlineInputBorder(
//         //                                     //<-- SEE HERE
//         //                                     borderSide: BorderSide(
//         //                                         width: 1,
//         //                                         color: Colors.black54),
//         //                                   ),
//         //                                 ),
//         //                               ),
//         //                               SizedBox(
//         //                                 height: h * 0.02,
//         //                               ),
//         //                               InkWell(
//         //                                 onTap: () {
//         //                                   print(attributeName.text);
//         //                                   db
//         //                                       .collection('vendor')
//         //                                       .doc(currentUser!.id)
//         //                                       .collection("attributes")
//         //                                       .add({
//         //                                     "attributeValues": [],
//         //                                     "attributeName":
//         //                                     attributeName.text,
//         //                                     "status": 0,
//         //                                     "vendorId": currentUser!.id,
//         //                                   }).then((value) {
//         //                                     value.update(
//         //                                         {"attributeId": value.id});
//         //                                     print(currentUser!.id);
//         //                                     print("oooooooooooooo");
//         //                                     print(value.id);
//         //                                   }).then((value) {
//         //                                     Addattributes = false;
//         //
//         //                                     setState(() {});
//         //                                   });
//         //                                 },
//         //                                 child: Container(
//         //                                   height: h * 0.04,
//         //                                   width: w,
//         //                                   decoration: BoxDecoration(
//         //                                       gradient: gradient,
//         //                                       borderRadius:
//         //                                       BorderRadius.circular(
//         //                                           w * 0.02)),
//         //                                   child: Center(
//         //                                     child: Text(
//         //                                       "Save",
//         //                                       style: GoogleFonts.roboto(
//         //                                           textStyle: TextStyle(
//         //                                               fontSize: w * 0.030,
//         //                                               color: Colors.white,
//         //                                               fontWeight:
//         //                                               FontWeight.bold)),
//         //                                     ),
//         //                                   ),
//         //                                 ),
//         //                               ),
//         //                             ],
//         //                           ),
//         //                         )
//         //                       ],
//         //                     ),
//         //                   ),
//         //                 ),
//         //               )
//         //                   : Container(),
//         //               Editvalue == true
//         //                   ? Positioned(
//         //                 bottom: 0,
//         //                 child: Padding(
//         //                   padding: EdgeInsets.only(
//         //                       left: w * 0.03, bottom: h * 0.01),
//         //                   child: Container(
//         //                     height: h * 0.5,
//         //                     width: w * 0.9,
//         //                     decoration: BoxDecoration(
//         //                         color: Colors.white,
//         //                         boxShadow: [
//         //                           BoxShadow(
//         //                               color: Colors.grey,
//         //                               blurRadius: w * 0.01)
//         //                         ],
//         //                         borderRadius:
//         //                         BorderRadius.circular(w * 0.02)),
//         //                     child: SingleChildScrollView(
//         //                       child: Column(
//         //                         crossAxisAlignment: CrossAxisAlignment.start,
//         //                         children: [
//         //                           Container(
//         //                             height: h * 0.07,
//         //                             width: w,
//         //                             decoration: BoxDecoration(
//         //                                 boxShadow: [
//         //                                   BoxShadow(
//         //                                       color: Colors.grey,
//         //                                       blurRadius: w * 0.01)
//         //                                 ],
//         //                                 gradient: gradient,
//         //                                 borderRadius: BorderRadius.only(
//         //                                     topRight:
//         //                                     Radius.circular(w * 0.02),
//         //                                     topLeft:
//         //                                     Radius.circular(w * 0.02))),
//         //                             child: Padding(
//         //                               padding: EdgeInsets.all(8.0),
//         //                               child: Row(
//         //                                 mainAxisAlignment:
//         //                                 MainAxisAlignment.spaceBetween,
//         //                                 children: [
//         //                                   Text("Edit Values",
//         //                                       style: GoogleFonts.roboto(
//         //                                           textStyle: TextStyle(
//         //                                               fontSize: w * 0.030,
//         //                                               color: Colors.white,
//         //                                               fontWeight:
//         //                                               FontWeight.bold))),
//         //                                   InkWell(
//         //                                       onTap: () {
//         //                                         setState(() {
//         //                                           Editvalue = false;
//         //                                         });
//         //                                       },
//         //                                       child: SvgPicture.asset(
//         //                                         "assets/Close.svg",
//         //                                         height: h * 0.03,
//         //                                       ))
//         //                                 ],
//         //                               ),
//         //                             ),
//         //                           ),
//         //                           Padding(
//         //                             padding: EdgeInsets.all(w * 0.04),
//         //                             child: SingleChildScrollView(
//         //                               child: Column(
//         //                                 crossAxisAlignment:
//         //                                 CrossAxisAlignment.start,
//         //                                 children: [
//         //                                   Text(
//         //                                     "Attribute Name",
//         //                                     style: GoogleFonts.roboto(
//         //                                         textStyle: TextStyle(
//         //                                             fontSize: w * 0.030,
//         //                                             color: primaryColor,
//         //                                             fontWeight:
//         //                                             FontWeight.bold)),
//         //                                   ),
//         //                                   CustomDropdown(
//         //                                     hintText: atributename,
//         //                                     // borderSide: BorderSide(color: primaryColor),
//         //                                     // borderRadius: BorderRadius.circular(h * 0.01),
//         //                                     fieldSuffixIcon: Icon(
//         //                                       Icons.arrow_drop_down_outlined,
//         //                                       color: primaryColor,
//         //                                       size: h * 0.035,
//         //                                     ),
//         //                                     listItemStyle: TextStyle(
//         //                                         fontSize: w * 0.025),
//         //                                     selectedStyle: TextStyle(
//         //                                         fontSize: w * 0.018,
//         //                                         color: Colors.black),
//         //                                     fillColor: Colors.white,
//         //                                     hintStyle: TextStyle(
//         //                                         fontSize: w * 0.020,
//         //                                         color: Colors.black,
//         //                                         fontWeight: FontWeight.bold),
//         //                                     items: EditValue1,
//         //                                     controller: editValue,
//         //                                   ),
//         //                                   SizedBox(
//         //                                     height: h * 0.01,
//         //                                   ),
//         //                                   Text("Attributes Values",
//         //                                       style: GoogleFonts.roboto(
//         //                                           textStyle: TextStyle(
//         //                                               fontSize: w * 0.030,
//         //                                               color: primaryColor,
//         //                                               fontWeight:
//         //                                               FontWeight.bold))),
//         //                                   TextFormField(
//         //                                     controller: attributeValue,
//         //                                     decoration: InputDecoration(
//         //                                       // hintText:
//         //                                       // "Type Attribute Name eg: Litre",
//         //                                       // hintStyle: TextStyle(
//         //                                       //     color: const Color(0xffB3B3B3),
//         //                                       //     fontSize: h * 0.015),
//         //                                       enabledBorder:
//         //                                       const UnderlineInputBorder(
//         //                                         //<-- SEE HERE
//         //                                         borderSide: BorderSide(
//         //                                             width: 1,
//         //                                             color: Colors.black54),
//         //                                       ),
//         //                                     ),
//         //                                   ),
//         //                                   SizedBox(
//         //                                     height: h * 0.02,
//         //                                   ),
//         //                                   Row(
//         //                                     mainAxisAlignment:
//         //                                     MainAxisAlignment
//         //                                         .spaceBetween,
//         //                                     children: [
//         //                                       InkWell(
//         //                                         onTap: () {
//         //                                           aValus.add(
//         //                                               attributeValue.text);
//         //
//         //                                           setState(() {
//         //                                             attributeValue.clear();
//         //                                           });
//         //                                         },
//         //                                         child: Container(
//         //                                           height: h * 0.04,
//         //                                           width: w * 0.250,
//         //                                           decoration: BoxDecoration(
//         //                                               gradient: gradient,
//         //                                               borderRadius:
//         //                                               BorderRadius
//         //                                                   .circular(
//         //                                                   w * 0.02)),
//         //                                           child: Center(
//         //                                             child: Text(
//         //                                               "Add Values",
//         //                                               style: GoogleFonts.roboto(
//         //                                                   textStyle: TextStyle(
//         //                                                       fontSize:
//         //                                                       w * 0.030,
//         //                                                       color: Colors
//         //                                                           .white,
//         //                                                       fontWeight:
//         //                                                       FontWeight
//         //                                                           .bold)),
//         //                                             ),
//         //                                           ),
//         //                                         ),
//         //                                       ),
//         //                                       InkWell(
//         //                                         onTap: () {
//         //                                           setState(() {
//         //                                             aValus.clear();
//         //                                           });
//         //                                         },
//         //                                         child: aValus.isNotEmpty
//         //                                             ? Text(
//         //                                           "Clear all",
//         //                                           style: GoogleFonts.roboto(
//         //                                               textStyle: TextStyle(
//         //                                                   color: Colors
//         //                                                       .red,
//         //                                                   fontSize:
//         //                                                   h * 0.013,
//         //                                                   fontWeight:
//         //                                                   FontWeight
//         //                                                       .bold)),
//         //                                         )
//         //                                             : SizedBox(),
//         //                                       )
//         //                                     ],
//         //                                   ),
//         //                                   SizedBox(
//         //                                     height: h * 0.01,
//         //                                   ),
//         //                                   Container(
//         //                                     width: w,
//         //                                     child: ListView.builder(
//         //                                         physics: ScrollPhysics(),
//         //                                         shrinkWrap: true,
//         //                                         itemCount: aValus.length,
//         //                                         itemBuilder:
//         //                                             (BuildContext context,
//         //                                             int index) {
//         //                                           return ListTile(
//         //                                             leading: Text(
//         //                                               ". ${aValus[index]}",
//         //                                               style: TextStyle(
//         //                                                   fontSize:
//         //                                                   w * 0.030),
//         //                                             ),
//         //                                             trailing: InkWell(
//         //                                                 onTap: () {
//         //                                                   aValus.removeAt(
//         //                                                       index);
//         //                                                   setState(() {});
//         //                                                 },
//         //                                                 child:
//         //                                                 SvgPicture.asset(
//         //                                                   "assets/Close.svg",
//         //                                                   color: Colors.red,
//         //                                                   height: h * 0.025,
//         //                                                 )),
//         //                                           );
//         //                                         }),
//         //                                   ),
//         //                                   SizedBox(
//         //                                     height: h * 0.02,
//         //                                   ),
//         //                                   InkWell(
//         //                                     onTap: () {
//         //                                       print("==============");
//         //                                       print("");
//         //                                       db
//         //                                           .collection('vendor')
//         //                                           .doc(currentUser!.id)
//         //                                           .collection("attributes")
//         //                                           .doc(attributeId)
//         //                                           .update({
//         //                                         "attributeValues": aValus,
//         //                                         "attributeName":
//         //                                         editValue.text,
//         //                                         "status": 0
//         //                                       }).then((value) {
//         //                                         Editvalue = false;
//         //                                         print(editValue.text);
//         //                                         attributeName.clear();
//         //                                         attributeValue.clear();
//         //                                         setState(() {});
//         //                                       }).then((value) {
//         //                                         aValus.clear();
//         //                                       });
//         //                                     },
//         //                                     child: Container(
//         //                                       height: h * 0.04,
//         //                                       width: w,
//         //                                       decoration: BoxDecoration(
//         //                                           gradient: gradient,
//         //                                           borderRadius:
//         //                                           BorderRadius.circular(
//         //                                               w * 0.02)),
//         //                                       child: Center(
//         //                                         child: Text(
//         //                                           "Save",
//         //                                           style: GoogleFonts.roboto(
//         //                                               textStyle: TextStyle(
//         //                                                   fontSize: w * 0.030,
//         //                                                   color: Colors.white,
//         //                                                   fontWeight:
//         //                                                   FontWeight
//         //                                                       .bold)),
//         //                                         ),
//         //                                       ),
//         //                                     ),
//         //                                   ),
//         //                                   SizedBox(
//         //                                     height: h * 0.02,
//         //                                   )
//         //                                 ],
//         //                               ),
//         //                             ),
//         //                           )
//         //                         ],
//         //                       ),
//         //                     ),
//         //                   ),
//         //                 ),
//         //               )
//         //                   : Container(),
//         //             ]),
//         //           ]);
//         //         }),
//         //   ),
//         //   Container(
//         //     height: h * 0.05,
//         //     width: w * 2,
//         //     decoration: BoxDecoration(
//         //         color: Colors.green,
//         //         gradient: gradient,
//         //         borderRadius: BorderRadius.only(
//         //             topLeft: Radius.circular(w * 0.03),
//         //             topRight: Radius.circular(w * 0.02))),
//         //   ),
//         // ])
//         );
//   }
// }
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/products/relatedProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../globals/colors.dart';
import '../../model/addProductModel.dart';
import '../../model/addProductModel.dart';
import '../../model/usermodel.dart';
import '../login/splashscreen.dart';
import '../widgets/uploadmedia.dart';



class pendingApprovalView extends StatefulWidget {
  final AddProductModel productData;
  pendingApprovalView( {Key? key, required this. productData}) : super(key: key);

  @override
  State<pendingApprovalView> createState() => _pendingApprovalViewState();
}

class _pendingApprovalViewState extends State<pendingApprovalView> {
  getProducts(){

    FirebaseFirestore.instance.collection('products').get().then((value){
      for(DocumentSnapshot doc in value.docs){
        idToName[doc.get('name')]=doc.id;
        nameToId[doc.id]=doc.get('name');
      }
    });

  }
  bool AddproductTab=false;
  String? brandvalue;
  Map brandNametoId = {};
  List<String> brand1 = [];
  List<String> categoryList = [];
  List image = [];
  List video = [];
  List b2cTierPrice=[];
  List b2bTierPrice=[];
  List b2bDelhiTierPrice=[];
  List b2cDelhiTierPrice=[];
  List b2cKeralaTierPrice=[];
  List b2bKeralaTierPrice=[];
  List b2cNorthEast1TierPrice=[];
  List b2bNorthEast1TierPrice=[];
  List b2cTamilnaduTierPrice=[];
  List b2bTamilnaduTierPrice=[];
  bool B2c = false;
  bool B2b = false;
  bool imported = false;
  bool COD = false;
  bool nonveg = false;
  bool veg = false;
  bool sales = false;
  TextEditingController sellername = TextEditingController();
  TextEditingController productname = TextEditingController();
  TextEditingController productcode = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController stock = TextEditingController();
  TextEditingController hsncode = TextEditingController();
  TextEditingController sold = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController ingredients = TextEditingController();
  TextEditingController nutrition = TextEditingController();
  TextEditingController instruction = TextEditingController();
  TextEditingController madefrom = TextEditingController();
  TextEditingController B2cprice = TextEditingController();
  TextEditingController B2bprice = TextEditingController();
  TextEditingController B2cdelhiprice = TextEditingController();
  TextEditingController B2bdelhiprice = TextEditingController();
  TextEditingController B2ckeralaprice = TextEditingController();
  TextEditingController B2bkeralaprice = TextEditingController();
  TextEditingController B2cnortheast1price = TextEditingController();
  TextEditingController B2bnortheast1price = TextEditingController();
  TextEditingController B2ctamilnaduprice = TextEditingController();
  TextEditingController B2btamilnaduprice = TextEditingController();
  TextEditingController B2cdiscountprice = TextEditingController();
  TextEditingController B2bdiscountprice = TextEditingController();
  TextEditingController B2cdelhidiscountprice = TextEditingController();
  TextEditingController B2bdelhidiscountprice = TextEditingController();

  TextEditingController B2ckeraladiscountprice = TextEditingController();
  TextEditingController B2bkeraladiscountprice = TextEditingController();
  TextEditingController B2cnortheast1discountprice = TextEditingController();
  TextEditingController B2bnortheast1discountprice = TextEditingController();
  TextEditingController B2ctamilnadudiscountprice = TextEditingController();
  TextEditingController B2btamilnadudiscountprice = TextEditingController();
  TextEditingController B2cTierPriceVolum = TextEditingController();
  TextEditingController B2cDelhiTierPriceVolum = TextEditingController();
  TextEditingController B2bDelhiTierPriceVolum = TextEditingController();
  TextEditingController B2cKeralaTierPriceVolum = TextEditingController();
  TextEditingController B2bKeralaTierPriceVolum = TextEditingController();
  TextEditingController B2cNorthEast1TierPriceVolum = TextEditingController();
  TextEditingController B2bNorthEast1TierPriceVolum = TextEditingController();
  TextEditingController B2cTamilnaduTierPriceVolum = TextEditingController();
  TextEditingController B2bTamilnaduTierPriceVolum = TextEditingController();
  TextEditingController B2bTierPriceVolum = TextEditingController();
  TextEditingController B2cTierPriceAmount = TextEditingController();
  TextEditingController B2cDelhiTierPriceAmount = TextEditingController();
  TextEditingController B2bTamilnaduTierPriceAmount = TextEditingController();
  TextEditingController B2bDelhiTierPriceAmount = TextEditingController();
  TextEditingController B2cKeralaTierPriceAmount = TextEditingController();
  TextEditingController B2bKeralaTierPriceAmount = TextEditingController();
  TextEditingController B2cNorthEast1TierPriceAmount = TextEditingController();
  TextEditingController B2bNorthEast1TierPriceAmount = TextEditingController();
  TextEditingController B2cTamilnaduTierPriceAmount = TextEditingController();
  TextEditingController B2bTierPriceAmount = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController category = TextEditingController();
  TextEditingController gst = TextEditingController();

  @override
  void initState() {
    getProducts();
    // TODO: implement initState
    B2b=widget.productData.b2b!;
    B2c=widget.productData.b2c!;
    imported=widget.productData.imported!;
    COD=widget.productData.payOnDelivery!;
    sales=widget.productData.sales!;
    nonveg=widget.productData.nonveg ?? false;
    veg=widget.productData.veg!;
    sellername=TextEditingController(
        text: widget.productData.sellername);
    hsncode= TextEditingController(
        text: widget.productData.hsnCode.toString());
    sold=TextEditingController(
        text: widget.productData.sold.toString());
    description=TextEditingController(
        text: widget.productData.description);
    ingredients=TextEditingController(
        text: widget.productData.ingredients);
    nutrition=TextEditingController(
        text: widget.productData.fact);
    instruction=TextEditingController(
        text: widget.productData.instructions);
    madefrom=TextEditingController(
        text: widget.productData.madeFrom.toString());
    gst=TextEditingController(
        text: widget.productData.gst.toString());
    productname=TextEditingController(
        text: widget.productData.name.toString());
    productcode=TextEditingController(
        text: widget.productData.productCode.toString());
    weight=TextEditingController(
        text: widget.productData.weight.toString());
    stock=TextEditingController(
        text: widget.productData.stock.toString());
    if(B2c){
      B2cprice=TextEditingController(
          text: widget.productData.b2cP.toString());
      B2cdiscountprice=TextEditingController(
          text: widget.productData.b2cD.toString());
      B2cdelhiprice=TextEditingController(
          text: widget.productData.b2cDelhiP.toString());
      B2ckeralaprice=TextEditingController(
          text: widget.productData.b2cKeralaP.toString());
      B2cnortheast1price=TextEditingController(
          text: widget.productData.b2cNorthEast1P.toString());
      B2ctamilnaduprice=TextEditingController(
          text: widget.productData.b2cTamilnaduP.toString());
      B2cdelhidiscountprice=TextEditingController(
          text: widget.productData.b2cDelhiD.toString());
      B2ckeraladiscountprice=TextEditingController(
          text: widget.productData.b2cKeralaD.toString());
      B2cnortheast1discountprice=TextEditingController(
          text: widget.productData.b2cNorthEast1D.toString());
      B2ctamilnadudiscountprice=TextEditingController(
          text: widget.productData.b2cTamilnaduD.toString());
    }
    if(B2b){
      B2bprice=TextEditingController(
          text: widget.productData.b2bP.toString());
      B2bdiscountprice=TextEditingController(
          text: widget.productData.b2bD.toString());
      B2bdelhiprice=TextEditingController(
          text: widget.productData.b2bDelhiP.toString());
      B2bkeralaprice=TextEditingController(
          text: widget.productData.b2bKeralaP.toString());
      B2bnortheast1price=TextEditingController(
          text: widget.productData.b2bNorthEast1P.toString());
      B2btamilnaduprice=TextEditingController(
          text: widget.productData.b2bTamilnaduP.toString());
      B2bdelhidiscountprice=TextEditingController(
          text: widget.productData.b2bDelhiD.toString());
      B2bkeraladiscountprice=TextEditingController(
          text: widget.productData.b2bKeralaD.toString());
      B2bnortheast1discountprice=TextEditingController(
          text: widget.productData.b2bNorthEast1D.toString());
      B2btamilnadudiscountprice=TextEditingController(
          text: widget.productData.b2bTamilnaduD.toString());
    }
    b2bDelhiTierPrice=widget.productData.b2bDelhiTier??[];
    b2bKeralaTierPrice=widget.productData.b2bKeralaTier??[];
    b2bTamilnaduTierPrice=widget.productData.b2bTamilnaduTier??[];
    b2bNorthEast1TierPrice=widget.productData.b2bNorthEast1Tier??[];
    b2bTierPrice=widget.productData.b2bTier??[];
    b2cNorthEast1TierPrice=widget.productData.b2cNorthEast1Tier??[];
    b2cTierPrice=widget.productData.b2cTier??[];
    b2cTamilnaduTierPrice=widget.productData.b2cTamilnaduTier??[];
    b2cKeralaTierPrice=widget.productData.b2cKeralaTier??[];
    b2cDelhiTierPrice=widget.productData.b2cDelhiTier??[];
    selectedProduct=widget.productData.relatedProducts ?? [];
    image=widget.productData.imageId??[];
    video=widget.productData.videoUrl??[];
    super.initState();
  }
  bool loaded=false;
  List<Tab> myTabs = <Tab>[
    Tab(text: 'Product Details'),
    Tab(text: 'Media'),
  ];
  TabController? tabController;

  set(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Product View"),
        ),

        body:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
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
                  child: Column(
                      children: [
                        Container(
                          height: h * 0.05,
                          width: w * 1,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: DefaultTabController(
                            length: myTabs.length,
                            initialIndex: 2,
                            child: Container(
                              child: TabBar(
                                indicatorColor: Colors.transparent,
                                controller: tabController,
                                indicator: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                tabs: myTabs,
                                labelColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                              controller:tabController,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 5),
                                              child: Text("* ",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: h * 0.015,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                            ),
                                            InkWell(
                                              onTap: () {

                                              },
                                              child: Text(
                                                  "Only enable options that are relevant to your product. Please \n complete all  required fields to get approval.",
                                                  style: GoogleFonts.roboto(
                                                    textStyle: TextStyle(
                                                      color: primaryColor,
                                                      fontSize: h * 0.012,
                                                    ),
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("B2C",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: B2c,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          B2c = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),

                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("B2B",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: B2b,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          B2b = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("Imported",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: imported,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          imported = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            // SizedBox(
                                            //   width: w * 0.03,
                                            // ),
                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("COD",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: COD,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          COD = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("Non Veg",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: nonveg,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          nonveg = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                            // SizedBox(
                                            //   width: w * 0.03,
                                            // ),
                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("Veg",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: veg,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          veg = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),

                                        Row(
                                          children: [

                                            Container(
                                                height: h * 0.06,
                                                width: w * 0.450,
                                                decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: ListTile(
                                                  title: Text("Sale",
                                                      style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: primaryColor,
                                                            fontSize: h * 0.012,
                                                            fontWeight: FontWeight.bold),
                                                      )),
                                                  trailing: Container(
                                                    height: h * 0.03,
                                                    width: 40,
                                                    decoration: const BoxDecoration(
                                                        color: Colors.white),
                                                    child: FlutterSwitch(
                                                      activeColor:
                                                      const Color(0xff66BD46),
                                                      width: w * 0.13,
                                                      height: h * 0.035,
                                                      valueFontSize: 0.0,
                                                      toggleSize: 15.0,
                                                      value: sales,
                                                      borderRadius: 30.0,
                                                      padding: 8.0,
                                                      onToggle: (val) {
                                                        setState(() {
                                                          sales = val;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                )),
                                          ],
                                        ),

                                        SizedBox(
                                          height: h * 0.02,
                                        ),
                                        Divider(
                                          height: h * 0.01,
                                          thickness: h * 0.0015,
                                          color: Colors.grey,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text("Seller Name",
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                        TextStyle(fontSize: w * 0.03),
                                                        color: primaryColor)),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: sellername,
                                              readOnly: true,
                                              decoration: InputDecoration(
                                                hintText: currentUser?.Fullname,
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text("Product Name",
                                                    style: GoogleFonts.roboto(
                                                        textStyle:
                                                        TextStyle(fontSize: w * 0.03),
                                                        color: primaryColor)),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: productname,
                                              decoration: InputDecoration(
                                                hintText: "Enter Product Name",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Product Code(SKU)",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: productcode,
                                              decoration: InputDecoration(
                                                hintText:
                                                "Add 9 Digit Product Code of your choice. eg. BRAND40PA",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),

                                            Row(
                                              children: [
                                                Text(
                                                  "Product Description",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: description,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                hintText: "Description ",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.013),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),

                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Select Brand",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            CustomDropdown(
                                              hintText: "brand",
                                              borderSide: BorderSide(color: primaryColor),
                                              borderRadius:
                                              BorderRadius.circular(h * 0.01),
                                              fieldSuffixIcon: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: primaryColor,
                                                size: h * 0.035,
                                              ),
                                              listItemStyle:
                                              TextStyle(fontSize: w * 0.025),
                                              selectedStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black),
                                              fillColor: Colors.white,
                                              hintStyle: TextStyle(
                                                  fontSize: h * 0.015,
                                                  color: Colors.black),
                                              items: brand1.isEmpty ? [''] : brand1,
                                              controller: brand,
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Category",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            CustomDropdown(
                                              hintText: "category",
                                              borderSide: BorderSide(color: primaryColor),
                                              borderRadius:
                                              BorderRadius.circular(h * 0.01),
                                              fieldSuffixIcon: Icon(
                                                Icons.arrow_drop_down_outlined,
                                                color: primaryColor,
                                                size: h * 0.035,
                                              ),
                                              listItemStyle:
                                              TextStyle(fontSize: w * 0.025),
                                              selectedStyle: TextStyle(
                                                  fontSize: w * 0.025,
                                                  color: Colors.black),
                                              fillColor: Colors.white,
                                              hintStyle: TextStyle(
                                                  fontSize: h * 0.015,
                                                  color: Colors.black),
                                              items: categoryList.isEmpty
                                                  ? ['']
                                                  : categoryList,
                                              controller: category,
                                            ),


                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Ingredients",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: ingredients,
                                              decoration: InputDecoration(
                                                hintText:
                                                "Ingredients List or Upload as product Image",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Nutrition Fact",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: nutrition,
                                              decoration: InputDecoration(
                                                hintText:
                                                "Nutrition Info or Upload as product Image",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Instructions",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: instruction,
                                              decoration: InputDecoration(
                                                hintText:
                                                "Product Instructions eg. Usage or N/A etc.",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: h * 0.02,
                                            ),

                                            Row(
                                              children: [
                                                Text(
                                                  "Made From",
                                                  style: GoogleFonts.roboto(
                                                      textStyle:
                                                      TextStyle(fontSize: w * 0.03),
                                                      color: primaryColor),
                                                ),
                                                const Text(
                                                  "*",
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
                                            TextFormField(
                                              controller: madefrom,
                                              decoration: InputDecoration(
                                                hintText: "Product Origin  eg.India",
                                                hintStyle: TextStyle(
                                                    color: const Color(0xffB3B3B3),
                                                    fontSize: h * 0.015),
                                                enabledBorder: const UnderlineInputBorder(
                                                  //<-- SEE HERE
                                                  borderSide: BorderSide(
                                                      width: 1, color: Colors.black54),
                                                ),
                                              ),
                                            ),





                                            // // Text("Color"),
                                            // Align(
                                            //     alignment: Alignment.topRight,
                                            //     child: Text(
                                            //       "Add Color",
                                            //       style: GoogleFonts.roboto(
                                            //           textStyle: TextStyle(
                                            //               fontSize: w * 0.03),
                                            //           color: primaryColor),
                                            //     )),


                                            // Align(alignment:Alignment.topRight,child: Text("Add Attributes",style: TextStyle(color: primaryColor),)),


                                            // Align(alignment:Alignment.topRight,child: Text("Add Value",style: TextStyle(color: primaryColor),)),





                                            // SizedBox(height:h *0.02,),
                                            // Row(
                                            //
                                            //   children: [
                                            //
                                            //     Text("Select B2C Shipping Profile ",style: TextStyle(color: primaryColor),),
                                            //     Text("*",style: TextStyle(color: Colors.red),),
                                            //
                                            //
                                            //   ],
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(height: h*0.002,width: w*0.550,child: ColoredBox(color: primaryColor), ),
                                            //     SizedBox(height: h*0.002,width: w*0.350,child: ColoredBox(color: Colors.grey.shade200), ),
                                            //
                                            //
                                            //
                                            //   ],
                                            // ),
                                            // SizedBox(height: h*0.02,),
                                            // CustomDropdown(
                                            //
                                            //   hintText: "child category",
                                            //   borderSide: BorderSide(color:primaryColor),
                                            //   borderRadius: BorderRadius.circular(h * 0.01),
                                            //   fieldSuffixIcon: Icon(
                                            //     Icons.arrow_drop_down_outlined,
                                            //     color: primaryColor,
                                            //     size: h * 0.035,
                                            //   ),
                                            //   listItemStyle: TextStyle(fontSize: w * 0.025),
                                            //   selectedStyle: TextStyle(
                                            //       fontSize: w * 0.025, color: Colors.black),
                                            //   fillColor: Colors.white,
                                            //   hintStyle: TextStyle(
                                            //       fontSize: h * 0.015, color: Colors.black),
                                            //   items: gst1,
                                            //   controller: gst,
                                            // ),
                                            // SizedBox(height: h*0.02,),
                                            //
                                            // Row(
                                            //   children: [
                                            //     Text("*",style: TextStyle(color: Colors.red),),
                                            //
                                            //     Text("Tharacart default B2C shipping calculation is used.",style: TextStyle(fontSize: h*0.013,color: Color(0xff979797
                                            //     )),),
                                            //   ],
                                            // ),
                                            // SizedBox(height: h*0.02,),
                                            // Text("Select one shipping carrier ",style: TextStyle(color: primaryColor),),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(height: h*0.002,width: w*0.550,child: ColoredBox(color: primaryColor), ),
                                            //     SizedBox(height: h*0.002,width: w*0.350,child: ColoredBox(color: Colors.grey.shade200), ),
                                            //
                                            //
                                            //
                                            //   ],
                                            // ),
                                            // ListTile(leading: IconButton(onPressed: () { setState(() {
                                            //   _iconColor=Colors.green;
                                            // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                            // title: Text("Ship Rocket"),),
                                            // SizedBox(height: h*0.02,),
                                            // ListTile(leading: IconButton(onPressed: () { setState(() {
                                            //   _iconColor=Colors.green;
                                            // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                            //   title: Text("Delhivery"),),
                                            // SizedBox(height: h*0.02,),
                                            // ListTile(leading:  IconButton(onPressed: () { setState(() {
                                            //   _iconColor=Colors.green;
                                            // }); }, icon: Icon(Icons.circle_outlined,color: _iconColor,),),
                                            //   title: Text("XpressBees"),),
                                            // SizedBox(height: h*0.02,),
                                            // Row(children: [
                                            //   Text("Group Pricing ",style: TextStyle(color: primaryColor),),
                                            //   Text("*",style: TextStyle(color: Colors.red),),
                                            //   SizedBox(width: w*0.350,),
                                            //   FlutterSwitch(
                                            //     activeColor: Color(0xff66BD46),
                                            //     width: w*0.13,
                                            //     height: h*0.035,
                                            //     valueFontSize: 0.0,
                                            //     toggleSize: 15.0,
                                            //     value: Gpricing,
                                            //     borderRadius: 30.0,
                                            //     padding: 8.0,
                                            //     onToggle: (val) {
                                            //       setState(() {
                                            //         Gpricing = val;
                                            //       });
                                            //     },
                                            //   ),
                                            //
                                            // ],),
                                            SizedBox(height: h*0.02,),




                                            B2c?Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2C Global price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),

                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cprice,
                                                        decoration: InputDecoration(

                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cdiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),

                                                // Row(
                                                //     mainAxisAlignment:
                                                //     MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       Text("B2B Global price ",
                                                //           style: GoogleFonts.roboto(
                                                //               textStyle: TextStyle(
                                                //                   fontSize: w * 0.03),
                                                //               color:
                                                //               const Color(0xff298E03))),
                                                //       const Text(
                                                //         "*",
                                                //         style: TextStyle(color: Colors.red),
                                                //       ),
                                                //       SizedBox(
                                                //         width: w * 0.02,
                                                //       ),
                                                //       SizedBox(
                                                //         height: h * 0.0015,
                                                //         width: w * 0.55,
                                                //         child: ColoredBox(
                                                //           color: primaryColor,
                                                //         ),
                                                //       )
                                                //     ]),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //   MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Container(
                                                //       width: w * 0.40,
                                                //       child: TextFormField(
                                                //         controller: B2bprice,
                                                //         decoration: InputDecoration(
                                                //           hintText: "Price",
                                                //           hintStyle: TextStyle(
                                                //               color: const Color(0xffB3B3B3),
                                                //               fontSize: h * 0.015),
                                                //           enabledBorder:
                                                //           const UnderlineInputBorder(
                                                //             //<-- SEE HERE
                                                //             borderSide: BorderSide(
                                                //                 width: 1,
                                                //                 color: Colors.black54),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width: w * 0.04,
                                                //     ),
                                                //     Container(
                                                //       width: w * 0.40,
                                                //       child: TextFormField(
                                                //         controller: B2bdiscountprice,
                                                //         decoration: InputDecoration(
                                                //           hintText: "Discount Price",
                                                //           hintStyle: TextStyle(
                                                //               color: const Color(0xffB3B3B3),
                                                //               fontSize: h * 0.015),
                                                //           enabledBorder:
                                                //           const UnderlineInputBorder(
                                                //             //<-- SEE HERE
                                                //             borderSide: BorderSide(
                                                //                 width: 1,
                                                //                 color: Colors.black54),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: h * 0.03,
                                                // ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2C Delhi price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cdelhiprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cdelhidiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2C Kerala price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2ckeralaprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2ckeraladiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2C North East 1 price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.03,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.45,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cnortheast1price,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2cnortheast1discountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2C Tamilnadu price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.45,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2ctamilnaduprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2ctamilnadudiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),

                                              ],
                                            ):SizedBox(),
                                            SizedBox(
                                              height: h * 0.03,
                                            ),

                                            B2b?Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2B Global price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),

                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bdiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),

                                                // Row(
                                                //     mainAxisAlignment:
                                                //     MainAxisAlignment.spaceBetween,
                                                //     children: [
                                                //       Text("B2B Global price ",
                                                //           style: GoogleFonts.roboto(
                                                //               textStyle: TextStyle(
                                                //                   fontSize: w * 0.03),
                                                //               color:
                                                //               const Color(0xff298E03))),
                                                //       const Text(
                                                //         "*",
                                                //         style: TextStyle(color: Colors.red),
                                                //       ),
                                                //       SizedBox(
                                                //         width: w * 0.02,
                                                //       ),
                                                //       SizedBox(
                                                //         height: h * 0.0015,
                                                //         width: w * 0.55,
                                                //         child: ColoredBox(
                                                //           color: primaryColor,
                                                //         ),
                                                //       )
                                                //     ]),
                                                // Row(
                                                //   mainAxisAlignment:
                                                //   MainAxisAlignment.spaceBetween,
                                                //   children: [
                                                //     Container(
                                                //       width: w * 0.40,
                                                //       child: TextFormField(
                                                //         controller: B2bprice,
                                                //         decoration: InputDecoration(
                                                //           hintText: "Price",
                                                //           hintStyle: TextStyle(
                                                //               color: const Color(0xffB3B3B3),
                                                //               fontSize: h * 0.015),
                                                //           enabledBorder:
                                                //           const UnderlineInputBorder(
                                                //             //<-- SEE HERE
                                                //             borderSide: BorderSide(
                                                //                 width: 1,
                                                //                 color: Colors.black54),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ),
                                                //     SizedBox(
                                                //       width: w * 0.04,
                                                //     ),
                                                //     Container(
                                                //       width: w * 0.40,
                                                //       child: TextFormField(
                                                //         controller: B2bdiscountprice,
                                                //         decoration: InputDecoration(
                                                //           hintText: "Discount Price",
                                                //           hintStyle: TextStyle(
                                                //               color: const Color(0xffB3B3B3),
                                                //               fontSize: h * 0.015),
                                                //           enabledBorder:
                                                //           const UnderlineInputBorder(
                                                //             //<-- SEE HERE
                                                //             borderSide: BorderSide(
                                                //                 width: 1,
                                                //                 color: Colors.black54),
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     )
                                                //   ],
                                                // ),
                                                // SizedBox(
                                                //   height: h * 0.03,
                                                // ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2B Delhi price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bdelhiprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bdelhidiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2B Kerala price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.55,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bkeralaprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bkeraladiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2B North East 1 price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.03,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.45,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bnortheast1price,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2bnortheast1discountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: h * 0.03,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text("B2B Tamilnadu price ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03),
                                                              color:
                                                              const Color(0xff298E03))),
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(color: Colors.red),
                                                      ),
                                                      SizedBox(
                                                        width: w * 0.02,
                                                      ),
                                                      SizedBox(
                                                        height: h * 0.0015,
                                                        width: w * 0.45,
                                                        child: ColoredBox(
                                                          color: primaryColor,
                                                        ),
                                                      )
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2btamilnaduprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Price",
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
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Container(
                                                      width: w * 0.40,
                                                      child: TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: B2btamilnadudiscountprice,
                                                        decoration: InputDecoration(
                                                          hintText: "Discount Price",
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
                                                    )
                                                  ],
                                                ),

                                              ],
                                            ):SizedBox(),












                                            SizedBox(
                                              height: h * 0.03,
                                            ),

                                            SizedBox(height: h*0.02,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: h * 0.11,
                                                  width: w * 0.400,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Stock",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w * 0.03),
                                                                color: primaryColor),
                                                          ),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: stock,
                                                        decoration: InputDecoration(
                                                          hintText: " Stock Quantity",
                                                          hintStyle: TextStyle(
                                                              color:
                                                              const Color(0xffB3B3B3),
                                                              fontSize: h * 0.013),
                                                          enabledBorder:
                                                          const UnderlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  height: h * 0.11,
                                                  width: w * 0.400,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Sold",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w * 0.03),
                                                                color: primaryColor),
                                                          ),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        keyboardType: TextInputType.number,

                                                        controller: sold,
                                                        decoration: InputDecoration(
                                                          hintText: "sold of the product",
                                                          hintStyle: TextStyle(
                                                              color:
                                                              const Color(0xffB3B3B3),
                                                              fontSize: h * 0.013),
                                                          enabledBorder:
                                                          const UnderlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(height: h*0.02,),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: h * 0.11,
                                                  width: w * 0.250,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "HSN Code",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w * 0.03),
                                                                color: primaryColor),
                                                          ),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: hsncode,
                                                        decoration: InputDecoration(
                                                          hintText: " Hsn Code ",
                                                          hintStyle: TextStyle(
                                                              color:
                                                              const Color(0xffB3B3B3),
                                                              fontSize: h * 0.013),
                                                          enabledBorder:
                                                          const UnderlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  height: h * 0.11,
                                                  width: w * 0.250,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Weight",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w * 0.03),
                                                                color: primaryColor),
                                                          ),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: weight,
                                                        decoration: InputDecoration(
                                                          hintText: "Weight of the product",
                                                          hintStyle: TextStyle(
                                                              color:
                                                              const Color(0xffB3B3B3),
                                                              fontSize: h * 0.013),
                                                          enabledBorder:
                                                          const UnderlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: h * 0.11,
                                                  width: w * 0.250,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.white),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "GST",
                                                            style: GoogleFonts.roboto(
                                                                textStyle: TextStyle(
                                                                    fontSize: w * 0.03),
                                                                color: primaryColor),
                                                          ),
                                                          const Text(
                                                            "*",
                                                            style: TextStyle(
                                                                color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                      TextFormField(
                                                        keyboardType: TextInputType.number,
                                                        controller: gst,
                                                        decoration: InputDecoration(
                                                          hintText: " Stock Quantity",
                                                          hintStyle: TextStyle(
                                                              color:
                                                              const Color(0xffB3B3B3),
                                                              fontSize: h * 0.013),
                                                          enabledBorder:
                                                          const UnderlineInputBorder(
                                                            //<-- SEE HERE
                                                            borderSide: BorderSide(
                                                                width: 1,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            B2c? Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2C Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2cTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['name'];
                                                          String price=index==(b2cTierPrice.length)?"":b2cTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2cTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2C Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2cTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " name",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2cTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2cTierPrice.add({
                                                                                              "name": B2cTierPriceVolum.text,
                                                                                              "amount":B2cTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2cTierPriceVolum.clear();
                                                                                            B2cTierPriceAmount.clear();



                                                                                            print(b2cTierPrice);
                                                                                            //Navigator.of(context).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2cTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2cTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2cTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2C Delhi Tier Price',
                                                    style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor),),

                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2cDelhiTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2cDelhiTierPrice.length)?"":b2cDelhiTierPrice[index]['name'];
                                                          String price=index==(b2cDelhiTierPrice.length)?"":b2cDelhiTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2cDelhiTierPrice.length)){
                                                                            Map selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2C Delhi Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2cDelhiTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2cDelhiTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2cDelhiTierPrice.add({
                                                                                              "name": B2cDelhiTierPriceVolum.text,
                                                                                              "amount":B2cDelhiTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2cDelhiTierPriceVolum.clear();
                                                                                            B2cDelhiTierPriceAmount.clear();



                                                                                            print(b2cDelhiTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2cDelhiTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2cDelhiTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2cDelhiTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2C Kerala Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2cKeralaTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2cKeralaTierPrice.length)?"":b2cKeralaTierPrice[index]['name'];
                                                          String price=index==(b2cKeralaTierPrice.length)?"":b2cKeralaTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2cKeralaTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2C Kerala Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2cKeralaTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2cKeralaTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2cKeralaTierPrice.add({
                                                                                              "name": B2cKeralaTierPriceVolum.text,
                                                                                              "amount":B2cKeralaTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2cKeralaTierPriceVolum.clear();
                                                                                            B2cKeralaTierPriceAmount.clear();



                                                                                            print(b2cKeralaTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2cKeralaTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2cKeralaTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2cKeralaTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2C North East 1 Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2cNorthEast1TierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2cNorthEast1TierPrice.length)?"":b2cNorthEast1TierPrice[index]['name'];
                                                          String price=index==(b2cNorthEast1TierPrice.length)?"":b2cNorthEast1TierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2cNorthEast1TierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2C North East 1 Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2cNorthEast1TierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2cNorthEast1TierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2cNorthEast1TierPrice.add({
                                                                                              "name": B2cNorthEast1TierPriceVolum.text,
                                                                                              "amount":B2cNorthEast1TierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2cNorthEast1TierPriceVolum.clear();
                                                                                            B2cNorthEast1TierPriceAmount.clear();



                                                                                            print(b2cNorthEast1TierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2cNorthEast1TierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2cNorthEast1TierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2cNorthEast1TierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2C Tamilnadu Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2cTamilnaduTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2cTamilnaduTierPrice.length)?"":b2cTamilnaduTierPrice[index]['name'];
                                                          String price=index==(b2cTamilnaduTierPrice.length)?"":b2cTamilnaduTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2cTamilnaduTierPrice.length)){
                                                                            Map selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2C Tamilnadu Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2cTamilnaduTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2cTamilnaduTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2cTamilnaduTierPrice.add({
                                                                                              "name": B2cTamilnaduTierPriceVolum.text,
                                                                                              "amount":B2cTamilnaduTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2cTamilnaduTierPriceVolum.clear();
                                                                                            B2cTamilnaduTierPriceAmount.clear();



                                                                                            print(b2cTamilnaduTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2cTamilnaduTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2cTamilnaduTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2cTamilnaduTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ):SizedBox(),
                                            B2b? Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2B Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2bTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['name'];
                                                          String price=index==(b2bTierPrice.length)?"":b2bTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2bTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2B Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2bTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2bTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2bTierPrice.add({
                                                                                              "name": B2bTierPriceVolum.text,
                                                                                              "amount":B2bTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2bTierPriceVolum.clear();
                                                                                            B2bTierPriceAmount.clear();



                                                                                            print(b2bTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2bTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2bTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2bTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2B Delhi Tier Price',
                                                    style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor),),

                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2bDelhiTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2bDelhiTierPrice.length)?"":b2bDelhiTierPrice[index]['name'];
                                                          String price=index==(b2bDelhiTierPrice.length)?"":b2bDelhiTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2bDelhiTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2B Delhi Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2bDelhiTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2bDelhiTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2bDelhiTierPrice.add({
                                                                                              "name": B2bDelhiTierPriceVolum.text,
                                                                                              "amount":B2bDelhiTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2bDelhiTierPriceVolum.clear();
                                                                                            B2bDelhiTierPriceAmount.clear();



                                                                                            print(b2bDelhiTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2bDelhiTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2bDelhiTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2bDelhiTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2B Kerala Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2bKeralaTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]['name'];
                                                          String price=index==(b2bKeralaTierPrice.length)?"":b2bKeralaTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2bKeralaTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2B Kerala Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2bKeralaTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2bKeralaTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2bKeralaTierPrice.add({
                                                                                              "name": B2bKeralaTierPriceVolum.text,
                                                                                              "amount":B2bKeralaTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2bKeralaTierPriceVolum.clear();
                                                                                            B2bKeralaTierPriceAmount.clear();



                                                                                            print(b2bKeralaTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2bKeralaTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2bKeralaTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2bKeralaTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2B North East 1 Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2bNorthEast1TierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2bNorthEast1TierPrice.length)?"":b2bNorthEast1TierPrice[index]['name'];
                                                          String price=index==(b2bNorthEast1TierPrice.length)?"":b2bNorthEast1TierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2bNorthEast1TierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2B North East 1 Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2bNorthEast1TierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2bNorthEast1TierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2bNorthEast1TierPrice.add({
                                                                                              "name": B2bNorthEast1TierPriceVolum.text,
                                                                                              "amount":B2bNorthEast1TierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2bNorthEast1TierPriceVolum.clear();
                                                                                            B2bNorthEast1TierPriceAmount.clear();



                                                                                            print(b2bNorthEast1TierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2bNorthEast1TierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {
                                                                            print(b2bNorthEast1TierPrice);

                                                                            b2bNorthEast1TierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2bNorthEast1TierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                SizedBox(height: h*0.02,),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text('B2B Tamilnadu Tier Price',
                                                      style:GoogleFonts.roboto(textStyle: TextStyle(color: primaryColor,)

                                                      ) ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                                  child: Container(

                                                    child: ListView.builder(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        padding: EdgeInsets.zero,
                                                        scrollDirection: Axis.vertical,
                                                        shrinkWrap: true,
                                                        itemCount: b2bTamilnaduTierPrice.length+1,
                                                        itemBuilder: (context,index){
                                                          // TextEditingController admin$index=TextEditingController();
                                                          // // admin$index.text=index==(admins1.length)?"":admins1[index]['addOn'];
                                                          String name=index==(b2bTamilnaduTierPrice.length)?"":b2bTamilnaduTierPrice[index]['name'];
                                                          String price=index==(b2bTamilnaduTierPrice.length)?"":b2bTamilnaduTierPrice[index]['amount'];
                                                          return    Padding(
                                                            padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                            child: Container(
                                                              width: 350,
                                                              height: 50,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: primaryColor,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.max,
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(name),
                                                                    Text(price),

                                                                    IconButton(
                                                                        onPressed: () async {

                                                                          if(index==(b2bTamilnaduTierPrice.length)){
                                                                            Map<String,dynamic> selected=  await    showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return
                                                                                    AlertDialog(
                                                                                      title:  Text("Please Enter B2B Tamilnadu Tier Price",style: TextStyle(fontSize: h*0.02),),

                                                                                      actions: <Widget>[


                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,
                                                                                          controller: B2bTamilnaduTierPriceVolum,
                                                                                          decoration: InputDecoration(
                                                                                            hintText: " Volume",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextFormField(
                                                                                          keyboardType: TextInputType.number,

                                                                                          controller: B2bTamilnaduTierPriceAmount,
                                                                                          decoration: InputDecoration(

                                                                                            hintText: " Enter Amount",
                                                                                            hintStyle: TextStyle(
                                                                                                color:
                                                                                                const Color(0xffB3B3B3),
                                                                                                fontSize: h * 0.013),
                                                                                            enabledBorder:
                                                                                            const UnderlineInputBorder(
                                                                                              //<-- SEE HERE
                                                                                              borderSide: BorderSide(
                                                                                                  width: 1,
                                                                                                  color: Colors.black54),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            b2bTamilnaduTierPrice.add({
                                                                                              "name": B2bTamilnaduTierPriceVolum.text,
                                                                                              "amount":B2bTamilnaduTierPriceAmount.text
                                                                                            });
                                                                                            Navigator.of(context).pop();
                                                                                            B2bTamilnaduTierPriceVolum.clear();
                                                                                            B2bTamilnaduTierPriceAmount.clear();



                                                                                            print(b2bTamilnaduTierPrice);
                                                                                            // Navigator.of(ctx).pop();
                                                                                          },
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),

                                                                                            padding: const EdgeInsets.all(14),
                                                                                            child: const Text("Add",style: TextStyle(color: Colors.white),),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );

                                                                                });
                                                                            if(selected!=null) {
                                                                              b2bTamilnaduTierPrice.add(selected);
                                                                            }
                                                                            setState(() {
                                                                              // addon.add({
                                                                              // 'addOn':admins1[index]['addOn'],
                                                                              //   'addOnArabic':admins1[index]['addOnArabic'],
                                                                              //   'imageUrl':admins1[index]['imageUrl']
                                                                              // });
                                                                              // print(addon.length);

                                                                            });
                                                                          }else
                                                                          {

                                                                            b2bTamilnaduTierPrice.removeAt(index);
                                                                            setState(() {

                                                                            });

                                                                          }

                                                                        }, icon: index==(b2bTamilnaduTierPrice.length)?Icon(Icons.add):
                                                                    Icon(Icons.delete))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                              ],
                                            ):SizedBox(),








                                            // ExpansionTile(
                                            //   initiallyExpanded: true,
                                            //   title: Row(
                                            //       mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //       children: [
                                            //         Text(
                                            //           "Variants ",
                                            //           style: GoogleFonts.roboto(
                                            //               textStyle: TextStyle(
                                            //                   fontSize: w * 0.03,
                                            //                   fontWeight:
                                            //                   FontWeight.bold),
                                            //               color: primaryColor),
                                            //         ),
                                            //         // SizedBox(
                                            //         //   width: w * 0.02,
                                            //         // ),
                                            //         SizedBox(
                                            //           height: h * 0.0015,
                                            //           width: w * 0.58,
                                            //           child: ColoredBox(
                                            //             color: primaryColor,
                                            //           ),
                                            //         ),
                                            //       ]),
                                            //   children: [
                                            //     // SizedBox(
                                            //     //   width: w * 0.02,
                                            //     // ),
                                            //     Row(
                                            //       mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //       children: [
                                            //         Text(
                                            //           "1 L",
                                            //           style: GoogleFonts.roboto(
                                            //               textStyle: TextStyle(
                                            //                   fontSize: w * 0.03),
                                            //               color: primaryColor),
                                            //         ),
                                            //         SizedBox(
                                            //           width: w * 0.02,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: oneLprice,
                                            //             decoration: InputDecoration(
                                            //               hintText: "Price",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           width: w * 0.02,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: onesku,
                                            //             decoration: InputDecoration(
                                            //               hintText: "SKU",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           width: w * 0.02,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: onestock,
                                            //             decoration: InputDecoration(
                                            //               hintText: "Stock Qty",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         )
                                            //       ],
                                            //     ),
                                            //     SizedBox(
                                            //       height: h * 0.03,
                                            //     ),
                                            //     ImageList.length != 0
                                            //         ? Container(
                                            //       height: h * 0.12,
                                            //       child: ListView.separated(
                                            //         shrinkWrap: true,
                                            //         itemCount: ImageList.length,
                                            //         scrollDirection:
                                            //         Axis.horizontal,
                                            //         itemBuilder: (context, index) {
                                            //           return Stack(
                                            //             clipBehavior: Clip.none,
                                            //             children: [
                                            //               ImageList[index] == null
                                            //                   ? Container(
                                            //                 width: w * 0.18,
                                            //                 height: h * 0.10,
                                            //                 decoration:
                                            //                 const BoxDecoration(
                                            //                   color: Color(
                                            //                       0xffE9E9E9),
                                            //                 ),
                                            //               )
                                            //                   : Container(
                                            //                 width: w * 0.21,
                                            //                 height: h * 0.15,
                                            //                 decoration:
                                            //                 BoxDecoration(
                                            //                   image: DecorationImage(
                                            //                       image: NetworkImage(
                                            //                           ImageList[
                                            //                           index]),
                                            //                       fit: BoxFit
                                            //                           .cover),
                                            //                   color: const Color(
                                            //                       0xffE9E9E9),
                                            //                 ),
                                            //               ),
                                            //               Positioned(
                                            //                 left: w * 0.096,
                                            //                 bottom: h * 0.090,
                                            //                 child: InkWell(
                                            //                   onTap: () {
                                            //                     ImageList.removeAt(
                                            //                         index);
                                            //                     setState(() {});
                                            //                   },
                                            //                   child: Container(
                                            //                     width: w * 0.2,
                                            //                     height: h * 0.035,
                                            //                     child: const Icon(
                                            //                       Icons.clear,
                                            //                       color: Color
                                            //                           .fromARGB(
                                            //                           255,
                                            //                           254,
                                            //                           253,
                                            //                           255),
                                            //                       size: 22,
                                            //                     ),
                                            //                     decoration: const BoxDecoration(
                                            //                         color: Color(
                                            //                             0xff8C31FF),
                                            //                         shape: BoxShape
                                            //                             .circle),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           );
                                            //         },
                                            //         separatorBuilder:
                                            //             (BuildContext context,
                                            //             int index) {
                                            //           return SizedBox(
                                            //             width: 20,
                                            //           );
                                            //         },
                                            //       ),
                                            //     )
                                            //         : Container(
                                            //         color: Colors.grey.shade200,
                                            //         height: h * 0.12,
                                            //         width: double.maxFinite,
                                            //         child: Center(
                                            //           child: Text('Choose Image',
                                            //               style: TextStyle(
                                            //                   fontWeight:
                                            //                   FontWeight.w500,
                                            //                   fontSize: 18,
                                            //                   color: Colors
                                            //                       .grey.shade700)),
                                            //         )),
                                            //     SizedBox(
                                            //       height: h * 0.02,
                                            //     ),
                                            //     Stack(children: [
                                            //       Container(
                                            //           height: h * 0.05,
                                            //           width: w * 0.700,
                                            //           decoration: BoxDecoration(
                                            //               borderRadius:
                                            //               BorderRadius.circular(5),
                                            //               color: Colors.white,
                                            //               border: Border.all(
                                            //                   color: primaryColor)),
                                            //           child: Center(
                                            //               child: Text(
                                            //                 "Select Photo",
                                            //                 style: TextStyle(
                                            //                     color: primaryColor),
                                            //               ))),
                                            //       Align(
                                            //         alignment: Alignment.topRight,
                                            //         child: InkWell(
                                            //           onTap: () {
                                            //             showAlertDialogue(ImageList);
                                            //           },
                                            //           child: Container(
                                            //               height: h * 0.05,
                                            //               width: w * 0.300,
                                            //               decoration: BoxDecoration(
                                            //                   borderRadius:
                                            //                   BorderRadius.circular(
                                            //                       5),
                                            //                   color: primaryColor,
                                            //                   border: Border.all(
                                            //                       color: primaryColor)),
                                            //               child: const Center(
                                            //                   child: Text(
                                            //                     "Upload",
                                            //                     style: TextStyle(
                                            //                         color: Colors.white),
                                            //                   ))),
                                            //         ),
                                            //       ),
                                            //     ]),
                                            //     SizedBox(
                                            //       width: w * 0.01,
                                            //     ),
                                            //     Row(
                                            //       mainAxisAlignment:
                                            //       MainAxisAlignment.spaceBetween,
                                            //       children: [
                                            //         Text(
                                            //           "2 L",
                                            //           style: GoogleFonts.roboto(
                                            //               textStyle: TextStyle(
                                            //                   fontSize: w * 0.03),
                                            //               color: primaryColor),
                                            //         ),
                                            //         SizedBox(
                                            //           width: w * 0.01,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: twoprice,
                                            //             decoration: InputDecoration(
                                            //               hintText: "Price",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           width: h * 0.02,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: twosku,
                                            //             decoration: InputDecoration(
                                            //               hintText: "SKU",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         ),
                                            //         SizedBox(
                                            //           width: w * 0.02,
                                            //         ),
                                            //         Container(
                                            //           width: w * 0.25,
                                            //           child: TextFormField(
                                            //             controller: twostock,
                                            //             decoration: InputDecoration(
                                            //               hintText: "Stock Qty",
                                            //               hintStyle: TextStyle(
                                            //                   color:
                                            //                   const Color(0xffB3B3B3),
                                            //                   fontSize: h * 0.015),
                                            //               enabledBorder:
                                            //               const UnderlineInputBorder(
                                            //                 //<-- SEE HERE
                                            //                 borderSide: BorderSide(
                                            //                     width: 1,
                                            //                     color: Colors.black54),
                                            //               ),
                                            //             ),
                                            //           ),
                                            //         )
                                            //       ],
                                            //     ),
                                            //     SizedBox(
                                            //       height: h * 0.03,
                                            //     ),
                                            //     ImageList1.length != 0
                                            //         ? Container(
                                            //       height: h * 0.12,
                                            //       child: ListView.separated(
                                            //         shrinkWrap: true,
                                            //         itemCount: ImageList1.length,
                                            //         scrollDirection:
                                            //         Axis.horizontal,
                                            //         itemBuilder: (context, index) {
                                            //           return Stack(
                                            //             clipBehavior: Clip.none,
                                            //             children: [
                                            //               ImageList1[index] == null
                                            //                   ? Container(
                                            //                 width: w * 0.18,
                                            //                 height: h * 0.10,
                                            //                 decoration:
                                            //                 const BoxDecoration(
                                            //                   color: Color(
                                            //                       0xffE9E9E9),
                                            //                 ),
                                            //               )
                                            //                   : Container(
                                            //                 width: w * 0.21,
                                            //                 height: h * 0.15,
                                            //                 decoration:
                                            //                 BoxDecoration(
                                            //                   image: DecorationImage(
                                            //                       image: NetworkImage(
                                            //                           ImageList1[
                                            //                           index]),
                                            //                       fit: BoxFit
                                            //                           .cover),
                                            //                   color: const Color(
                                            //                       0xffE9E9E9),
                                            //                 ),
                                            //               ),
                                            //               Positioned(
                                            //                 left: w * 0.096,
                                            //                 bottom: h * 0.090,
                                            //                 child: InkWell(
                                            //                   onTap: () {
                                            //                     ImageList1
                                            //                         .removeAt(
                                            //                         index);
                                            //                     setState(() {});
                                            //                   },
                                            //                   child: Container(
                                            //                     width: w * 0.2,
                                            //                     height: h * 0.035,
                                            //                     child: const Icon(
                                            //                       Icons.clear,
                                            //                       color: Color
                                            //                           .fromARGB(
                                            //                           255,
                                            //                           254,
                                            //                           253,
                                            //                           255),
                                            //                       size: 22,
                                            //                     ),
                                            //                     decoration: const BoxDecoration(
                                            //                         color: Color(
                                            //                             0xff8C31FF),
                                            //                         shape: BoxShape
                                            //                             .circle),
                                            //                   ),
                                            //                 ),
                                            //               ),
                                            //             ],
                                            //           );
                                            //         },
                                            //         separatorBuilder:
                                            //             (BuildContext context,
                                            //             int index) {
                                            //           return SizedBox(
                                            //             width: 20,
                                            //           );
                                            //         },
                                            //       ),
                                            //     )
                                            //         : Container(
                                            //         color: Colors.grey.shade200,
                                            //         height: h * 0.12,
                                            //         width: double.maxFinite,
                                            //         child: Center(
                                            //           child: Text('Choose Image',
                                            //               style: TextStyle(
                                            //                   fontWeight:
                                            //                   FontWeight.w500,
                                            //                   fontSize: 18,
                                            //                   color: Colors
                                            //                       .grey.shade700)),
                                            //         )),
                                            //     SizedBox(
                                            //       height: h * 0.02,
                                            //     ),
                                            //     Stack(children: [
                                            //       Container(
                                            //           height: h * 0.05,
                                            //           width: w * 0.800,
                                            //           decoration: BoxDecoration(
                                            //               borderRadius:
                                            //               BorderRadius.circular(5),
                                            //               color: Colors.white,
                                            //               border: Border.all(
                                            //                   color: primaryColor)),
                                            //           child: Center(
                                            //               child: Text(
                                            //                 "Select Photo",
                                            //                 style: TextStyle(
                                            //                     color: primaryColor),
                                            //               ))),
                                            //       Align(
                                            //         alignment: Alignment.topRight,
                                            //         child: InkWell(
                                            //           onTap: () {
                                            //             showAlertDialogue(ImageList1);
                                            //           },
                                            //           child: Container(
                                            //               height: h * 0.05,
                                            //               width: w * 0.300,
                                            //               decoration: BoxDecoration(
                                            //                   borderRadius:
                                            //                   BorderRadius.circular(
                                            //                       5),
                                            //                   color: primaryColor,
                                            //                   border: Border.all(
                                            //                       color: primaryColor)),
                                            //               child: Center(
                                            //                   child: Text(
                                            //                     "Upload",
                                            //                     style: TextStyle(
                                            //                         color: Colors.white),
                                            //                   ))),
                                            //         ),
                                            //       ),
                                            //     ])
                                            //   ],
                                            // ),



                                            SizedBox(
                                              height: h * 0.04,
                                            ),


                                            // Stack(children: [
                                            InkWell(onTap: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>RelatedProduct(set:set)));
                                            },
                                              child: Container(
                                                height: h * 0.06,
                                                width: w,
                                                decoration: BoxDecoration(
                                                    border:
                                                    Border.all(color: primaryColor),
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(5)),

                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Select Related Products ",
                                                            style:
                                                            TextStyle(color: Color(0xffB3B3B3)),
                                                          ),
                                                          Icon(Icons.menu,color: Color(0xffB3B3B3),)
                                                        ],
                                                      ),

                                                    ),


                                                  ],
                                                ),
                                              ),
                                            ),
                                            selectedProduct.isNotEmpty?

                                            Container(
                                              height: h*0.15,
                                              width: w,
                                              child: Column(
                                                children: [
                                                  Expanded(



                                                    child: ListView.builder(
                                                      physics: ScrollPhysics(),
                                                      itemCount: selectedProduct.length,
                                                      itemBuilder: (BuildContext context, int index) {

                                                        return
                                                          Container(

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(2.0),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    // SelectedProduct.add({
                                                                    //   "name":data[index]["name"],
                                                                    //   "Id":data[index]["productId"]

                                                                    //});
                                                                    print(selectedProduct);

                                                                    // Handle onTap action
                                                                  });
                                                                },
                                                                child: Container(

                                                                    width: w,
                                                                    height: h*0.06,

                                                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                                                                      border:
                                                                      Border.all(color: primaryColor),),
                                                                    child:
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(8.0),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [

                                                                          Container(
                                                                            width: w * 0.70,
                                                                            child: Text(
                                                                              (nameToId[selectedProduct[index]].toString()),
                                                                              style: GoogleFonts.roboto(
                                                                                textStyle: TextStyle(
                                                                                  fontSize: h * 0.012,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),






                                                                        ],
                                                                      ),
                                                                    )


                                                                ),
                                                              ),
                                                            ),
                                                          );


                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ):SizedBox(),

                                            //   Align(
                                            //       alignment: Alignment.topRight,
                                            //       child: IconButton(
                                            //           onPressed: () {},
                                            //           icon: const Icon(Icons.menu))),
                                            // ]),
                                            // Padding(
                                            //   padding: const EdgeInsets.fromLTRB(10,10,10,0),
                                            //   child: Container(
                                            //       width: 330,
                                            //       decoration: BoxDecoration(
                                            //         color: Colors.white,
                                            //         borderRadius: BorderRadius.circular(8),
                                            //         border: Border.all(
                                            //           color: Color(0xFFE6E6E6),
                                            //         ),
                                            //       ),
                                            //       child: MultiFilterSelect(
                                            //         allItems: products,
                                            //         initValue: productsList,
                                            //         hintText: 'Select Related Products',
                                            //         selectCallback: (List selectedValue) =>
                                            //         productsList = selectedValue,
                                            //
                                            //       )
                                            //   ),
                                            // ),

                                            AddproductTab == false
                                                ? Padding(
                                              padding: EdgeInsets.only(
                                                  left: w * 0.05, right: w * 0.05),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: h * 0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ),
                                                      InkWell(onTap: (){


                                                      },
                                                        child: Text(
                                                            "Approval Time : 24 Hours ",
                                                            style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize: w * 0.03,
                                                                  color:
                                                                  primaryColor),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      // SizedBox(
                                                      //   width: w * 0.02,
                                                      // ),
                                                      Text(
                                                        "*",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: h * 0.020),
                                                      ),
                                                      Text(
                                                          "You can resubmit the Pending Approval \n Products from the Inventory list. ",
                                                          style: GoogleFonts.roboto(
                                                              textStyle: TextStyle(
                                                                  fontSize:
                                                                  w * 0.03),
                                                              color: primaryColor)),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: h * 0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {


                                                          if(
                                                          productname.text != '' &&
                                                              productcode.text != "" &&
                                                              stock.text != "" &&
                                                              hsncode.text != '' &&
                                                              description.text != ''&&
                                                              weight.text!=""&&
                                                              ingredients.text!=""&&
                                                              nutrition.text!=""&&
                                                              madefrom.text!=""&&
                                                              gst.text!=""
                                                          // B2c?B2cprice.text!=""&&
                                                          // B2c?B2cdiscountprice.text!=""&&
                                                          // B2c?B2cdelhiprice.text!=""&&
                                                          // B2c?B2cdelhidiscountprice.text!=""&&
                                                          // B2c?B2ckeralaprice.text!=""&&
                                                          // B2c?B2ckeraladiscountprice.text!=""&&
                                                          // B2c?B2cnortheast1price.text!=""&&
                                                          // B2c?B2cnortheast1discountprice.text!=""&&
                                                          // B2c?B2ctamilnaduprice!=""&&
                                                          // B2c?B2ctamilnadudiscountprice!=""&&
                                                          // B2b?B2bprice.text!=""&&
                                                          // B2b?B2bdiscountprice.text!=""&&
                                                          // B2b?B2bdelhiprice.text!=""&&
                                                          // B2b?B2bdelhidiscountprice.text!=""&&
                                                          // B2b?B2bkeralaprice.text!=""&&
                                                          // B2b?B2bkeraladiscountprice.text!=""&&
                                                          // B2b?B2bnortheast1price.text!=""&&
                                                          // B2b?B2bnortheast1discountprice.text!=""&&
                                                          // B2b?B2btamilnaduprice!=""&&
                                                          // B2b?B2btamilnadudiscountprice!=""
                                                          ){
                                                            await
                                                            showDialog(
                                                                context: context,
                                                                builder: (ctx) {
                                                                  return AlertDialog(
                                                                      title: Text(
                                                                          'Resubmit Product?'),
                                                                      content: Text(
                                                                          'Do you want to Continue?'),
                                                                      actions: [
                                                                        TextButton(
                                                                            child:
                                                                            Text(
                                                                              'Cancel',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  primaryColor),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context)
                                                                                  .pop();
                                                                            }),
                                                                        TextButton(
                                                                            child:
                                                                            Text(
                                                                              'Ok',
                                                                              style: TextStyle(
                                                                                  color:
                                                                                  primaryColor),
                                                                            ),
                                                                            onPressed:
                                                                                ()  async {
                                                                              final editProduct =Product?.copyWith(
                                                                                sales: sales,
                                                                                date: DateTime.now(),
                                                                                vendorId: currentUser?.id,
                                                                                available: false,
                                                                                b2b: B2b,
                                                                                b2c: B2c,
                                                                                b2bP:double.tryParse(B2bprice.text),
                                                                                b2bD:double.tryParse(B2bdiscountprice.text),
                                                                                b2bDelhiD: double.tryParse(B2bdelhidiscountprice.text),
                                                                                b2bDelhiP: double.tryParse(B2bdelhiprice.text),
                                                                                b2bDelhiTier: b2bDelhiTierPrice,
                                                                                b2bKeralaD: double.tryParse(B2bkeraladiscountprice.text),
                                                                                b2bKeralaP: double.tryParse(B2bkeralaprice.text),
                                                                                b2bKeralaTier: b2bKeralaTierPrice,
                                                                                b2bTamilnaduD: double.tryParse(B2btamilnadudiscountprice.text),
                                                                                b2bTamilnaduP: double.tryParse(B2btamilnaduprice.text),
                                                                                b2bTamilnaduTier:b2bTamilnaduTierPrice,
                                                                                b2bNorthEast1P: double.tryParse(B2bnortheast1discountprice.text),
                                                                                b2bNorthEast1D: double.tryParse(B2bnortheast1discountprice.text),
                                                                                b2bNorthEast1Tier: b2bNorthEast1TierPrice,
                                                                                b2bTier: b2bTierPrice,
                                                                                weight:double.tryParse(weight.text),
                                                                                sold: int.tryParse(sold.text),
                                                                                branchId: '',
                                                                                fives: 0,
                                                                                fours: 0,
                                                                                delete: false,
                                                                                ones: 0,
                                                                                open: false,
                                                                                relatedProducts: selectedProduct,
                                                                                search: [],
                                                                                start: 0,
                                                                                step: 0,
                                                                                stop: 0,
                                                                                threes: 0,
                                                                                totalReviews: 0,
                                                                                twos:0,
                                                                                userId: '',
                                                                                videoUrl: [],
                                                                                imported: imported,
                                                                                payOnDelivery: COD,
                                                                                nonveg: nonveg,
                                                                                veg: veg,
                                                                                sellername: currentUser!.Fullname,
                                                                                name: productname.text,
                                                                                productCode: productcode.text,
                                                                                stock: int.tryParse(stock.text),
                                                                                hsnCode:int.tryParse(hsncode.text),
                                                                                description: description.text,
                                                                                brand: brandNametoId[brandvalue].toString(),
                                                                                category: category.text,
                                                                                categoryName: category.text,
                                                                                ingredients: ingredients.text,
                                                                                fact: nutrition.text,
                                                                                instructions: instruction.text,
                                                                                madeFrom: madefrom.text,
                                                                                gst: double.tryParse(gst.text),
                                                                                b2cP: double.tryParse(B2cprice.text),
                                                                                b2cD: double.tryParse(B2cdiscountprice.text),
                                                                                b2cDelhiD: double.tryParse(B2cdelhidiscountprice.text),
                                                                                b2cDelhiP: double.tryParse(B2cdelhiprice.text),
                                                                                b2cDelhiTier: b2cDelhiTierPrice,
                                                                                b2cKeralaP: double.tryParse(B2ckeralaprice.text),
                                                                                b2cKeralaD: double.tryParse(B2ckeraladiscountprice.text),
                                                                                b2cKeralaTier: b2cKeralaTierPrice,
                                                                                b2cTamilnaduD: double.tryParse(B2ctamilnadudiscountprice.text),
                                                                                b2cTamilnaduP: double.tryParse(B2ctamilnaduprice.text),
                                                                                b2cTamilnaduTier: b2cTamilnaduTierPrice,
                                                                                b2cTier: b2cTierPrice,
                                                                                b2cNorthEast1P: double.tryParse(B2cnortheast1price.text),
                                                                                b2cNorthEast1D: double.tryParse(B2cnortheast1discountprice.text),
                                                                                b2cNorthEast1Tier: b2cNorthEast1TierPrice,
                                                                                status: 0,


                                                                              );

                                                                              // await Navigator.push(context, MaterialPageRoute(builder:
                                                                              //     (context) => mediaView(model:editProduct,data:widget.productData),));
                                                                              // showUploadMessage(
                                                                              //   context,
                                                                              //   'Product Added Successfully',
                                                                              //
                                                                              // );
                                                                              print("1");
                                                                              productname.text == '';
                                                                              productcode.text == '';
                                                                              stock.text == '';
                                                                              hsncode.text == '';
                                                                              description.text == '';
                                                                              weight.text =='';
                                                                              ingredients.text == '';
                                                                              nutrition.text == '';
                                                                              instruction.text == '';
                                                                              sold.text == '';
                                                                              madefrom.text == '';
                                                                              selectedProduct.clear();

                                                                              if(B2b){
                                                                                B2bprice.text == '';
                                                                                B2bdiscountprice=='';
                                                                                B2btamilnadudiscountprice=="";
                                                                                B2btamilnaduprice=="";
                                                                                B2bdelhidiscountprice=="";
                                                                                B2bdelhiprice=="";
                                                                                B2bkeralaprice=="";
                                                                                B2bkeraladiscountprice=="";
                                                                                B2bnortheast1discountprice=="";
                                                                                B2bnortheast1price=="";
                                                                                b2bNorthEast1TierPrice=[];
                                                                                b2bTierPrice=[];
                                                                                b2bTamilnaduTierPrice=[];
                                                                                b2bKeralaTierPrice=[];
                                                                                b2bDelhiTierPrice=[]
                                                                                ;
                                                                              }
                                                                              if(B2c){
                                                                                B2cprice.text == '';
                                                                                B2cdiscountprice=='';
                                                                                B2ctamilnadudiscountprice=="";
                                                                                B2ctamilnaduprice=="";
                                                                                B2cdelhidiscountprice=="";
                                                                                B2cdelhiprice=="";
                                                                                B2ckeralaprice=="";
                                                                                B2ckeraladiscountprice=="";
                                                                                B2cnortheast1discountprice=="";
                                                                                B2cnortheast1price=="";
                                                                                b2cNorthEast1TierPrice=[];
                                                                                b2cTierPrice=[];
                                                                                b2cTamilnaduTierPrice=[];
                                                                                b2cKeralaTierPrice=[];
                                                                                b2cDelhiTierPrice=[];

                                                                              }
                                                                            }),
                                                                      ]);
                                                                });
                                                          }else{
                                                            print("2");
                                                            productname.text == ''
                                                                ? showUploadMessage(context, 'Please enter product Name')
                                                                : productcode.text == '' ? showUploadMessage(context, 'Please enter productcode')
                                                                : stock.text == ''
                                                                ? showUploadMessage(
                                                                context,
                                                                'Please enter stock')
                                                                : hsncode.text == ''
                                                                ? showUploadMessage(
                                                                context,
                                                                'Please enter hsncode')
                                                                : description.text ==
                                                                ''
                                                                ? showUploadMessage(
                                                                context,
                                                                'Please enter product description')
                                                                :weight.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product weight')
                                                                :ingredients.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product ingredients')
                                                                :nutrition.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product nutrition fact')
                                                                :instruction.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product instruction')
                                                                :madefrom.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product made from')
                                                                :gst.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product gst')
                                                                :(B2c==true&&B2cprice.text=="")
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c price')
                                                                :(B2c==true&&B2cdiscountprice.text=="")
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c discount price')
                                                                :B2c==true&&B2cdelhiprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c delhi price')
                                                                :B2c==true&&B2cdelhidiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c B2c delhi discount price')
                                                                :B2c==true&&B2ckeralaprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2c kerala price')
                                                                :B2c==true&&B2ckeraladiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2c kerala discount price')
                                                                :B2c==true&&B2cnortheast1price.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2c northeast 1 price')
                                                                :B2c==true&&B2cnortheast1discountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c northeast 1 discount price')
                                                                :B2c==true&&B2ctamilnaduprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c tamilnadu price')
                                                                :B2c==true&&B2ctamilnadudiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2c amilnadu discount price')
                                                                :B2b==true&&B2bprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b price')
                                                                :B2b==true&&B2bdiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b discount price')
                                                                :B2b==true&&B2bdelhiprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b delhi price')
                                                                :B2b==true&&B2bdelhidiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b delhi discount price')
                                                                :B2b==true&&B2bkeralaprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2b kerala price')
                                                                :B2b==true&&B2bkeraladiscountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2b kerala discount price')
                                                                :B2b==true&&B2bnortheast1price.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product  B2b northeast 1 price')
                                                                :B2b==true&&B2bnortheast1discountprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b northeast 1 discount price')
                                                                :B2b==true&&B2btamilnaduprice.text==""
                                                                ?showUploadMessage(
                                                                context,
                                                                'Please enter product B2b tamilnadu price')
                                                                :B2b==true&&B2btamilnadudiscountprice.text=="" ?showUploadMessage(context,
                                                                'Please enter product B2b tamilnadu discount price'):'';
                                                          }




                                                          setState(() {});
                                                        },
                                                        child: Container(
                                                          height: h * 0.06,
                                                          width: w*0.40,
                                                          decoration: BoxDecoration(
                                                              color: primaryColor,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  w * 0.02)),
                                                          child: const Center(
                                                              child: Text(
                                                                "RESUBMIT",
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )),
                                                        ),
                                                      ),
                                                      InkWell(onTap: (){
                                                        Navigator.pop(context);
                                                        // FirebaseFirestore.instance.collection("products").doc(w).update(
                                                        //   {
                                                        //     "delete":true
                                                        //   }
                                                        // );
                                                      },
                                                        child: Container(
                                                          height: h * 0.06,
                                                          width: w*0.40,
                                                          decoration: BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  w * 0.02)),
                                                          child: const Center(
                                                              child: Text(
                                                                "CANCEL",
                                                                style: TextStyle(
                                                                    color: Colors.white),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                                : Container(),
                                            SizedBox(
                                              height: h * 0.04,
                                            ),
                                            SizedBox(
                                              height: h * 0.04,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // mediaView()
                              ]),
                        )
                      ]),
                ),
              ),
              SizedBox(height:10),
              Container(
                height: h * 0.05,
                width: w,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
              )


            ],

          ),
        ));
  }



}
