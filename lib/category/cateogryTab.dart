import 'package:demovendoradminapp/category/sellerCategroy.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../globals/colors.dart';
import '../widgets/drawer.dart';
import 'AddCateogry.dart';
import 'RejectedCategory.dart';
import 'addCategory.dart';
import 'adminCategory.dart';
import 'approvedCategory.dart';
import 'categoryRequest.dart';
TabController? globalTabController1;
int reEdit=-2;
int reEdit1=-2;
TabBar get _tabBar => TabBar(

  onTap: (value) {
    // reEdit1=-5;
    // print(reEdit1);
  },
  isScrollable: true,
  controller: globalTabController1,
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
      text: "Category Request",
    ),
    const Tab(
      text: "Approved Category",
    ),
    const Tab(
      text: "Rejected Catogory",
    ),
    const Tab(
      text: "Admin Catogory",
    ),
    const Tab(
      text: "Seller Catogory",
    ),
  ],
);

class CatogoryTabs extends StatefulWidget {
  const CatogoryTabs({Key? key}) : super(key: key);

  @override
  State<CatogoryTabs> createState() => _CatogoryTabsState();
}

class _CatogoryTabsState extends State<CatogoryTabs> with SingleTickerProviderStateMixin{


  void initState() {
    super.initState();
    globalTabController1 = TabController(length: 6, vsync: this);
    globalTabController1?.addListener(() {
      print(globalTabController1);
    });
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
          
          // drawer:NewDrawer(),
          appBar: AppBar(
            leading:IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back)) ,
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
            controller: globalTabController1,
            children: [
              AddCategory(),
              CategoryRequest(),
              ApprovedCategory(),
              RejectedCategory(),
              AdminCategory(),
              SellerCategory(),
            ],
          ),
        ));
  }
}
