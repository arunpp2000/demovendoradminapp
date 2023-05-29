import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../globals/colors.dart';
import '../../login/otplogin.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {

  bool b2b=false;
  bool b2c=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, Color(0xff601AB9)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Center(
          child: Text("My Account",
              style: TextStyle(
                fontSize: h * (0.025),
              )),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              "assets/drawerAdminSection/logout.svg",
              color: Colors.white,
              height: h * 0.03,
            ),
          ),

        ],
      ),
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          Stack(children: [
            Container(
              height: h*0.30,
              width: w,
              decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
            ),
            Container(
              height: h*0.1,
              width: w*0.2,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/Group 452.png"),
                      fit: BoxFit.fill)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                      ),
                      Text(
                        "Seller - Manager",
                        style: TextStyle(
                            fontSize: w*0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: w*0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Seller - Manager",
                        style: TextStyle(
                            fontSize: w*0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        // currentUser?.Fullname ??
                        "name",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        // currentUser?.Fullname ??
                        "number",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        // currentUser?.Fullname ??
                        "email",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      SizedBox(
                        width: w*0.3,
                        height: h*0.0020,
                        child: const DecoratedBox(
                          decoration:
                          const BoxDecoration(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Text(
                        "Plan:",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Expires : Never",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        "Account Balance :",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            )
          ]),


        ],
      ),
    );
  }
}
