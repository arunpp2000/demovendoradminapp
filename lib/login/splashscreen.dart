import 'dart:async';
import 'package:flutter/material.dart';

import '../main.dart';



var h;
var w;
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          PageRouteBuilder(pageBuilder: (context,_, __) =>   CheckVerification()));
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Image.asset('assets/tara1.png')),
    );
  }
}
