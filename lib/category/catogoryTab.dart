import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../globals/colors.dart';


import '../login/otplogin.dart';
import 'AddCateogry.dart';


TabBar get _tabBar => TabBar(
      indicatorColor: primaryColor,
      labelColor: Colors.black,
      labelStyle: GoogleFonts.roboto(
          textStyle:
              TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      tabs: [
        const Tab(
          text: "Add catogory",
        ),
        const Tab(
          text: "Catogory Approval",
        ),
        const Tab(
          text: "Rejected Catogory",
        ),
        
      ],
    );

class CatogoryTab extends StatefulWidget {
  const CatogoryTab({Key? key}) : super(key: key);

  @override
  State<CatogoryTab> createState() => _CatogoryTabState();
}

class _CatogoryTabState extends State<CatogoryTab> {
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
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Material(
                color: Colors.white,
                child: _tabBar,
              ),
            ),
            // TabBar(tabs: [


            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
            ],
            backgroundColor: primaryColor,
            title: Image.asset("assets/image 1.png"),
          ),
          body: TabBarView(
            children: [
              AddCategory()
            ],
          ),
        ));
  }
}
