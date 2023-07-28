
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/navbar/request/requestManage.dart';
import 'package:demovendoradminapp/navbar/tabbarview/tabbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../globals/colors.dart';
import '../main.dart';
import '../model/adminModel.dart';
import '../model/usermodel.dart';
import 'account/Account.dart';
import 'manage/Manage.dart';
import 'orders/orders.dart';
import 'package:http/http.dart' as http;

var token;
Map brandIdtoName = {};

Map brandNametoId = {};
List<String> brand1 = [];
Map categoryNametoId = {};
Map catIdToName = {};

List<String> categoryList = [];
Map parentCategoryNametoId = {};
Map parentCatIdToName = {};

List<String> parentCategoryList = [];


setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}
class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Tabbar(),
    Orders(),
    ManageRequest(),
    Manage(),
    Account()
  ];

  getCurrentUser() async {
    FirebaseFirestore.instance
        .collection('vendor')
    .doc('bGa7yjwM1DV4hPpbqksXEoh6DEb2')
        .snapshots()
        .listen((event) {
        currentUser = UserModel.fromJson(event.data()??{});
      if (mounted) {
        setState(() {});
        print(currentUser?.id);
      }
    });
  }


getBrand() {
  FirebaseFirestore.instance
      .collection("brands")
      .where('vendorId', isEqualTo: currentUser?.id)
      .get()
      .then((value) {
    brand1=[];
    for (DocumentSnapshot doc in value.docs) {
      brandNametoId[doc.get("brand")] = doc.id;
      brandIdtoName[doc.id]=doc['brand'];
      brand1.add(doc['brand']);
    }
    setState(() {});

  });

}

getCategory() {
  FirebaseFirestore.instance
      .collection("category")
      .where('vendorId', isEqualTo: currentUser?.id)
      .get()
      .then((value) {
    categoryList=[];
    for (DocumentSnapshot doc in value.docs) {
      categoryList.add(doc['name']);
      categoryNametoId[doc.get("name")] = doc.id;
      catIdToName[doc.id]=doc['name'];
    }
    setState(() {});
  });
}
getParentCategory(){
  FirebaseFirestore.instance
      .collection("category")
       // .where('status',isEqualTo: 1)
      // .where('delete',isEqualTo: false)
      .get()
      .then((value) {
    parentCategoryList=[];
    for (DocumentSnapshot doc in value.docs) {
      parentCategoryList.add(doc['name']);
      parentCategoryNametoId[doc.get("name")] = doc.id;
      parentCatIdToName[doc.id]=doc['name'];
    }
    setState(() {});
  });

}

  getAdmin() async {
    FirebaseFirestore.instance
        .collection('admin_users')
        .doc(adminId)
        .snapshots()
        .listen((event) {
      AdminUser = AdminModel.fromJson(event.data()!);
      if (mounted) {
        setState(() {});
        print(currentUser?.id);
      }
    });
  }


  getToke() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST',
        Uri.parse('https://apiv2.shiprocket.in/v1/external/auth/login'));
    request.body = json.encode(
        {"email": "akkuashkar158@gmail.com", "password": "firstlogic123"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Map<String, dynamic> body =
      json.decode(await response.stream.bytesToString());
      print(body['token']);
      token = body['token'];
    } else {
      print(response.reasonPhrase);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getAdmin();
    getToke();

    getParentCategory();
  }
  @override
  Widget build(BuildContext context) {
       // h = MediaQuery.of(context).size.height;
       // w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 70,
        decoration: BoxDecoration(
          color: primaryColor,
         // color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              color: Colors.white.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
            child: GNav(
              tabBorder: Border(),
              backgroundColor: primaryColor,
              //rippleColor: Colors.grey[300]!,
              rippleColor: primaryColor,
              hoverColor: primaryColor,
              gap: 3,
              activeColor: primaryColor,
               iconSize:25 ,
              padding: EdgeInsets.symmetric(horizontal: 3, vertical: 15),
              // duration: Duration(milliseconds: 400),
              tabBackgroundColor:Colors.white,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.dashboard,
                  text: 'Dashboard',
                ),
                GButton(

                  icon: Icons.shopping_cart,
                  text: 'Orders',
                ),
                GButton(
                  icon: Icons.chat_outlined,
                  text: 'Requests',
                ),
                GButton(
                  icon: Icons.manage_accounts_outlined,
                  text: 'Manage',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Account',
                ),

              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}







