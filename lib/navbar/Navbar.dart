
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demovendoradminapp/navbar/request/requestManage.dart';
import 'package:demovendoradminapp/navbar/tabbarview/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../globals/colors.dart';
import '../model/usermodel.dart';
import 'account/Account.dart';
import 'manage/Manage.dart';
import 'orders/orders.dart';
var h;
var w;
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

        currentUser = UserModel.fromJson(event.data()!);
      if (mounted) {
        setState(() {});
        print(currentUser?.id);
        print('=============================');
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
       h = MediaQuery.of(context).size.height;
       w = MediaQuery.of(context).size.width;
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