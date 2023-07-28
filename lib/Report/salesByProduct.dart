import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/Report/productGraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


import '../globals/colors.dart';
import '../login/splashscreen.dart';
import '../model/usermodel.dart';

class salesByProduct extends StatefulWidget {
  const salesByProduct({Key? key}) : super(key: key);

  @override
  State<salesByProduct> createState() => _salesByProductState();
}

class _salesByProductState extends State<salesByProduct> {
  List products = [
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
    {"name": "ftftftf"},
  ];
  List<String> items = ["Today", "This Week", " This Month", "This Year"];
  List<String> report = ["Today", "Last 7 days", " This Month", "This Year"];
  TextEditingController dropdown = TextEditingController();
  TextEditingController reportDropdown = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  TextEditingController EndDate = TextEditingController();
  List productList = [];
  late StreamSubscription<QuerySnapshot> _product;
   getProducts() async {
    _product=  FirebaseFirestore.instance
        .collection('orders')
     .where('vendorId', isEqualTo: currentUser!.id)
        .snapshots()
        .listen((event) {
      for (DocumentSnapshot doc in event.docs) {
        List<dynamic> items = doc['items'];
        for (var item in items) {
          bool found = false;
          for (var product in productList) {
            if (product['name'] == item['name']) {
              product['qty'] += item['quantity'];
              found = true;
              break;
            }
          }
          if (!found) {
            productList.add({
              'name': item['name'],
              'price': item['price'],
              'qty': item['quantity'],
            });
          }
        }
      }

      print(productList.length);
      if (kDebugMode) {
        print('===============');
      }

      if (mounted) {
        setState(() {

        });
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _product.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: h / 1.477,
            width: w,
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: w * 0.01),
                ],
                borderRadius: BorderRadius.circular(5)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: h * 0.04,
                          width: w / 1.8,
                          decoration: BoxDecoration(
                              border: Border.all(color: primaryColor),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                setState(() {});
                              },
                              //controller:searchProduct ,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    fontSize: w * 0.030, color: Colors.black),
                                hintText: 'Search',
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
                        Container(
                            height: h * 0.04,
                            width: w * 0.340,
                            child: CustomDropdown(
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
                                  fontSize: h * 0.015, color: Colors.white),
                              items: items,
                              controller: dropdown,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Seller-",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: primaryColor,
                                    fontSize: h * 0.015,
                                    fontWeight: FontWeight.bold))),
                        Text("",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: h * 0.015,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(
                          height: h * 0.0020,
                          width: w * 0.20,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey)),
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
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Seller Sales Report",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: h * 0.015,
                                    fontWeight: FontWeight.bold))),
                        Container(
                            height: h * 0.04,
                            width: w * 0.340,
                            child: CustomDropdown(
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
                                  fontSize: h * 0.015, color: Colors.white),
                              items: report,
                              controller: reportDropdown,
                            )),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: h * 0.0040,
                          width: w * 0.4,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
                        ),
                        SizedBox(
                          height: h * 0.0010,
                          width: w * 0.15,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
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
                            width: w * 0.340,
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff530CAD)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5)),
                            ),
                            child: TextField(
                                controller: dateInput,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color(0xff530CAD),
                                    ),
                                    border: InputBorder.none),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                })),
                        Container(
                            height: h * 0.050,
                            width: w * 0.340,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff530CAD)),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5))),
                            child: TextField(
                                controller: EndDate,
                                decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color(0xff530CAD),
                                    ),
                                    border: InputBorder.none),
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy')
                                            .format(pickedDate);

                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      EndDate.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  }
                                })),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        Container(
                          height: h * 0.045,
                          width: w * 0.210,
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: h * 0.02,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        var data = productList[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: h * 0.1,
                            width: w,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey, blurRadius: w * 0.01)
                                ]),
                            child: Row(
                              children: [
                                Container(
                                  height: h * 0.1,
                                  width: w * 0.03,
                                  decoration: BoxDecoration(
                                      color: Color(0xff298E03),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width:w/1.3,
                                          child: Text(
                                            data['name'],
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                              fontSize: h * 0.018,
                                            )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: h*0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Total Sales: '+
                                            data['qty'].toString(),
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                              fontSize: h * 0.015,
                                            )),
                                          ),
                                          SizedBox(
                                            width: w * 0.1,
                                          ),
                                          Text(
                                            "Sale Value: ",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                              fontSize: h * 0.015,
                                            )),
                                          ),
                                          Text(
                                            " \u{20B9}${data['price']*data['qty']}",
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                              color: Color(0xff298E03),
                                              fontSize: h * 0.015,
                                            )),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Text(
                      "Sales Stats Graph",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: h * 0.013,
                              fontWeight: FontWeight.bold)),
                    ),
                    BarChartSample6(),
                    Row(
                      children: [
                        SizedBox(
                          height: h * 0.0040,
                          width: w * 0.40,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
                        ),
                        SizedBox(
                          height: h * 0.0010,
                          width: w / 2,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
                        ),
                      ],
                    ),
                    SizedBox(height: h * 0.02),
                    Text(
                      "Download Reports",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: h * 0.013,
                              fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: h * 0.0040,
                          width: w * 0.40,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
                        ),
                        SizedBox(
                          height: h * 0.0010,
                          width: w / 2,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: primaryColor)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Container(
                      height: h * 0.045,
                      width: w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: primaryColor),
                      child: Center(
                          child: Text(
                        "Download Report",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: h * 0.02, color: Colors.white)),
                      )),
                    ),
                    SizedBox(
                      height: h * 0.01,
                    ),
                    Row(
                      children: [
                        Text(
                          "*",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: h * 0.015, color: Colors.red)),
                        ),
                        Text(
                          "Please Choose a date range and downlod.",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                            fontSize: h * 0.015,
                          )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h * 0.01,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: h * 0.02,
        ),
        Container(
          height: h * 0.03,
          width: w,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
        )
      ],
    );
  }
}
