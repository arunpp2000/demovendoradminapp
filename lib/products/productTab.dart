import 'package:demovendoradminapp/products/pendingApproval.dart';
import 'package:demovendoradminapp/products/productTabView/adminProducts.dart';
import 'package:demovendoradminapp/products/productTabView/approvedProducts.dart';
import 'package:demovendoradminapp/products/productTabView/rejectedProducts.dart';
import 'package:demovendoradminapp/products/productTabView/sellerProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../globals/colors.dart';

import '../widgets/drawer.dart';
import 'addProduct.dart';
import 'color.dart';
import 'importProductList.dart';
import 'inventoryList.dart';

TabBar get _tabBar => TabBar(
  isScrollable: true,
  indicatorColor: primaryColor,
  labelColor: Colors.black,
  labelStyle: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
  tabs: [
    Tab(
      text: "Add Products",
    ),
    Tab(
      text: "Pending Approval",
    ),
    Tab(
      text: "Inventory List",
    ),
    Tab(
      text: "Approved Products",
    ),
    Tab(
      text: "Rejected Products",
    ),
    Tab(
      text: "Admin Products",
    ),
    Tab(
      text: "Seller Products",
    ),

  ],
);

class AddProductsDetails extends StatefulWidget {
  const AddProductsDetails({Key? key}) : super(key: key);

  @override
  State<AddProductsDetails> createState() => _AddProductsDetailsState();
}

class _AddProductsDetailsState extends State<AddProductsDetails> {
  set(){
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    var primaryColor = Color(0xff8C31FF);
    var Color2 = Color(0xff601AB9);
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios_new_rounded)
              ,
            ),
            //
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: _tabBar,)
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
            ],
            backgroundColor: primaryColor,
            title: Image.asset("assets/image 1.png"),
          ),
          body: TabBarView(
            children: [
              AddProducts2(set: set,),
              PendingApproval(),
              InventoryList(set: set,),
              ApprovedProducts(),
              RejectedProducts(),
              AdminProducts(set: set,),
              SellerProducts(set: set,),

            ],
          ),
        ));
  }
}
