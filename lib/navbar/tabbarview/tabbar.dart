
import 'package:demovendoradminapp/navbar/tabbarview/seller_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../brands/brands.dart';
import '../../category/cateogryTab.dart';
import '../../globals/colors.dart';
import '../../login/googleLogin.dart';
import '../../products/productTab.dart';
import '../../widgets/drawer.dart';
import '../orders/adminOrders/adminOders.dart';
import '../orders/returnOrder/returnOrders.dart';
import '../orders/sellerOrder/SellerOrder.dart';
import 'newOders.dart';

late TabController tabController;
TabBar get _tabBar=>TabBar(
  controller: tabController,
  isScrollable: true,
  indicatorColor:primaryColor,
  labelColor: Colors.black,
  labelStyle:GoogleFonts.roboto(textStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.bold) ) ,tabs: [
  Tab(text: "Dashboard",),
  Tab(text: "Admin Orders",),
  Tab(text: "Admin Return Request",),
  Tab(text: "Admin Refund Request",)
],);

class Tabbar extends StatefulWidget {
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();

}

class _TabbarState extends State<Tabbar>with SingleTickerProviderStateMixin {
bool b2b=false;
bool b2c=false;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController =TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
   var  h = MediaQuery.of(context).size.height;
   var  w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        drawer: Drawer(
          // width: 300,
          width: w*.72,
          child: NewDrawer(),
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
        body: TabBarView(
           controller: tabController,

          children: [

          Dashboard(controller :tabController),
          AdminOrders(),
          ReturnRequest(),
          SellerOrders(),
        ],),
      ),
    );
  }
}
