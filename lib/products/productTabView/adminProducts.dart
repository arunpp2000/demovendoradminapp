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
import '../edit/inventoryWidget.dart';


Map checkmap = {};

class AdminProducts extends StatefulWidget {
  final Function set;
  const AdminProducts({Key? key, required this.set}) : super(key: key);

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}

class _AdminProductsState extends State<AdminProducts> {

  Stream<List<AddProductModel>> getProduct() =>
      FirebaseFirestore.instance
          .collection("products")
          .where('status', isEqualTo: 1)
          .where('vendorId', isEqualTo: currentUser?.id)
          .snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());



  Stream<List<AddProductModel>> getSearchProduct() => FirebaseFirestore.instance
      .collection('products').where("status",isEqualTo: 1)
      .where('vendorId', isEqualTo: currentUser?.id)

      .where("search",arrayContains:searchProduct.text.toUpperCase())
      .snapshots()
      .map((snapshot) =>
      snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());


  bool sellectinventory=false;

  bool variablrpro = false;

  bool checkboxProductselect = false;

  bool selectall=false;
  TextEditingController inventorySortby = TextEditingController();
  TextEditingController searchProduct = TextEditingController();
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
  bool edit=false;
  late List<AddProductModel> inventorylist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
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
                        controller: searchProduct,
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
                        width: w * 0.3,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Color(0xffB3B3B3)),
                        ),
                      ),
                      SizedBox(
                        width: w * 0.01,
                      ),
                      Container(
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
                      Row(
                        children: [
                          Text(
                            "Activate",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontSize: w * 0.025,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 10,),
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
                            onToggle: ( bool val) {
                              for(var a in checkmap.keys){
                                FirebaseFirestore.instance.collection("products").doc(a).update({
                                  "available":true,
                                });

                              }
                              setState(() {
                                Activate = val;
                              });
                              widget.set();
                            },
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Deactivate",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontSize: w * 0.025,
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(width: 10,),
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
                            onToggle: (bool val) {
                              for(var a in checkmap.keys){
                                FirebaseFirestore.instance.collection("products").doc(a).update({
                                  "available":false,
                                });

                              }
                              setState(() {
                                Deactivate = val;
                              });
                              widget.set();
                            },
                          ),
                        ],
                      ),



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
                  Divider(thickness: h*0.0010,),
                  Column(
                      children: [
                        Container(
                          height: h*0.57,
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                          activeColor: primaryColor,
                                          value: checkboxProductselect,
                                          onChanged: (bool? value) {
                                            if (checkboxProductselect) {
                                              for (var a in inventorylist) {

                                                checkmap.remove(a.productId);
                                              }
                                            } else {
                                              for (var a in inventorylist) {

                                                checkmap[a.productId ]= true ;
                                                // print(a["productId"]);
                                              }
                                            }

                                            setState(() {
                                              checkboxProductselect = value!;
                                            });

                                          }),
                                      Text("Select All", style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: w * 0.02,
                                              fontWeight: FontWeight.bold)),),
                                    ],
                                  ),

                                  SizedBox(width: w*0.02,),
                                  Container(
                                      height: h*0.04,
                                      width: w*0.320,
                                      decoration: BoxDecoration(color: primaryColor,
                                          borderRadius: BorderRadius.circular(5)),
                                      child:
                                      Center(
                                        child: Text(
                                          " Pending Approval",
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
                                    width: w * 0.2800,
                                    child: CustomDropdown(
                                      onChanged: (index){
                                        setState(() {
                                          index.isEmpty?
                                          FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo: currentUser?.id).where("status",isEqualTo: 1)
                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                                              :index=="B2C Product"?
                                          FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo: currentUser?.id)
                                              .where('status', isEqualTo: 1).where("b2c",isEqualTo: true)
                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList())
                                              :index=="B2B Product"?
                                          FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo: currentUser?.id).where("b2b",isEqualTo: true)
                                              .where('status', isEqualTo: 1)
                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList()):
                                          index== "Inactive list"
                                              ? FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo:
                                              currentUser?.id).where("status",isEqualTo: 1).where("available",isEqualTo: false)

                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList()):
                                          index== "Active list"
                                              ? FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo:
                                              currentUser?.id).where("status",isEqualTo: 1).where("available",isEqualTo: true)

                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList()):
                                          index=="Descending"
                                              ? FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo:
                                              currentUser?.id).where("status",isEqualTo: 1)
                                              .orderBy('date',
                                              descending: true)
                                              .snapshots().map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList()):
                                          FirebaseFirestore.instance
                                              .collection("products")
                                              .where('vendorId',
                                              isEqualTo:
                                              currentUser?.id).where("status",isEqualTo: 1)
                                              .snapshots()
                                              .map((snapshot) =>
                                              snapshot.docs.map((doc) => AddProductModel.fromJson(doc.data())).toList());

                                        });
                                      },

                                      hintText: "Sort by",
                                      borderSide: BorderSide(color: primaryColor),
                                      borderRadius: BorderRadius.circular(5),
                                      fieldSuffixIcon: Icon(
                                        Icons.arrow_drop_down_outlined,
                                        color: primaryColor,
                                        size: h * 0.035,
                                      ),
                                      listItemStyle: TextStyle(fontSize: w * 0.025),
                                      selectedStyle: TextStyle(
                                          fontSize: h * 0.008, color: Colors.black),
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                          fontSize: h * 0.008, color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                      items: inventorySortby1,
                                      controller: inventorySortby,
                                    ),
                                  ),
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
                                      if (snapshot.hasError) {
                                      }
                                      inventorylist=snapshot.data!;
                                      return
                                        ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          // physics: ScrollPhysics(),
                                          itemCount: inventorylist.length,
                                          itemBuilder: (
                                              BuildContext context,
                                              int index) {
                                            return inventoryWidget(
                                                index:index,
                                                inventoryData:inventorylist[index],set:widget.set);
                                          },
                                        );
                                    }
                                ),
                              ),
                            ],
                          ),
                        )]


                  ),
                ],
              ),
            ),
            // SizedBox(height: h*0.03,),
            Container(
              height: h*0.05,
              width: w*2,
              decoration: BoxDecoration(gradient: gradient,borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w*0.03),topRight: Radius.circular(w*0.02))),
            )
          ],
        ),
      );
  }
}
