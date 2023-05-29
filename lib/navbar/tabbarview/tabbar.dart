import 'package:demovendoradminapp/navbar/tabbarview/seller_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';





import '../../brands/brandTab.dart';
import '../../category/catogoryTab.dart';
import '../../globals/colors.dart';
import '../../login/googleLogin.dart';
import '../../products/productTabBar.dart';
import '../orders/sellerOrders.dart';
import 'newOders.dart';


TabBar get _tabBar=>TabBar(
  indicatorColor:primaryColor,
  labelColor: Colors.black,
  labelStyle:GoogleFonts.roboto(textStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.bold) ) ,tabs: [
  Tab(text: "Dashboard",),
  Tab(text: "Admin Orders",),
  Tab(text: "Seller Orders",)

],);

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();

}

class _TabbarState extends State<Tabbar> {
bool b2b=false;
bool b2c=false;
  @override
  Widget build(BuildContext context) {
   var  h = MediaQuery.of(context).size.height;
   var  w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: Drawer(
          // width: 300,
          width: w*.72,
          child: ListView(
            children: [
              Container(
                height: h*0.06,
                width: w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff8C31FF),
                        Color(0xff601AB9),
                      ],
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: w*0.02,
                    ),
                    Image(image: AssetImage("assets/tharacart.png")),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              Stack(children: [
                Container(
                  height: h*0.23,
                  width: w,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                ),
                Container(
                  height: h*0.1,
                  width: w*0.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Group 452.png"),
                          fit: BoxFit.fill)),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: w*0.05,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Seller - Manager",
                            style: TextStyle(
                                fontSize: w*0.035,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            // currentUser?.Fullname ??
                            "",
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          SizedBox(
                            width: w*0.3,
                            height: h*0.0020,
                            child: const DecoratedBox(
                              decoration:
                              const BoxDecoration(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.02,
                          ),
                          Text(
                            "Plan:",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Expires : Never",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Account Balance :",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ]),
              SizedBox(
                height: h * 0.02,
              ),
              Row(
                children: [
                  SizedBox(
                    width: w * 0.04,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        b2b = false;
                        b2c = true;
                      });
                    },
                    child: Container(
                      height: h * 0.050,
                      width: w * 0.35,
                      decoration: BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: w * 0.009,
                          ),
                        ],
                        color: b2c == true ? primaryColor : Colors.white,
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Expand Menu",
                          style: TextStyle(
                              color: b2b == true ? Colors.black : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        b2c = false;
                        b2b = true;
                      });
                    },
                    child: Container(
                        height: h * 0.050,
                        width: w * 0.33,
                        decoration: BoxDecoration(
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black,
                                blurRadius: w * 0.009,
                              ),
                            ],
                            color: b2b == true ? primaryColor : Colors.white,
                            border: Border.all(color: primaryColor),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                            )),
                        child: Center(
                            child: Text(
                              "Collapse Menu",
                              style: TextStyle(
                                  color: b2b == true ? Colors.white : Colors.black),
                            ))),
                  ),

                ],
              ),
              //Dashboard
              ExpansionTile(
                initiallyExpanded: b2b==true?false:true,
                title: Text("Dashboard"),
                leading: Icon(Icons.dashboard), //add icon
                children: [
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/ordericon.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("All Orders"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/ordericon.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Seller Orders"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/ordericon.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Admin Orders"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/ordericon.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("PickUp Orders"),
                    onTap: () {
                      //action on press
                    },
                  ),
                ],
              ),
              //manage
              ExpansionTile(
                initiallyExpanded: b2b == true ? false : true,

                title: Text("Manage"),
                leading: SvgPicture.asset(
                  "assets/manage.svg",
                  color: primaryColor,
                  height: h * 0.03,
                ), //add icon
                children: [

                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/produ.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Products"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddProductsDetails()));
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/brands.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Brands"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  BrandTab()));
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/campaign.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Campaign"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/cat.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Categories"),
                    onTap: () {
                      // action on press
                      Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>  CatogoryTab()));
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/coupon.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Coupons"),
                    onTap: () {
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/Deals.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Deals"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/logic.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Logistics"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/tracking.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Shipment Tracking"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/failedOrders.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Failed Orders"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/media.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Media Library"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/sellerpackages.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Seller Packages"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/drawerManage/reviews.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Reviews"),
                    onTap: (){
                      //action on press
                    },
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "assets/drawerManage/posSystem.svg",
                      color: primaryColor,
                      height: h * 0.03,
                    ),
                    title: Text("Pos System"),
                    onTap: (){
                      //action on press
                    },
                  ),
                ],
              ),
              //manageRequest
              ExpansionTile(
                  initiallyExpanded: b2b == true ? false : true,
                  title: Text("Manage Requests "),
                  leading: SvgPicture.asset(
                    "assets/requests.svg",
                    color: Colors.black54,
                    height: h * 0.03,
                  ), //add icon
                  children: [
                    ListTile(
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
                      leading: SvgPicture.asset(
                        "assets/drawerManageRequest/3SELL.svg",
                        color: primaryColor,
                        height: h * 0.03,
                      ),
                      title: Text("Seller Requests"),
                      onTap: () {
                        //action on press
                      },
                    ),
                    ListTile(
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
                      leading: SvgPicture.asset(
                        "assets/drawerManageRequest/6PRO.svg",
                        color: primaryColor,
                        height: h * 0.03,
                      ),
                      title: Text("Product Approval"),
                      onTap: () {
                        //action on press
                      },
                    ),
                    ListTile(
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
                  ]),
              //settlement
              ExpansionTile(
                  initiallyExpanded: b2b == true ? false : true,
                  title: Text("Settlements "),
                  leading: SvgPicture.asset(
                    "assets/requests.svg",
                    color: Colors.black54,
                    height: h * 0.03,
                  ), //add icon
                  children: [
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/drawerSettlement/1REF.svg",
                        height: h * 0.03,
                      ),
                      title: Text("Referral Payout"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/drawerSettlement/2AFF.svg",
                        height: h * 0.03,
                      ),
                      title: Text("Affliate Payout"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerSettlement/3SEL.svg",height: h*0.03,),
                      title: Text("Seller Payout"),
                      onTap: (){
                        //action on press
                      },
                    ),
                  ]
              ),
              //Reports
              ExpansionTile(
                  initiallyExpanded: b2b==true?false:true,
                  title: Text("Reports"),
                  leading: SvgPicture.asset("assets/requests.svg",color: Colors.black54,height: h*0.03,), //add icon
                  children: [
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/1ASR.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Admin Sales Report"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/2SELL.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Seller Sales Report"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/3COM.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Commission History"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/4PW.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Product Wishlist"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/5PS.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Product Stock"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerReports/6SEAR.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Search Queries"),
                      onTap: (){
                        //action on press
                      },
                    ),
                  ]
              ),
              //admin Section
              ExpansionTile(
                  initiallyExpanded: b2b==true?false:true,
                  title: Text("Admin Section"),
                  leading: SvgPicture.asset("assets/requests.svg",color: Colors.black54,height: h*0.03,), //add icon
                  children: [
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/1Pay.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Payments"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/2sup.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Support"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/3dis.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Disputes"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/4Roles.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Roles & Permisssion"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/5adminusers.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Admin Users"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/6users.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Users"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset("assets/drawerAdminSection/7settings.svg",color:primaryColor,height: h*0.03,),
                      title: Text("Settings"),
                      onTap: (){
                        //action on press
                      },
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "assets/drawerAdminSection/logout.svg",
                        color: primaryColor,
                        height: h * 0.03,
                      ),
                      title: Text("Logout"),
                      onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                        //action on press
                      },
                    ),
                  ]
              ),
              Container(
                height: h * 0.06,
                width: w,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff8C31FF),
                        Color(0xff601AB9),
                      ],
                    )),
                child: Center(
                    child: Text(
                      "App ver.1.2",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
        appBar: AppBar(
          bottom:PreferredSize(preferredSize:_tabBar.preferredSize, child: Material(color: Colors.white,
          child: _tabBar,) ,),
          actions: [
            IconButton(
                onPressed: () {
                },
                icon: Icon(Icons.search_rounded))
          ],
          backgroundColor: primaryColor,
          title: Image.asset("assets/image 1.png"),),
        body: TabBarView(children: [
          Dashboard(),
          AdminOrders(),
          SellerOrders(),
        ],),
      ),
    );
  }
}
