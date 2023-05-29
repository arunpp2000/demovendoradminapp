import 'package:demovendoradminapp/brands/rejectedList.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../globals/colors.dart';
import '../login/otplogin.dart';
import 'addBrand.dart';
import 'approvedList.dart';
import 'brandRequest.dart';

TabBar get _tabBar => TabBar(
  // isScrollable: true,
  indicatorColor: primaryColor,
  labelColor: Colors.black,
  labelStyle: GoogleFonts.roboto(
      textStyle:
      TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
  tabs: [
    const Tab(
      text: "Brands",
    ),
    const Tab(
      text: "Brand Requests",
    ),
    const Tab(
      text: "Approved List",
    ),
    const Tab(
      text: "Rejected Brand",
    )
  ],
);

class BrandTab extends StatefulWidget {
  const BrandTab({Key? key}) : super(key: key);

  @override
  State<BrandTab> createState() => _BrandTabState();
}

class _BrandTabState extends State<BrandTab> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;


    var primaryColor = const Color(0xff8C31FF);
    var Color2 = const Color(0xff601AB9);
    return DefaultTabController(
        length: 4,
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
              IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
            ],
            backgroundColor: primaryColor,
            title: Image.asset("assets/image 1.png"),
          ),
          body: TabBarView(
            children: [Brand(),Brandrequest()  ,Approvedlist(),  RejectedBrand()],
          ),
        ));
  }
}