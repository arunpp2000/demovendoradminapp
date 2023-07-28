
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/navbar/orders/pickUpOrder/pickUpOrders.dart';
import 'package:demovendoradminapp/navbar/orders/quoteOrders/quoteOrders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../globals/colors.dart';
import 'sellerOrder/SellerOrder.dart';
import 'adminOrders/adminOders.dart';
TabBar get _tabBar=>TabBar(
  physics: ClampingScrollPhysics(),
  isScrollable:true,
  indicatorColor:primaryColor,
  labelColor: Colors.black,
  labelStyle:GoogleFonts.roboto(textStyle:TextStyle(fontSize: 14,fontWeight: FontWeight.bold) ) ,tabs: [

  Tab(text: "Admin Orders",),
  Tab(text: "Seller Orders",),
  Tab(text: "PickUp Orders",),
  Tab(text: "Quote Orders",)
],
);



class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();

}

class _OrdersState extends State<Orders> {


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  bool b2b=false;
  bool b2c=false;
  @override
  Widget build(BuildContext context) {
    var  h = MediaQuery.of(context).size.height;
    var  w = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back),
          bottom:PreferredSize(preferredSize:_tabBar.preferredSize, child: Material(color: Colors.white,
            child: _tabBar,) ,),
          title: Center(
            child: Text("Orders",
                style: TextStyle(
                  fontSize: h * 0.028,
                )),
          ),
          actions: [
            IconButton(
                onPressed: () {

                },
                icon: Icon(Icons.search_rounded))
          ],
          backgroundColor: primaryColor,),
        body: TabBarView(
          physics: ClampingScrollPhysics(),
          children: [
            AdminOrders(),
            SellerOrders(),
            PickUpOrders(),
            QuoteOrders(),
        ],),
      ),
    );
  }
}
