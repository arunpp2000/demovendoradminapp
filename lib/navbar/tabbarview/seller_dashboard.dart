import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/model/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../Report/orderGraph.dart';
import '../../brands/brands.dart';
import '../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../../products/productTab.dart';


class Dashboard extends StatefulWidget {
  final TabController controller;

   Dashboard({Key? key, required this.controller}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController hi = TextEditingController();
  List overview = [
    {"icon": 'assets/Vector.svg',
      "text": "Orders"
    },
    {"icon": 'assets/chart.svg',
      "text": "Sales"},
    {"icon": 'assets/mypro.svg',
      "text": "Products"},
    {"icon": 'assets/mypro.svg',
      "text": "Brands"
    },
    {"icon": 'assets/mypro.svg',
      "text": "B2C Customers"
    },
    {"icon": 'assets/mypro.svg',
      "text": "B2B Customers"
    }
  ];
  List order = [
    {"text": "Pending"},
    {"text": "Processing"},
    {"text": "Shipped"},
    {"text": "Delivered"},
    {"text": "Rto"},
    {"text": "Refund"}
  ];

  List<String> items = ["Today", "This Week", " This Month", "This Year"];
  TextEditingController dateInput = TextEditingController();
  TextEditingController EndDate = TextEditingController();
  @override
  void initState() {
    dateInput.text = "";
    EndDate.text = "";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(w * 0.02),
            child: Column(children: [
              SizedBox(
                height: h * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Text(
                    "Overview",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.40,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: primaryColor)),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  InkWell(
                    onTap: (){
                     //
                     // FirebaseFirestore.instance.collection('category').get().then((value) {
                     //   for(DocumentSnapshot a in value.docs){
                     //     dynamic data=a.data();
                     //      FirebaseFirestore.instance.collection('category').doc(a.id).update({
                     //        'status':1,
                     //        'delete':false,
                     //      });
                     //      print(a.id);
                     //   }
                     // });

                      // var user=UserModel(
                      //   status: 1,
                      //   email: '',
                      //   bankDetails: {
                      //
                      //   },
                      //   Fullname: 'thara store vendor',
                      //   id: 'bGa7yjwM1DV4hPpbqksXEoh6DEb2',
                      //   phone: ''
                      //
                      //
                      // );
                      // FirebaseFirestore.instance.collection('vendor').doc('bGa7yjwM1DV4hPpbqksXEoh6DEb2').set(user.toJson());
                    },
                    child: Container(
                      height: h * 0.060,
                      width: w * 0.3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(h * 0.01),
                          color: primaryColor),
                      child: Center(
                          child: Text(
                            "This Week",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: h * 0.02, color: Colors.white)),
                          )),
                    ),
                  ),
                  Column(
                    children: [
// Container(
//     height: h * 0.050,
//     width: w * 0.340,
//     child: CustomDropdown(
//       borderRadius: BorderRadius.circular(h * 0.01),
//       fieldSuffixIcon: Icon(
//         Icons.arrow_drop_down_outlined,
//         color: Colors.white,
//         size: h * 0.035,
//       ),
//       listItemStyle: TextStyle(fontSize: w * 0.025),
//       selectedStyle: TextStyle(
//           fontSize: w * 0.025, color: Colors.white),
//       fillColor: primaryColor,
//       hintStyle: TextStyle(
//           fontSize: h * 0.015, color: Colors.white),
//       items: items,
//       controller: hi,
//     )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Container(
                      height: h * 0.060,
                      width: w * 0.400,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(h * 0.01),
                            bottomLeft: Radius.circular(h * 0.01)),
                      ),
                      child: TextField(
                          controller: dateInput,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: primaryColor,
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
                                  DateFormat('dd/MM/yyyy').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              setState(() {
                                dateInput.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            }
                          })),
                  Container(
                      height: h * 0.060,
                      width: w * 0.400,
                      decoration: BoxDecoration(
                          border: Border.all(color: primaryColor),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(h * 0.01),
                              bottomRight: Radius.circular(h * 0.01))),
                      child: TextField(
                          controller: EndDate,
                          decoration: InputDecoration(
                              icon: Icon(
                                Icons.calendar_today,
                                color: primaryColor,
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
                                  DateFormat('dd/MM/yyyy').format(pickedDate);

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
                    height: h * 0.060,
                    width: w * 0.139,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(h * 0.01),
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
              Expanded(
                flex: 0,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 75,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20
                        ),
                    itemCount: overview.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                        onTap: () {
                          index==0?widget.controller.animateTo(1):SizedBox();
print(widget.controller);print('touched');
index==2?Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductsDetails())):index==3?Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandDetails())):SizedBox();

                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: primaryColor,
                                    blurRadius: 3,
                                    spreadRadius: 0,
                                    offset: Offset(0, 1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(h * 0.01)),
                          child: Padding(
                            padding: EdgeInsets.all(w * 0.02),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: h * 0.05,
                                    width: w * 0.10,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent),
                                    child: SvgPicture.asset(
                                        overview[index]["icon"])),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.01),
                                  child: Text(
                                    overview[index]["text"],
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: h * 0.017)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
// Row(
//   children: [
//     SizedBox(width: w*0.02,),
//     Text("Orders Statistics",style: TextStyle(color: primaryColor,fontSize: h*0.015,fontWeight: FontWeight.bold),),
//     SizedBox(width: w*0.02,),
//     SizedBox(height: h*0.0020,width: w*0.25,child: DecoratedBox(decoration: BoxDecoration(color: primaryColor)),),
//     SizedBox(width: w*0.02,),
//     Column(
//       children: [
//         Container(height: h*0.050,width: w*0.340,
//             child: CustomDropdown(
//               fieldSuffixIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.white,size: h*0.035,),
//               listItemStyle: TextStyle(fontSize: w*0.025),
//               selectedStyle: TextStyle(fontSize: w*0.025,color: Colors.white),
//               fillColor: primaryColor,
//               hintStyle: TextStyle(fontSize:h*0.020,color: Colors.white),
//
//
//
//               items: items, controller:hi,
//             )
//         ),
//
//
//       ],
//     ),
//   ],
// ),
// SizedBox(height: h*0.02,),
// Container(
//   height: h*0.22,
//   child: Expanded(
//     flex: 0,
//     child: GridView.builder(shrinkWrap: true,
//         scrollDirection: Axis.vertical,
//         physics: ScrollPhysics(),
//
//
//
//         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//
//             maxCrossAxisExtent: 200,
//             mainAxisExtent: 40,
//             childAspectRatio: 3 / 2,
//             crossAxisSpacing: 10,
//             mainAxisSpacing: 20),
//         itemCount: order.length,
//         itemBuilder: (BuildContext ctx, index) {
//           return Container(
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//                 border: Border.all(color: primaryColor),
//
//                 borderRadius: BorderRadius.circular(h*0.01)),
//             child:Padding(
//               padding:  EdgeInsets.all(w*0.02),
//               child: Row(
//                 children: [
//                   Text(order[index]["text"],
//                     style: GoogleFonts.roboto(
//                       textStyle: TextStyle(color: Colors.black,
//                           fontWeight: FontWeight.bold,fontSize: h*0.015)
//                     ),),
//                 ],
//               ),
//             )
//           );
//         }),
//   ),
// ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Text(
                    "Action Tab",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 0.015,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.60,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: primaryColor)),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: primaryColor,
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  Container(
                    height: h * 0.07,
                    width: w * 0.460,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: primaryColor,
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(h * 0.01),
                        border: Border.all(color: primaryColor)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.01,
                        ),
                        CircleAvatar(
                          radius: h * 0.025,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: h * 0.023,
                            backgroundColor: Colors.white,
                            child: Text(
                              "RTO",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.019,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        Text(
                          "Return Requests",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: h * 0.012,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        Text("")
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w * 0.03,
                  ),
                  Container(
                    height: h * 0.07,
                    width: w * 0.460,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: primaryColor,
                              blurRadius: 2,
                              spreadRadius: 0,
                              offset: Offset(0, 1))
                        ],
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: primaryColor)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: w * 0.01,
                        ),
                        CircleAvatar(
                          radius: h * 0.025,
                          backgroundColor: primaryColor,
                          child: CircleAvatar(
                            radius: h * 0.023,
                            backgroundColor: Colors.white,
                            child: Text(
                              "RTO",
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.019,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor)),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        Text(
                          "Refund Requests",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontSize: h * 0.012,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          width: w * 0.02,
                        ),
                        Text("d")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Text(
                    "Pending Settlements",
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: h * 0.015,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  SizedBox(
                    height: h * 0.0020,
                    width: w * 0.40,
                    child: DecoratedBox(
                        decoration: BoxDecoration(color: primaryColor)),
                  ),
                  SizedBox(
                    width: w * 0.02,
                  ),
                  Icon(
                    Icons.arrow_drop_down_outlined,
                    color: primaryColor,
                  )
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                height: h * 0.07,
                width: w * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor,
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(h * 0.01),
                    border: Border.all(color: primaryColor)),
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.01,
                    ),
                    CircleAvatar(
                      radius: h * 0.025,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: h * 0.024,
                        backgroundColor: Colors.white,
                        child: Text(
                          "SEL",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: h * 0.019,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      "Refferral payouts",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: h * 0.016,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      width: w * 0.180,
                    ),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                height: h * 0.07,
                width: w * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor,
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(h * 0.01),
                    border: Border.all(color: primaryColor)),
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.01,
                    ),
                    CircleAvatar(
                      radius: h * 0.025,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: h * 0.024,
                        backgroundColor: Colors.white,
                        child: Text(
                          "Aff",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: h * 0.019,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      "Affiliate payouts",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: h * 0.016,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      width: w * 0.180,
                    ),
                    Text("")
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                height: h * 0.07,
                width: w * 1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: primaryColor,
                          blurRadius: 2,
                          spreadRadius: 0,
                          offset: Offset(0, 1))
                    ],
                    borderRadius: BorderRadius.circular(h * 0.01),
                    border: Border.all(color: primaryColor)),
                child: Row(
                  children: [
                    SizedBox(
                      width: w * 0.01,
                    ),
                    CircleAvatar(
                      radius: h * 0.027,
                      backgroundColor: primaryColor,
                      child: CircleAvatar(
                        radius: h * 0.024,
                        backgroundColor: Colors.white,
                        child: Text(
                          "SEL",
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: h * 0.019,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Text(
                      "Seller Payout",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: h * 0.016,
                              fontWeight: FontWeight.bold,
                              color: primaryColor)),
                    ),
                    SizedBox(
                      width: w * 0.180,
                    ),
                    Text("")
                  ],
                ),
              ),
              // BarChartSample3()
            ]),
          ),
        ),
      ),
    );
  }
}
// SingleChildScrollView(
// child: Padding(
// padding: EdgeInsets.all(w * 0.02),
// child: Column(children: [
// SizedBox(
// height: h * 0.03,
// ),
// Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Overview",
// style: TextStyle(
// color: primaryColor,
// fontSize: h * 0.015,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// SizedBox(
// height: h * 0.0020,
// width: w * 0.36,
// child: DecoratedBox(
// decoration: BoxDecoration(color: primaryColor)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Column(
// children: [
// // Container(
// //     height: h * 0.050,
// //     width: w * 0.340,
// //     child: CustomDropdown(
// //       borderRadius: BorderRadius.circular(h * 0.01),
// //       fieldSuffixIcon: Icon(
// //         Icons.arrow_drop_down_outlined,
// //         color: Colors.white,
// //         size: h * 0.035,
// //       ),
// //       listItemStyle: TextStyle(fontSize: w * 0.025),
// //       selectedStyle: TextStyle(
// //           fontSize: w * 0.025, color: Colors.white),
// //       fillColor: primaryColor,
// //       hintStyle: TextStyle(
// //           fontSize: h * 0.015, color: Colors.white),
// //       items: items,
// //       controller: hi,
// //     )),
// ],
// ),
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// Container(
// height: h * 0.060,
// width: w * 0.400,
// decoration: BoxDecoration(
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topLeft: Radius.circular(h * 0.01),
// bottomLeft: Radius.circular(h * 0.01)),
// ),
// child: TextField(
// controller: dateInput,
// decoration: InputDecoration(
// icon: Icon(
// Icons.calendar_today,
// color: primaryColor,
// ),
// border: InputBorder.none),
// readOnly: true,
// onTap: () async {
// DateTime? pickedDate = await showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime(1950),
// //DateTime.now() - not to allow to choose before today.
// lastDate: DateTime(2100));
//
// if (pickedDate != null) {
// print(
// pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
// String formattedDate =
// DateFormat('dd/MM/yyyy').format(pickedDate);
// print(
// formattedDate); //formatted date output using intl package =>  2021-03-16
// setState(() {
// dateInput.text =
// formattedDate; //set output date to TextField value.
// });
// }
// })),
// Container(
// height: h * 0.060,
// width: w * 0.400,
// decoration: BoxDecoration(
// border: Border.all(color: primaryColor),
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(h * 0.01),
// bottomRight: Radius.circular(h * 0.01))),
// child: TextField(
// controller: EndDate,
// decoration: InputDecoration(
// icon: Icon(
// Icons.calendar_today,
// color: primaryColor,
// ),
// border: InputBorder.none),
// readOnly: true,
// onTap: () async {
// DateTime? pickedDate = await showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate: DateTime(1950),
// //DateTime.now() - not to allow to choose before today.
// lastDate: DateTime(2100));
//
// if (pickedDate != null) {
// print(
// pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
// String formattedDate =
// DateFormat('dd/MM/yyyy').format(pickedDate);
//
// print(
// formattedDate); //formatted date output using intl package =>  2021-03-16
// setState(() {
// EndDate.text =
// formattedDate; //set output date to TextField value.
// });
// }
// })),
// SizedBox(
// width: w * 0.02,
// ),
// Container(
// height: h * 0.060,
// width: w * 0.139,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(h * 0.01),
// color: primaryColor),
// child: Center(
// child: Text(
// "Go",
// style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontSize: h * 0.02, color: Colors.white)),
// )),
// )
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Expanded(
// flex: 0,
// child: GridView.builder(
// shrinkWrap: true,
// physics: ScrollPhysics(),
// gridDelegate:
// const SliverGridDelegateWithMaxCrossAxisExtent(
// maxCrossAxisExtent: 200,
// mainAxisExtent: 100,
// childAspectRatio: 3 / 2,
// crossAxisSpacing: 10,
// mainAxisSpacing: 20),
// itemCount: overview.length,
// itemBuilder: (BuildContext ctx, index) {
// return InkWell(onTap: (){},
// child: Container(
// alignment: Alignment.center,
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: primaryColor,
// blurRadius: 3,
// spreadRadius: 0,
// offset: Offset(0, 1))
// ],
// // border: Border.all(color: primaryColor),
//
// borderRadius: BorderRadius.circular(h * 0.01)),
// child: Padding(
// padding: EdgeInsets.all(w * 0.02),
// child: Row(
// children: [
// Column(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// height: h * 0.05,
// width: w * 0.10,
// decoration: BoxDecoration(
// color: Colors.transparent),
// child: SvgPicture.asset(
// overview[index]["icon"])),
// SizedBox(
// height: h * 0.01,
// ),
// Padding(
// padding: EdgeInsets.only(left: w * 0.01),
// child: Text(
// overview[index]["text"],
// style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: h * 0.013)),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// );
// }),
// ),
// // Row(
// //   children: [
// //     SizedBox(width: w*0.02,),
// //     Text("Orders Statistics",style: TextStyle(color: primaryColor,fontSize: h*0.015,fontWeight: FontWeight.bold),),
// //     SizedBox(width: w*0.02,),
// //     SizedBox(height: h*0.0020,width: w*0.25,child: DecoratedBox(decoration: BoxDecoration(color: primaryColor)),),
// //     SizedBox(width: w*0.02,),
// //     Column(
// //       children: [
// //         Container(height: h*0.050,width: w*0.340,
// //             child: CustomDropdown(
// //               fieldSuffixIcon: Icon(Icons.arrow_drop_down_outlined,color: Colors.white,size: h*0.035,),
// //               listItemStyle: TextStyle(fontSize: w*0.025),
// //               selectedStyle: TextStyle(fontSize: w*0.025,color: Colors.white),
// //               fillColor: primaryColor,
// //               hintStyle: TextStyle(fontSize:h*0.020,color: Colors.white),
// //
// //
// //
// //               items: items, controller:hi,
// //             )
// //         ),
// //
// //
// //       ],
// //     ),
// //   ],
// // ),
// // SizedBox(height: h*0.02,),
// // Container(
// //   height: h*0.22,
// //   child: Expanded(
// //     flex: 0,
// //     child: GridView.builder(shrinkWrap: true,
// //         scrollDirection: Axis.vertical,
// //         physics: ScrollPhysics(),
// //
// //
// //
// //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
// //
// //             maxCrossAxisExtent: 200,
// //             mainAxisExtent: 40,
// //             childAspectRatio: 3 / 2,
// //             crossAxisSpacing: 10,
// //             mainAxisSpacing: 20),
// //         itemCount: order.length,
// //         itemBuilder: (BuildContext ctx, index) {
// //           return Container(
// //             alignment: Alignment.center,
// //             decoration: BoxDecoration(
// //                 border: Border.all(color: primaryColor),
// //
// //                 borderRadius: BorderRadius.circular(h*0.01)),
// //             child:Padding(
// //               padding:  EdgeInsets.all(w*0.02),
// //               child: Row(
// //                 children: [
// //                   Text(order[index]["text"],
// //                     style: GoogleFonts.roboto(
// //                       textStyle: TextStyle(color: Colors.black,
// //                           fontWeight: FontWeight.bold,fontSize: h*0.015)
// //                     ),),
// //                 ],
// //               ),
// //             )
// //           );
// //         }),
// //   ),
// // ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Action Tab",
// style: TextStyle(
// color: primaryColor,
// fontSize: h * 0.015,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// SizedBox(
// height: h * 0.0020,
// width: w * 0.60,
// child: DecoratedBox(
// decoration: BoxDecoration(color: primaryColor)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Icon(
// Icons.arrow_drop_down_outlined,
// color: primaryColor,
// )
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// Container(
// height: h * 0.07,
// width: w * 0.460,
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: primaryColor,
// blurRadius: 2,
// spreadRadius: 0,
// offset: Offset(0, 1))
// ],
// borderRadius: BorderRadius.circular(h * 0.01),
// border: Border.all(color: primaryColor)),
// child: Row(
// children: [
// SizedBox(
// width: w * 0.01,
// ),
// CircleAvatar(
// radius: h * 0.025,
// backgroundColor: primaryColor,
// child: CircleAvatar(
// radius: h * 0.023,
// backgroundColor: Colors.white,
// child: Text(
// "RTO",
// style: GoogleFonts.inter(
// textStyle: TextStyle(
// fontSize: h * 0.019,
// fontWeight: FontWeight.bold,
// color: primaryColor)),
// ),
// ),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Return Requests",
// style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontSize: h * 0.012,
// fontWeight: FontWeight.bold)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Text("d")
// ],
// ),
// ),
// SizedBox(
// width: w * 0.03,
// ),
// Container(
// height: h * 0.07,
// width: w * 0.460,
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: primaryColor,
// blurRadius: 2,
// spreadRadius: 0,
// offset: Offset(0, 1))
// ],
// borderRadius: BorderRadius.circular(5),
// border: Border.all(color: primaryColor)),
// child: Row(
// children: [
// SizedBox(
// width: w * 0.01,
// ),
// CircleAvatar(
// radius: h * 0.025,
// backgroundColor: primaryColor,
// child: CircleAvatar(
// radius: h * 0.023,
// backgroundColor: Colors.white,
// child: Text(
// "RTO",
// style: GoogleFonts.inter(
// textStyle: TextStyle(
// fontSize: h * 0.019,
// fontWeight: FontWeight.bold,
// color: primaryColor)),
// ),
// ),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Refund Requests",
// style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontSize: h * 0.012,
// fontWeight: FontWeight.bold)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Text("d")
// ],
// ),
// ),
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Row(
// children: [
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Pending Settlements",
// style: TextStyle(
// color: primaryColor,
// fontSize: h * 0.015,
// fontWeight: FontWeight.bold),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// SizedBox(
// height: h * 0.0020,
// width: w * 0.40,
// child: DecoratedBox(
// decoration: BoxDecoration(color: primaryColor)),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Icon(
// Icons.arrow_drop_down_outlined,
// color: primaryColor,
// )
// ],
// ),
// SizedBox(
// height: h * 0.02,
// ),
// Container(
// height: h * 0.07,
// width: w * 1,
// decoration: BoxDecoration(
// color: Colors.white,
// boxShadow: [
// BoxShadow(
// color: primaryColor,
// blurRadius: 2,
// spreadRadius: 0,
// offset: Offset(0, 1))
// ],
// borderRadius: BorderRadius.circular(h * 0.01),
// border: Border.all(color: primaryColor)),
// child: Row(
// children: [
// SizedBox(
// width: w * 0.01,
// ),
// CircleAvatar(
// radius: h * 0.025,
// backgroundColor: primaryColor,
// child: CircleAvatar(
// radius: h * 0.024,
// backgroundColor: Colors.white,
// child: Text(
// "SEL",
// style: GoogleFonts.inter(
// textStyle: TextStyle(
// fontSize: h * 0.019,
// fontWeight: FontWeight.bold,
// color: primaryColor)),
// ),
// ),
// ),
// SizedBox(
// width: w * 0.02,
// ),
// Text(
// "Settlement Amount",
// style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontSize: h * 0.016,
// fontWeight: FontWeight.bold,
// color: primaryColor)),
// ),
// SizedBox(
// width: w * 0.180,
// ),
// Text("d")
// ],
// ),
// ),
// ]),
// ),
// ),
