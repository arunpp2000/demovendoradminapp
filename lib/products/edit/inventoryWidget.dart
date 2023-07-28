import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../../model/addProductModel.dart';
import '../../model/usermodel.dart';
import '../inventoryList.dart';
import 'editProduct.dart';

class inventoryWidget extends StatefulWidget {
 final AddProductModel inventoryData;
  final Function set;
  int index;
   inventoryWidget({
     Key? key, required this. inventoryData,
     required this.index, required this.set
   }) : super(key: key);


  @override
  State<inventoryWidget> createState() => _inventoryWidgetState();
}

class _inventoryWidgetState extends State<inventoryWidget> {
  bool variablrpro = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    variablrpro = widget.inventoryData.available ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            thickness: h *
                0.001,
          ),

          Row(
            children: [
              Checkbox(
                activeColor: primaryColor,
                value: checkmap.containsKey(
                    widget.inventoryData.productId!),
                onChanged: (val) {
                  if (checkmap.containsKey(
                      widget.inventoryData.productId!)) {
                    checkmap.remove(
                       widget. inventoryData.productId!);
                  } else {
                    checkmap[widget.inventoryData.productId!] = true;
                  }

                  setState(() {});
                },
              ),
              Container(
                height: h * 0.1,
                width: w * 0.250,
                decoration: BoxDecoration(

                    color: Colors
                        .grey.shade300,
                    borderRadius:
                    BorderRadius
                        .circular(
                        w * 0.02)),
                child: CachedNetworkImage(imageUrl: widget.inventoryData.imageId!.isEmpty?" ":widget.inventoryData.imageId![0],fit: BoxFit.fill,),
              ),
              SizedBox(
                width: w *
                    0.015,
              ),
              Column(
                 mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: w*0.45,
                    child: Text(
                      widget.inventoryData.name!,
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Color(0xff1E3354),
                              fontSize: h*0.015,fontWeight: FontWeight.bold
                          )),
                    ),
                  ),
                  SizedBox(
                    height: h *
                        0.01,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      widget.inventoryData.status==
                          1
                          ? Row(
                        children: [
                          Text(
                              "Selling Price:",
                              style: GoogleFonts.roboto(
                                  textStyle:
                                  TextStyle(color: Color(0xff298E03), fontSize: w * 0.025))),
                          widget.inventoryData.b2b==true?
                          Text(
                              " \u{20B9}${ widget.inventoryData.b2bP}"
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  textStyle:
                                  TextStyle(color: Color(0xff298E03), fontSize: w * 0.025))):
                          Text(
                              " \u{20B9}${ widget.inventoryData.b2cP}"
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  textStyle:
                                  TextStyle(color: Color(0xff298E03), fontSize: w * 0.025)))
                        ],
                      )
                          : Text(''),
                      SizedBox(
                        width: w * 0.05,
                      ),
                      Row(
                        children: [
                          Text('Stock:',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Color(
                                          0xff298E03),
                                      fontSize:
                                      w * 0.025))),
                          Text(
                              widget.inventoryData.stock
                                  .toString(),
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Color(
                                          0xff298E03),
                                      fontSize:
                                      w * 0.025))),
                        ],
                      )
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  FlutterSwitch(
                    activeColor:widget.inventoryData.available==false?Colors.grey:Color(
                        0xff66BD46),
                    width: w * 0.1,
                    height: h *
                        0.030,
                    valueFontSize: 0.0,
                    toggleSize: 15.0,
                    value:widget.inventoryData.available!,
                    borderRadius: 30.0,
                    padding: 8.0,
                    onToggle: (bool val) {
                      FirebaseFirestore.instance.collection("products").doc(widget.inventoryData.productId ).update({
                        "available":val,
                      });

                      setState(() {
                        variablrpro =
                            val;
                      });
                      widget.set();
                    },
                  ),
                  SizedBox(
                    width: w *
                        0.05,
                  ),
                  Text(
                    widget.inventoryData.available ==
                        true
                        ? "Active"
                        : "Inactive",
                    style: GoogleFonts
                        .roboto(
                        textStyle: TextStyle(
                            fontSize: w *
                                0.025,
                            color: primaryColor,
                            fontWeight:
                            FontWeight
                                .bold)),
                  ),
                ],
              ),
              InkWell(
                onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:
                    (context)=>editProduct(inVentoryData: widget.inventoryData,
                )));

              },
                child: Container(
                  height: h *
                      0.04,
                  width: w *
                      0.15,
                  decoration: BoxDecoration(
                      color: Colors
                          .white,
                      border: Border
                          .all(
                          color: primaryColor),
                      borderRadius: BorderRadius
                          .circular(
                          5)),
                  child: Center(
                      child: Text(
                          "Edit",
                          style: GoogleFonts
                              .roboto(
                              textStyle: TextStyle(
                                  fontSize: w *
                                      0.030,
                                  color: primaryColor,
                                  fontWeight:
                                  FontWeight
                                      .bold)))),),
              )
            ],
          ),

        ],
      ),
    );
  }
}
