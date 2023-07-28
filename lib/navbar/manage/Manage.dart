import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../brands/brands.dart';
import '../../category/cateogryTab.dart';
import '../../globals/colors.dart';
import '../../login/splashscreen.dart';
import '../../products/productTab.dart';


class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  State<Manage> createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  List manage = [
    {
      "image": "assets/produ.svg",
      "color": Color(0xff367E18),
      "Text": "Products"
    },
    {
      "image": "assets/brands.svg",
      "color": Color(0xff2192FF),
      "Text": "Brands"
    },
    {
      "image": "assets/cat.svg",
      "color": Color(0xff003865),
      "Text": "Categories"
    },
    {"image": "assets/Deals.svg", "color": Color(0xff59CE8F), "Text": "Deals"},
    {
      "image": "assets/coupon.svg",
      "color": Color(0xff540375),
      "Text": "Coupons"
    },
    {
      "image": "assets/tax.svg",
      "color": Color(0xff000000),
      "Text": "Tax Category"
    },
    {
      "image": "assets/campaign.svg",
      "color": Color(0xffFF3D00),
      "Text": "Campaign"
    },
    {
      "image": "assets/logic.svg",
      "color": Color(0xffB33030),
      "Text": "Logistics"
    },
    {
      "image": "assets/tracking.svg",
      "color": Color(0xff0B4619),
      "Text": "Tracking"
    },
    {
      "image": "assets/reviews.svg",
      "color": Color(0xffFF8E00),
      "Text": "Reviews"
    },
    {
      "image": "assets/media.svg",
      "color": Color(0xff6C00FF),
      "Text": "Media Library"
    },
    {
      "image": "assets/sellerpackages.svg",
      "color": Color(0xffF55C47),
      "Text": "Seller Packages"
    },
    {"image": "assets/faq.svg", "color": Color(0xff618289), "Text": "FAQ"},
    {
      "image": "assets/possystem.svg",
      "color": Color(0xff4D455D),
      "Text": "Pos System"
    },
    {
      "image": "assets/affiliate.svg",
      "color": Color(0xffCC00FF),
      "Text": "Affiliate"
    },
  ];
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
            child: Text("Manage",
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
          height: h * 1.40,
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
                  "Manage",
                  style: TextStyle(
                    fontSize: w * 0.045,
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
                Expanded(
                  flex: 0,
                  child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              mainAxisExtent: 101,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 20),
                      itemCount: manage.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                          onTap: (){
                            index==0?Navigator.push(context, MaterialPageRoute(builder: (context)=>AddProductsDetails())):index==1?Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandDetails())):index==2?Navigator.push(context, MaterialPageRoute(builder: (context)=>CatogoryTabs())):SizedBox();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: w * 0.05,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    radius: w * 0.070,
                                    backgroundColor: manage[index]
                                        ["color"],
                                    child: SvgPicture.asset(
                                      manage[index]["image"],
                                      height: h * 0.03,
                                    )),
                                SizedBox(
                                  height: h * 0.01,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: w * 0.02),
                                  child: Text(
                                    manage[index]["Text"],
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            fontSize: h * 0.011,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Text(
                  "Settlements",
                  style: TextStyle(
                    fontSize: w * 0.045,
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
                Row(
                  children: [
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/payout.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Payouts",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.012)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/Refund.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Refund",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.012)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h * 0.02,
                ),
                Text(
                  "Reports",
                  style: TextStyle(
                    fontSize: w * 0.045,
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
                Row(
                  children: [
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/drawerReports/2SELL.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Seller Sales Report",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: h * 0.014,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/commission.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Commission History",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: h * 0.014,
                                    fontWeight: FontWeight.bold)),
                          )
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
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/productstock.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Product Stock",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: h * 0.014,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: w * 0.03,
                    ),
                    Container(
                      height: h * 0.07,
                      width: w * 0.440,
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
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: SvgPicture.asset(
                              "assets/wishlist.svg",
                              height: h * 0.03,
                            ),
                          ),
                          Text(
                            "Product Wishlist",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: h * 0.014,
                                    fontWeight: FontWeight.bold)),
                          )
                        ],
                      ),
                    ),

                  ],
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
