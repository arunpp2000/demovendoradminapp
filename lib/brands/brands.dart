
import 'package:demovendoradminapp/brands/rejectedBrand.dart';
import 'package:demovendoradminapp/brands/sellerBrands.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../category/cateogryTab.dart';
import '../globals/colors.dart';
import 'adminBrands.dart';
import 'approvedlist.dart';
import 'AddBrand.dart';
import 'brandRequest.dart';
TabController? globalTabController;
TabBar get _tabBar => TabBar(
  isScrollable: true,

  onTap: (value) {
    reEdit=-5;
  },
      indicatorColor: primaryColor,
      labelColor: Colors.black,
      labelStyle: GoogleFonts.roboto(
          textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      tabs: [
         Tab(
          text: "Brands",
        ),
         Tab(
          text: "Brand Requests",
        ),
        const Tab(
          text: "Approved List",
        ),
         Tab(
          text: "Rejected Brand",
        ),Tab(
          text: "Admin Brand",
        ),Tab(
          text: "Seller Brand",
        )
      ],
      controller: globalTabController,
    );

class BrandDetails extends StatefulWidget {
  const BrandDetails({Key? key}) : super(key: key);

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails>
    with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    globalTabController = TabController(length:6 , vsync: this);

  }

  @override
  void dispose() {
    globalTabController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    var primaryColor = const Color(0xff8C31FF);
    var Color2 = const Color(0xff601AB9);
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          // drawer: NewDrawer(),
          appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
            // TabBar(tabs: [
            actions: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.search_rounded))
            ],
            backgroundColor: primaryColor,
            title: Image.asset("assets/image 1.png"),
          ),
          body: TabBarView(
            controller: globalTabController,
            // controller: _tabController,
            children: [
              Brand(),
              Brandrequest(),
              Approvedlist(),
              RejectedBrand(),
              AdminBrands(),
              SellerBrands(),
            ],
          ),
        ));
  }
}
