import 'package:demovendoradminapp/Report/salesByDate.dart';
import 'package:demovendoradminapp/Report/salesByProduct.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../globals/colors.dart';

import '../main.dart';

TabController? gTabController;

TabBar get _tabBar => TabBar(
  onTap: (value) {

  },
  indicatorColor: primaryColor,
  labelColor: Colors.black,
  labelStyle: GoogleFonts.roboto(
      textStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
  tabs: [
    Tab(
      text: "Sales by date",
    ),
    Tab(
      text: "Sales by Product",
    ),
  ],
  controller: gTabController,
);

class ReportTab extends StatefulWidget {
  const ReportTab({Key? key}) : super(key: key);

  @override
  State<ReportTab> createState() => _ReportTabState();
}

class _ReportTabState extends State<ReportTab>
    with SingleTickerProviderStateMixin {
  void initState() {
    super.initState();
    gTabController = TabController(length: 2, vsync: this);
    gTabController?.addListener(() {

    });
  }

  // @override
  // void dispose() {
  //   _tabController?.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {

    var primaryColor = const Color(0xff8C31FF);
    var Color2 = const Color(0xff601AB9);
    return DefaultTabController(
        length: 2,
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

            backgroundColor: primaryColor,
            title: Center(child: Text("Reports")),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, icon: const Icon(Icons.arrow_back)),
          ),
          body: TabBarView(
            controller: gTabController,
            // controller: _tabController,
            children: [
              salesByDate(),
              salesByProduct()
            ],
          ),
        ));
  }
}
