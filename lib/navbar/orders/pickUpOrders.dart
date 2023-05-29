import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../globals/colors.dart';
import '../../login/otplogin.dart';
import 'orderDetailsPage.dart';

class PickUpOrders extends StatefulWidget {
  const PickUpOrders({Key? key}) : super(key: key);

  @override
  State<PickUpOrders> createState() => _PickUpOrdersState();
}

class _PickUpOrdersState extends State<PickUpOrders> {
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
    {"text": "Delivered"},
    {"text": "Refund"},
  ];
  TextEditingController dateInput =TextEditingController();
  TextEditingController EndDate =TextEditingController();
  TextEditingController weekController = TextEditingController();
  List<String> items = ["Today", "This Week", " This Month", "This Year"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(
              height: h * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: w * 0.02,
                ),
                Text(
                  "Pick Up Orders",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: h * 0.015,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: w * 0.01,
                ),
                SizedBox(
                  height: h * 0.0020,
                  width: w * 0.38,
                  child: DecoratedBox(
                      decoration: BoxDecoration(color: primaryColor)),
                ),
                SizedBox(
                  width: w * 0.02,
                ),
                Container(
                    height: h * 0.050,
                    width: w * 0.278,
                    child: CustomDropdown(
                      borderRadius:BorderRadius.circular(5),
                      fieldSuffixIcon: Icon(
                        Icons.arrow_drop_down_outlined,
                        color: Colors.white,
                        size: h * 0.035,
                      ),
                      listItemStyle: TextStyle(fontSize: w * 0.025),
                      selectedStyle: TextStyle(
                          fontSize: w * 0.025, color: Colors.white),
                      fillColor: primaryColor,
                      hintStyle:
                      TextStyle(fontSize: 6, color: Colors.white),
                      items: items,
                      controller: weekController,
                    )),
              ],
            ),
            SizedBox(
              height: h * 0.01,
            ),
            Row(children: [
              Container(
                  height: h * 0.050,
                  width: w * 0.310,
                  decoration: BoxDecoration(border: Border.all(color: primaryColor),
                  ),child:TextField(controller: dateInput,
                  decoration: InputDecoration(
                      icon: Icon(Icons.calendar_today,color: primaryColor,),
                      border: InputBorder.none )
                  ,readOnly: true,
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
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInput.text =
                            formattedDate; //set output date to TextField value.
                      });
                    }})
              ),
              Container(
                  height: h * 0.050,
                  width: w * 0.350,
                  decoration: BoxDecoration(border: Border.all(color: primaryColor),
                  ),
                  child:TextField(controller: EndDate,
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today,color: primaryColor,),
                          border: InputBorder.none )
                      ,readOnly: true,
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
                          DateFormat('dd/MM/yyyy').format(pickedDate);

                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            EndDate.text =
                                formattedDate; //set output date to TextField value.
                          });
                        }})
              ),
              SizedBox(width: w*0.02,),
              Container(
                height: h * 0.050,
                width: w * 0.275,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(h*0.01),color: primaryColor),
                child: Center(child: Text("Go",style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: h*0.02,color: Colors.white)),)),)

            ],
            ),
            SizedBox(
              height: h * 0.02,
            ),
            Column(
              children: [
                DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(

                          height: h * 0.05,
                          width: w * 0.98,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10)
                              )
                          ),
                          child: TabBar(
                            indicatorColor: Colors.transparent,
                            indicator: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.only(topRight:Radius.circular(10),topLeft: Radius.circular(10)
                                )
                            ),
                            tabs: [
                              Tab(text:'B2C Orders'),
                              Tab(text:'B2B Orders')
                            ],
                            labelColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: h ,
                          width: double.infinity,
                          child: TabBarView(children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Expanded(
                                    flex: 0,
                                    child: b2c == true || b2b == true
                                        ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            mainAxisExtent: 45,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: h * 0.01),
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    overview[index]["text"],
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: _selectedIndex1 == index
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: h * 0.015)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                        : SizedBox()),

                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Container(
                                  height: h * 0.050,
                                  width: w * 1,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add Order",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (buildContext, int index) {
                                        // Map shippingAddress=data[index]['shippingAddress'];
                                        return Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => OrderDetailsPage(
                                              //           // id: data[index].id,
                                              //         )));
                                            },
                                            child: Container(
                                              width: w * 1,
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
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    4, 10, 4, 10),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: primaryColor,
                                                            child: SvgPicture.asset(
                                                              color: Colors.white,
                                                              " ",
                                                              height: h * 0.03,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Arun P P',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          'RazorPay',
                                                          style: TextStyle(color: primaryColor),
                                                        ),
                                                        Text(
                                                          '₹ 654.4',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Order No : 468451',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: w * 0.030),
                                                        ),
                                                        Text(
                                                          'Order Date : 19-02-2023 02:54',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: w * 0.025),
                                                        ),
                                                        new RichText(
                                                          text: new TextSpan(
                                                            text: '',
                                                            children: <TextSpan>[
                                                              new TextSpan(
                                                                  text: 'Status : ',
                                                                  style: new TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: w * 0.025)),
                                                              new TextSpan(
                                                                  text: 'pending',
                                                                  style: new TextStyle(
                                                                      color: primaryColor,
                                                                      fontSize: w * 0.030)),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Logistics ID : THARA894',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: w * 0.030),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Expanded(
                                    flex: 0,
                                    child: b2c == true || b2b == true
                                        ? GridView.builder(
                                        shrinkWrap: true,
                                        physics: ClampingScrollPhysics(),
                                        gridDelegate:
                                        SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            mainAxisExtent: 45,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: h * 0.01),
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
                                                padding: EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Text(
                                                    overview[index]["text"],
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                            color: _selectedIndex1 == index
                                                                ? Colors.white
                                                                : Colors.black,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: h * 0.015)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })
                                        : SizedBox()),

                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Container(
                                  height: h * 0.050,
                                  width: w * 1,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    border: Border.all(color: primaryColor),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Add Order",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: ListView.builder(
                                      physics: ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: 5,
                                      itemBuilder: (buildContext, int index) {
                                        // Map shippingAddress=data[index]['shippingAddress'];
                                        return Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(10, 5, 10, 10),
                                          child: InkWell(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) => OrderDetailsPage(
                                              //           // id: data[index].id,
                                              //         )));
                                            },
                                            child: Container(
                                              width: w * 1,
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
                                                padding: EdgeInsetsDirectional.fromSTEB(
                                                    4, 10, 4, 10),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 20,
                                                            backgroundColor: primaryColor,
                                                            child: SvgPicture.asset(
                                                              color: Colors.white,
                                                              " ",
                                                              height: h * 0.03,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: w * 0.04,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Arun P P',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Text(
                                                          'RazorPay',
                                                          style: TextStyle(color: primaryColor),
                                                        ),
                                                        Text(
                                                          '₹ 654.4',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      ],
                                                    ),
                                                    Spacer(),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          'Order No : 468451',
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: w * 0.030),
                                                        ),
                                                        Text(
                                                          'Order Date : 19-02-2023 02:54',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: w * 0.025),
                                                        ),
                                                        new RichText(
                                                          text: new TextSpan(
                                                            text: '',
                                                            children: <TextSpan>[
                                                              new TextSpan(
                                                                  text: 'Status : ',
                                                                  style: new TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight:
                                                                      FontWeight.bold,
                                                                      fontSize: w * 0.025)),
                                                              new TextSpan(
                                                                  text: 'pending',
                                                                  style: new TextStyle(
                                                                      color: primaryColor,
                                                                      fontSize: w * 0.030)),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          'Logistics ID : THARA894',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: w * 0.030),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ]),
                        )


                      ],
                    )),

              ],
            ),
          ]),
        ),
      ),
    );
  }
}
