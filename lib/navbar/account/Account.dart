import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../../model/adminModel.dart';
import '../../model/usermodel.dart';


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List account = [{}];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/Logout.svg",
              height: h * 0.03,
              color: Colors.white,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Center(
          child: Text(
            "My Account",
            style:
            GoogleFonts.roboto(textStyle: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(clipBehavior: Clip.none, children: [
              Container(
                height: h / 3,
                width: w,
                decoration: BoxDecoration(color: primaryColor),
              ),
              Container(
                height: h / 3,
                width: w / 1.8,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/Group 452.png"),
                        fit: BoxFit.fill)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h * 0.3,
                  width: w,
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(AdminUser?.photo??''),
                                radius: w * 0.1,
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),

                            ],
                          ),
                          SizedBox(
                            width: w * 0.02,
                          ),
                          Container(
                            height: h * 0.15,
                            width: w * 0.53,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Text("Seller- ${"Manage"}",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: h * 0.015,
                                            fontWeight: FontWeight.bold))),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Text(AdminUser?.name ?? "",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: h * 0.014,
                                        ))),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Text(AdminUser?.email ?? "",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: h * 0.014,
                                        ))),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20))),
                                  builder: (
                                      BuildContext context,
                                      ) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: h*0.07,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),topRight:
                                              Radius.circular(20))),

                                          child:
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [

                                                Text("CONTACT INFORMATION",
                                                    style: GoogleFonts.roboto(
                                                        textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: h * 0.015,
                                                        ))),
                                                SvgPicture.asset("assets/Close.svg",color: Colors.white,)

                                              ],),
                                          ), ),
                                        Padding(
                                          padding:  EdgeInsets.only(left: w*0.1,right: w*0.1,top: h*0.02),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,




                                            children: [
                                              Text("Role:",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: h * 0.015,
                                                      ))),
                                              Text("Seller-Manager",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: h * 0.015,
                                                      ))),
                                              SizedBox(height: h*0.02,),
                                              Text("Full Name",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: h * 0.015,
                                                      ))),
                                              TextFormField(
                                                decoration: const InputDecoration(

                                                  hintText: 'Name',

                                                ),

                                              ),
                                              SizedBox(height: h*0.02,),
                                              Text("Mobile Number",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: h * 0.015,
                                                      ))),

                                              TextFormField(
                                                decoration: const InputDecoration(


                                                  hintText: 'Mobile Number',

                                                ),

                                              ),
                                              SizedBox(height: h*0.02,),
                                              Text("Email Address ",
                                                  style: GoogleFonts.roboto(
                                                      textStyle: TextStyle(
                                                        color: Colors.grey.shade500,
                                                        fontSize: h * 0.015,
                                                      ))),
                                              TextFormField(
                                                decoration: const InputDecoration(

                                                  hintText: 'Name',

                                                ),

                                              ),
                                              SizedBox(height: h*0.02,),
                                              Container(
                                                height: h*0.05,width: w,
                                                decoration: BoxDecoration(color: primaryColor,borderRadius: BorderRadius.circular(5)),
                                                child:Center(
                                                  child: Text("Save ",
                                                      style: GoogleFonts.roboto(
                                                          textStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: h * 0.015,
                                                          ))),
                                                ), )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: h*0.011,),
                                        Container(height: h*0.03,width: w,
                                          decoration: BoxDecoration(color: primaryColor,
                                              borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5))),)

                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              height: h * 0.04,
                              width: w * 0.2,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text("Edit",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: primaryColor,
                                            fontSize: h * 0.015,
                                            fontWeight: FontWeight.bold))),
                              ),
                            ),
                          )
                        ],
                      ),
                      Divider(
                        thickness: h * 0.0005,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: h * 0.005,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Plan: ${"Basic"}",
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: h * 0.015,
                                      ))),
                              SizedBox(
                                height: h * 0.015,
                              ),
                              Text("Expires: ${"Never"}",
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: h * 0.015,
                                      ))),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: h * 0.04,
                                width: w * 0.2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text("Upgrade",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: primaryColor,
                                              fontSize: h * 0.015,
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.01,
                              ),
                              Text("Account Balance: ${"2000"}",
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: h * 0.015,
                                      ))),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Stack(clipBehavior: Clip.none, children: [
              Container(
                height: h / 2.15,
                width: w,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.06,
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/companyDetails.svg",
                          height: h * 0.04,
                        ),
                        title: Text("Company Details",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/payout.svg",
                          height: h * 0.04,
                        ),
                        title: Text("Payouts",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/campaign.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Campaign",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/coupon.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Coupons",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/Deals.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Deals",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/Refund.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Refund",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/subscibtions.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("My Subscibtions",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/reviews.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Reviews",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/Disputes.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Dispute",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/reports.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Reports",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("FAQ",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("FAQ",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Product Listings",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Terms & Conditions",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Privacy Policy",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Return & Delivery Policy",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Refunds & Payment Policy",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("IP-Infringements",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("Anti-Counterfeiting Policy",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          "assets/faq.svg",
                          height: h * 0.04,
                          color: primaryColor,
                        ),
                        title: Text("About App",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.015,
                                ))),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: h * 0.4,
                right: w * 0.01,
                left: w * 0.01,
                child: Container(
                  height: h/9.5,
                  width: w,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: w * 0.03,
                          spreadRadius: w * 0.005,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            CircleAvatar(
                              radius: w * 0.06,
                              backgroundColor: primaryColor,
                              child: SvgPicture.asset(
                                "assets/orders.svg",
                                color: Colors.white,
                                height: h * 0.03,
                              ),
                            ),
                            Text("Orders",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: h * 0.015,
                                    ))),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: w * 0.06,
                              backgroundColor: primaryColor,
                              child: SvgPicture.asset(
                                "assets/produ.svg",
                                color: Colors.white,
                                height: h * 0.03,
                              ),
                            ),
                            Text("Products",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: h * 0.015,
                                    ))),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: w * 0.06,
                              backgroundColor: primaryColor,
                              child: SvgPicture.asset(
                                "assets/brands.svg",
                                color: Colors.white,
                                height: h * 0.03,
                              ),
                            ),
                            Text("Brands",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: h * 0.015,
                                    ))),
                          ],
                        ),
                        Column(
                          children: [
                            CircleAvatar(
                              radius: w * 0.06,
                              backgroundColor: primaryColor,
                              child: SvgPicture.asset(
                                "assets/cat.svg",
                                color: Colors.white,
                                height: h * 0.03,
                              ),
                            ),
                            Text("Catagories",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: primaryColor,
                                      fontSize: h * 0.015,
                                    ))),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}