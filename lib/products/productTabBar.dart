import 'package:demovendoradminapp/products/pendingProducts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../../globals/colors.dart';
import '../../../login/otplogin.dart';
import 'addColor.dart';
import 'addProduct.dart';
import 'addProductAttribute.dart';
import 'importProductList.dart';
import 'invendoryList.dart';

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
      text: "Product Attributes",
    ),
    Tab(text:"Color",),
    Tab(text:"Import Product List" ,)
  ],
);
class AddProductsDetails extends StatefulWidget {
  const AddProductsDetails({Key? key}) : super(key: key);

  @override
  State<AddProductsDetails> createState() => _AddProductsDetailsState();
}

class _AddProductsDetailsState extends State<AddProductsDetails> {
  @override
  Widget build(BuildContext context) {
    var  h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    var primaryColor = Color(0xff8C31FF);
    var Color2 = Color(0xff601AB9);
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            //
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
            // TabBar(tabs: [
            //   Tab(text: "Dashboard",),
            //   Tab(text: "Oders",),
            //   Tab(text: "Return Requests",)
            //
            // ],),

            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
            ],
            backgroundColor: primaryColor,
            title: Image.asset("assets/image 1.png"),
          ),
          body: TabBarView(

            children: [AddProducts(), PendingApproval(), InventoryList(),ProductAttributes(),ProductColor(),ImportProductList()],
          ),
        )
    );
  }
}