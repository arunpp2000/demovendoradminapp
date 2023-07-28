import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/navbar/request/productRequest.dart';
import 'package:demovendoradminapp/navbar/request/sellerRequests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../Navbar.dart';

class ManageRequest extends StatefulWidget {
  const ManageRequest({Key? key}) : super(key: key);

  @override
  State<ManageRequest> createState() => _ManageRequestState();
}

class _ManageRequestState extends State<ManageRequest> {
  int sellerPendingLength = 0;
  int productPendingLength = 0;
  getSellerRequest() {
    FirebaseFirestore.instance
        .collection('vendor')
        .where('status', isEqualTo: 0)
        .snapshots()
        .listen((event) {
      print('count');
      sellerPendingLength = event.docs.length;
      print(sellerPendingLength);

      if (mounted) {
        setState(() {});
      }
    });
  }

  getPendingProduct() {
    FirebaseFirestore.instance
        .collection('products')
        .where('status', isEqualTo: 0)
        .snapshots()
        .listen((event) {
      print('count');
      productPendingLength = event.docs.length;

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSellerRequest();
    getPendingProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, Color(0xff601AB9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          title: Center(
            child: Text("Manage Request",
                style: TextStyle(
                  fontSize: h * (0.025),
                )),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                height: h * 0.50,
                width: w * 1,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff8C31FF),
                        Color(0xff601AB9),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(w * 0.05),
                        bottomLeft: Radius.circular(w * 0.05))),
              ),
              Container(
                height: h * 0.30,
                width: w * 0.60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Group 452.png"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h * 1.34,
                  width: w * 1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: w * 0.01)
                      ],
                      borderRadius: BorderRadius.circular(w * 0.02)),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: h * 0.01,
                        ),
                        Text(
                          "Manage Request",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: w * 0.030,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: h * 0.002,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              "0",
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/1RTO.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Return Requests"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/2B2B.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("B2B Requests"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              sellerPendingLength.toString(),
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/3SELL.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Seller Requests"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerRequests()));
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/4REF.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: const Text("Referral Requests"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/5AFF.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: const Text("Affiliate Requests"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              productPendingLength.toString(),
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/6PRO.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Product Approval"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductRequest()));
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/7BRD.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Brand Approval"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/8CAM.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Campaign Request"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/9DEA.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Deals Request"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/10REF.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Refund"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/11SUP.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Support Request"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerManageRequest/12QOU.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Quote Request"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        SizedBox(
                          height: h * 0.01,
                        ),
                        Text(
                          "Support",
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: w * 0.030,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Divider(
                          color: primaryColor,
                          thickness: h * 0.002,
                        ),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerAdminSection/2sup.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Support"),
                          onTap: () {
                            //action on press
                          },
                        ),
                        ListTile(
                          trailing: Container(
                            height: h * 0.050,
                            width: w * 0.150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: primaryColor),
                            child: Center(
                                child: Text(
                              '0',
                              style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      fontSize: h * 0.02, color: Colors.white)),
                            )),
                          ),
                          leading: SvgPicture.asset(
                            "assets/drawerAdminSection/3dis.svg",
                            color: primaryColor,
                            height: h * 0.03,
                          ),
                          title: Text("Disputes"),
                          onTap: () {
                            //action on press
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])
          ]),
        ));
  }
}
